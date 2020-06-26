//
//  MMSellTradePage.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/9/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

class MMSellTradePage: UICollectionViewCell {
    static let reuseIdentifier = "MMSellTradePage"
    
    private lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return rc
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(MMSellTradeCollectionCell.self, forCellWithReuseIdentifier: MMSellTradeCollectionCell.reuseIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.refreshControl = self.refreshControl
        return cv
    }()
    
    private lazy var listings = [MMListing]()
    private lazy var afterId: String? = nil
    private lazy var dispatchGroup = DispatchGroup()
    private var selectedCountry: Country?
    weak var delegate: MMClassifiedsPageDelegate?
    private var isLoading = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(for origin: Country) {
        isLoading = true
        dispatchGroup.enter()
        refreshControl.beginRefreshing()
        selectedCountry = origin
        var listings = [MMListing]()
        MMService.shared.loadFeed(for: origin, and: .sellingOrTrading) { res in
            switch res {
            case .success(let data):
                self.afterId = data.after
                data.children.forEach {
                    listings.append($0.data)
                }
            case .failure(let err):
                print("Failed to fetch data:", err)
            }
            
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.listings = listings
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
            self.isLoading = false
        }
    }
    
    private func loadMore() {
        isLoading = true
        print("Going to start loading now...")
        if let id = afterId,
           let selectedCountry = selectedCountry {
            // footer loading spinner start
            dispatchGroup.enter()
            MMService.shared.loadMoreFeed(after: id, for: selectedCountry, and: .sellingOrTrading) { res in
                switch res {
                case .success(let data):
                    self.afterId = data.after
                    data.children.forEach {
                        self.listings.append($0.data)
                    }
                case .failure(let err):
                    print("Failed to load more data:", err)
                }
                
                self.dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                // footer loading spinner stop
                self.collectionView.reloadData()
                self.isLoading = false
            }
        }
    }
    
    private func setup() {
        backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: frame.height/7+15),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc func didPullToRefresh() {
        if let selectedCountry = selectedCountry {
            reload(for: selectedCountry)
        }
    }
}

extension MMSellTradePage: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item >= listings.count - listings.count/3 && !isLoading {
            print(listings.count)
            print(listings.count - listings.count/3)
            loadMore()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let listing = listings[indexPath.item]
        delegate?.didSelectMMPageCell(with: listing)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let listing = listings[indexPath.item]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MMSellTradeCollectionCell.reuseIdentifier, for: indexPath) as? MMSellTradeCollectionCell {
            cell.configure(with: listing)
            let imgView = CachedImageView()
            imgView.loadImage(urlString: listing.imageUrlString)
            imgView.contentMode = .scaleAspectFill
            cell.backgroundView = imgView
            return cell
        }
        
        return MMSellTradeCollectionCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let numberOfItemsPerRow:CGFloat = 2
        let spacing: CGFloat = 10
        let minLineSpacing = flowayout?.minimumLineSpacing ?? 0
        let totalSpacing = (2*minLineSpacing)+((numberOfItemsPerRow-1)*spacing)
        let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
        
        return CGSize(width: width, height: width)
    }
}

protocol MMClassifiedsPageDelegate: class {
    func didSelectMMPageCell(with listing: MMListing?)
}
