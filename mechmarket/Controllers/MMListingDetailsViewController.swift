//
//  MMListingDetailsViewController.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/18/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

final class MMListingDetailsViewController: UICollectionViewController {
    private var listingDetails: MMListing?
    let padding: CGFloat = 16
    
    static func configure(with listing: MMListing) -> MMListingDetailsViewController {
        let layout = GumGumHeaderLayout()
        let vc = MMListingDetailsViewController(collectionViewLayout: layout)
        vc.listingDetails = listing
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        collectionView.backgroundColor = .systemBackground
        setupCollectionView()
        setupLayout()
    }
    
    private func setupCollectionView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "id")
        collectionView.register(MMListingDetailsHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: MMListingDetailsHeaderView.reuseIdentifier)
    }
    
    private func setupLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
            
        }
    }
}

extension MMListingDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MMListingDetailsHeaderView.reuseIdentifier, for: indexPath) as? MMListingDetailsHeaderView {
            header.configure(with: listingDetails)
            header.delegate = self
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: view.frame.height / 2)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath)
        cell.backgroundColor = .systemBackground
        
        switch indexPath.item {
        case 0:
            let lbl = UILabel()
            lbl.font = UIFont(name: MM.FontNamed.HelveticaBold, size: 18)
            lbl.numberOfLines = 10
            lbl.textColor = .label
            lbl.text = listingDetails?.title
            lbl.translatesAutoresizingMaskIntoConstraints = false
            cell.addSubview(lbl)
            lbl.fillSuperview()
        case 1:
            let lbl = UILabel()
            lbl.font = UIFont(name: MM.FontNamed.HelveticaBold, size: 12)
            lbl.numberOfLines = 5
            lbl.textColor = .secondaryLabel
            lbl.text = listingDetails?.selftext
            lbl.translatesAutoresizingMaskIntoConstraints = false
            cell.addSubview(lbl)
            lbl.fillSuperview()        default:
            break
        }
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width - 2 * padding, height: 100)
    }
}

extension MMListingDetailsViewController: MMDetailsPageDelegate {
    func didTapClose() {
        dismiss(animated: true)
    }
}
