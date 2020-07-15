//
//  MMListingDetailsHeaderView.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/18/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

final class MMListingDetailsHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "MMListingDetailsHeaderViewId"
    
    lazy var imageView: CachedImageView = {
        let imgV = CachedImageView()
        imgV.contentMode = .scaleAspectFill
        return imgV
    }()
    
    private lazy var userNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: MM.FontNamed.HelveticaBold, size: 18)
        lbl.textColor = UIColor.white.withAlphaComponent(0.85)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with listing: MMListing?) {
        if let listing = listing {
            userNameLabel.text = "u/\(listing.author)"
            imageView.loadImage(urlString: listing.imageUrlString)
        }
    }
    
    private func setup() {
        addSubview(imageView)
        imageView.fillSuperview()
        backgroundColor = .systemGray4
        
        setupGradientLayer()
        setupElements()
    }
    
    private func setupElements() {
        addSubview(userNameLabel)
        NSLayoutConstraint.activate([
            userNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.75, 1]
        
        let gradientContainerView = UIView()
        gradientContainerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gradientContainerView)
        
        NSLayoutConstraint.activate([
            gradientContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientContainerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        gradientContainerView.layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.bounds
        gradientLayer.frame.origin.y -= bounds.height
    }
}
