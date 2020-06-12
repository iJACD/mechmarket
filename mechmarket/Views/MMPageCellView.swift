//
//  MMPageCellView.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/9/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

class MMPageCellView: UICollectionViewCell {
    static let reuseIdentifier = "MMPageCellView"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "id")
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private lazy var listings = [MMListing]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(with listings: [MMListing]) {
        self.listings = listings
        collectionView.reloadData()
    }
    
    private func setup() {
        collectionView.backgroundColor = .systemBackground
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: frame.height/7+15),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension MMPageCellView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let listing = listings[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath)
        cell.layer.cornerRadius = 25.0
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemPurple.cgColor // TODO: Determin color based on tab
        let imgView = UIImageView()
        let imageUrlString = listing.imageUrlString
   
        imgView.loadImage(using: imageUrlString)
        
        imgView.contentMode = .scaleAspectFill
        cell.backgroundView = imgView
        return cell
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
