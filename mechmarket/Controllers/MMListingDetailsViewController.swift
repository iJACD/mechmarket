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
    private lazy var gradientContainer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var mmOptionsButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(MM.Images.optionsButtonCircle, for: .normal)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTapOptions), for: .touchUpInside)
        return btn
    }()

    private lazy var mmCloseButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(MM.Images.closeButtonCircle, for: .normal)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return btn
    }()

    private lazy var tagLabel: MMFlairTagLabel = {
        let tag = MMFlairTagLabel(frame: .zero)
        return tag
    }()
        
    
    static func configure(with listing: MMListing) -> MMListingDetailsViewController {
        let layout = GumGumHeaderLayout()
        let vc = MMListingDetailsViewController(collectionViewLayout: layout)
        vc.listingDetails = listing
        
        if let flair = listing.getFlair {
            vc.tagLabel.configure(with: flair)
        }
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc func didTapClose() {
        dismiss(animated: true)
    }
    
    @objc func didTapOptions() {
        
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
        view.addSubview(gradientContainer)
        view.addSubview(mmCloseButton)
        view.addSubview(tagLabel)
        view.addSubview(mmOptionsButton)
        
        NSLayoutConstraint.activate([
            gradientContainer.topAnchor.constraint(equalTo: view.topAnchor),
            gradientContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mmCloseButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            mmCloseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                   
            mmOptionsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            mmOptionsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                   
            tagLabel.centerYAnchor.constraint(equalTo: mmCloseButton.centerYAnchor),
            tagLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.15]
        gradientContainer.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
        gradientLayer.frame.origin.y = 0
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 2:
            return
            // Provide a pop up saying feature not yet availble
        case 3:
            if let urlStr = listingDetails?.url,
                let url = URL(string: urlStr) {
                gotToUrl(url)
            }
        default:
            return
        }
    }
    
    func gotToUrl(_ url: URL) {
        UIApplication.shared.open(url)
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
