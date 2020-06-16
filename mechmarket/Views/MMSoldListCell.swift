//
//  MMSoldListCell.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/13/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

final class MMSoldListCell: UITableViewCell {
    static let reuseIdentifier = "MMSoldListCellId"
    
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
        layer.borderColor = UIColor.systemRed.cgColor
    }
}
