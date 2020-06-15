//
//  MMBuyingListCell.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/12/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

final class MMBuyingListCell: UITableViewCell {
    static let reuseIdentifier = "MMBuyingListCellId"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with listing: MMListing) {
        textLabel?.text = listing.title
        detailTextLabel?.text = "u/"+listing.author
        
        if !listing.imageUrlString.isEmpty {
            let imgView = CachedImageView()
            imgView.loadImage(urlString: listing.imageUrlString)
            imgView.contentMode = .scaleAspectFill
            accessoryView = imgView
            accessoryView?.layer.masksToBounds = true
            accessoryView?.layer.cornerRadius = 5
            accessoryView?.layer.borderWidth = 1
            accessoryView?.layer.borderColor = UIColor.secondaryLabel.cgColor
            accessoryView?.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        }
    }
    
    private func setup() {
        backgroundColor = .systemGray4
        
        textLabel?.textAlignment = .left
        textLabel?.numberOfLines = 3
        textLabel?.font = UIFont(name: MM.FontNamed.HelveticaBold, size: 18)
        textLabel?.textColor = .label
        
        detailTextLabel?.textAlignment = .left
        detailTextLabel?.font = UIFont(name: MM.FontNamed.HelveticaLight, size: 16)
        detailTextLabel?.textColor = .secondaryLabel
        
        layer.cornerRadius = 15
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemBlue.cgColor
    }
}
