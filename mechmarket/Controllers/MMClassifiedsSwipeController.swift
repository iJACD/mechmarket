//
//  MMClassifiedsSwipeController.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/5/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

class MMClassifiedsSwipeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var selectedCountry: Country?
    private var selectedFlair: MMFlair?
    
    private lazy var listings = [MMListing]()
    private lazy var headerView: MMClassifiedsHeaderView = {
        let v = MMClassifiedsHeaderView.configure(with: selectedCountry)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var isInitialLoad: Bool = true
    
    static func configure(with country: Country) -> MMClassifiedsSwipeController {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let v = MMClassifiedsSwipeController(collectionViewLayout: layout)
        v.selectedCountry = country
        v.selectedFlair = .sellingOrTrading // First page to show.
        
        return v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MMSellTradePage.self, forCellWithReuseIdentifier: MMSellTradePage.reuseIdentifier)
        collectionView.register(MMBuyingPage.self, forCellWithReuseIdentifier: MMBuyingPage.reuseIdentifier)
        collectionView.register(MMSoldPage.self, forCellWithReuseIdentifier: MMSoldPage.reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        
        view.addSubview(headerView)
        headerView.setSellingAndTradingButton(target: #selector(didTapSellTrade), from: self)
        headerView.setBuyingButton(target: #selector(didTapBuying), from: self)
        headerView.setSoldButton(target: #selector(didTapSold), from: self)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: view.frame.height/7)
        ])
        
    }
    
    @objc func didTapBuying() {
        let indexPath = IndexPath(item: 0, section: 0)
        selectedFlair = .buying
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    @objc func didTapSellTrade() {
        let indexPath = IndexPath(item: 1, section: 0)
        selectedFlair = .sellingOrTrading
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    @objc func didTapSold() {
        let indexPath = IndexPath(item: 2, section: 0)
        selectedFlair = .soldOrPurchased
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isInitialLoad {
            let indexPath = IndexPath(item: 1, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            isInitialLoad = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MMBuyingPage.reuseIdentifier, for: indexPath) as? MMBuyingPage {
                if let selectedCountry = selectedCountry {
                    cell.reload(for: selectedCountry, and: .buying)
                }
                
                cell.backgroundColor = .systemBackground
                return cell
            }
        case 1:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MMSellTradePage.reuseIdentifier, for: indexPath) as? MMSellTradePage {
                if let selectedCountry = selectedCountry {
                    cell.reload(for: selectedCountry, and: .sellingOrTrading)
                }
                
                cell.backgroundColor = .systemBackground
                return cell
            }
        case 2:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MMSoldPage.reuseIdentifier, for: indexPath) as? MMSoldPage {
                if let selectedCountry = selectedCountry {
                    cell.reload(for: selectedCountry, and: .soldOrPurchased)
                }
                cell.backgroundColor = .systemBackground
                return cell
            }
        default:
            return UICollectionViewCell()
        }
            
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
}


