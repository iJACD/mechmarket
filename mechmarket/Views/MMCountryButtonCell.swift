//
//  CountryButtonCell.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/5/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

final class MMCountryButtonCell: UITableViewCell {
    static let reuseIdentifier = "countryButtonCellId"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with country: Country) {
        textLabel?.text = country.name
    }
    
    private func setup() {
        backgroundColor = .systemGray6
        
        textLabel?.textAlignment = .center
        textLabel?.font = UIFont(name: MM.FontNamed.HelveticaBold, size: 24)
        textLabel?.textColor = .secondaryLabel
      
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            backgroundColor = .systemGreen
            textLabel?.textColor = .systemBackground
        } else {
            backgroundColor = .systemGray6
            textLabel?.textColor = .secondaryLabel
        }
    }
}
