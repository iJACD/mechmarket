//
//  CountryButtonCell.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/5/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

final class CountryButtonCell: UITableViewCell {
    static let countryButtonCellId = "countryButtonCellId"
    
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
        textLabel?.font = UIFont(name: MK.FontNamed.HelveticaBold, size: 28)
        textLabel?.textColor = .label
      
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            backgroundColor = .systemGreen
            textLabel?.textColor = .white
        } else {
            backgroundColor = .systemGray6
            textLabel?.textColor = .label
        }
    }
}
