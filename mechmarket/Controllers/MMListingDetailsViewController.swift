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
//        let width = UIScreen.main.bounds.size.width
//        layout.estimatedItemSize = CGSize(width: width, height: 10)
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
        collectionView.register(MMDetailsPageTextCell.self, forCellWithReuseIdentifier: "titleid")
        collectionView.register(MMDetailsPageTextCell.self, forCellWithReuseIdentifier: "subtitleid")
        collectionView.register(MMButtonCollectionCell.self, forCellWithReuseIdentifier: MMButtonCollectionCell.reuseIdentifier)
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
        switch indexPath.item {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "titleid", for: indexPath) as? MMDetailsPageTextCell {
                cell.configure(with: listingDetails?.title, and: true)
                return cell
            }
        case 1:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subtitleid", for: indexPath) as? MMDetailsPageTextCell {
                cell.configure(with: listingDetails?.selftext, and: false)
                return cell
            }
        case 2:
            if let buttonCell = collectionView.dequeueReusableCell(withReuseIdentifier: MMButtonCollectionCell.reuseIdentifier, for: indexPath) as? MMButtonCollectionCell {
                buttonCell.configure(with: "Compose Message",
                                     bgColor: .systemBlue,
                                     textColor: .white,
                                     and: UIFont(
                                        name: MM.FontNamed.HelveticaBold,
                                        size: 18))
                return buttonCell
            }
        case 3:
            if let buttonCell = collectionView.dequeueReusableCell(withReuseIdentifier: MMButtonCollectionCell.reuseIdentifier, for: indexPath) as? MMButtonCollectionCell {
                buttonCell.configure(with: "Open in Reddit",
                                     bgColor: .systemGray ,
                                     textColor: .systemGray5,
                                     and: UIFont(
                                        name: MM.FontNamed.HelveticaBold,
                                        size: 18))
                return buttonCell
            }
        default:
            break
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 24
        let width = view.frame.width - padding
        
        switch indexPath.item {
        case 2:
            return CGSize(width: width, height: 36 * 1.5)
        case 3:
            return CGSize(width: width, height: 36 * 1.5)
        case 0:
            if let font = UIFont(name: MM.FontNamed.HelveticaBold, size: 18),
               let title = listingDetails?.title {
                let expectedHeight = heightForLabel(text: title, font: font, width: width)
             
                return CGSize(width: width, height: expectedHeight)
            } else { fallthrough }
        case 1:
            if let font = UIFont(name: MM.FontNamed.Helvetica, size: 12),
               let selftext = listingDetails?.selftext {
                let expectedHeight = heightForLabel(text: selftext, font: font, width: width)
             
                return CGSize(width: width, height: expectedHeight)
            } else { fallthrough }
        default:
            return CGSize(width: view.frame.width - 2 * padding, height: 50)
        }
    }
    
    func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(
            x: 0, y: 0,
            width: width,
            height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()

        return label.frame.height
    }
}

extension MMListingDetailsViewController: MMDetailsPageDelegate {
    func didTapClose() {
        dismiss(animated: true)
    }
}
