//
//  MMSellTradeCollectionCell.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/16/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

final class MMSellTradeCollectionCell: UICollectionViewCell {
    static let reuseIdentifier = "MMSellTradeCollectionCellId"
    
    private lazy var tagLabel: MMFlairTagLabel = {
        let tag = MMFlairTagLabel(frame: .zero)
        return tag
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with listing: MMListing) {
        if let flair = listing.getFlair {
            tagLabel.configure(with: flair)
        }
    }
    
    private func setup() {
        layer.cornerRadius = 25.0
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemPurple.cgColor
        
        addSubview(tagLabel)
        NSLayoutConstraint.activate([
            tagLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            tagLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
