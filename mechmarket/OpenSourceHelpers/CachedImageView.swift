  
//
//  UIImageView+Cache.swift
//  streamapp
//
//  Created by Brian Voong on 7/29/16.
//  Copyright © 2016 luxeradio. All rights reserved.
/*
   https://github.com/bhlvoong/LBTAComponents/blob/master/LBTAComponents/Classes/CachedImageView.swift
   */
import UIKit

/**
 A convenient UIImageView to load and cache images.
 */
open class CachedImageView: UIImageView {
    
    public static let imageCache = NSCache<NSString, DiscardableImageCacheItem>()
    
    open var shouldUseEmptyImage = true
    
    private var urlStringForChecking: String?
    private var emptyImage: UIImage?
    
    public convenience init(cornerRadius: CGFloat = 0, tapCallback: @escaping (() ->())) {
        self.init(cornerRadius: cornerRadius, emptyImage: nil)
        self.tapCallback = tapCallback
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleTap() {
        tapCallback?()
    }
    
    private var tapCallback: (() -> ())?
    
    public init(cornerRadius: CGFloat = 0, emptyImage: UIImage? = nil) {
        super.init(frame: .zero)
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        self.emptyImage = emptyImage
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Easily load an image from a URL string and cache it to reduce network overhead later.
     
     - parameter urlString: The url location of your image, usually on a remote server somewhere.
     - parameter completion: Optionally execute some task after the image download completes
     */

    open func loadImage(urlString: String, completion: (() -> ())? = nil) {
        image = nil
        var urlString = urlString
           let dispatchGroup = DispatchGroup()
           dispatchGroup.enter()
        if urlString.contains("imgur") && !urlString.contains(".jpg") && !urlString.contains(".png") {
               MMService.shared.getImgurDirectLink(from: urlString) { res in
                   switch res {
                   case .success(let string):
                       urlString = string
                   case .failure(let err):
                       print("Failed to load imgur link: ", err)
                   }
                   
                   dispatchGroup.leave()
               }
           } else {
               dispatchGroup.leave()
           }
        
        dispatchGroup.notify(queue: .main) {
        self.urlStringForChecking = urlString
        
        let urlKey = urlString as NSString
        
        if let cachedItem = CachedImageView.imageCache.object(forKey: urlKey) {
            self.image = cachedItem.image
            completion?()
            return
        }
        
        guard let url = URL(string: urlString) else {
            if self.shouldUseEmptyImage {
                self.image = self.emptyImage
            }
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    let cacheItem = DiscardableImageCacheItem(image: image)
                    CachedImageView.imageCache.setObject(cacheItem, forKey: urlKey)
                    
                    if urlString == self?.urlStringForChecking {
                        self?.image = image
                        completion?()
                    }
                }
            }
            
        }).resume()
            
        }
    }
}
