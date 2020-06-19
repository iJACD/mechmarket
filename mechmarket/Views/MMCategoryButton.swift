//
//  MMCategoryButton.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/15/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

class MMCategoryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func configure(color: UIColor, and text: String) -> MMCategoryButton {
        let button = MMCategoryButton(frame: .zero)
        button.backgroundColor = color
        button.setTitle(text, for: .normal)
        return button
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),
            widthAnchor.constraint(equalToConstant: 80)
        ])
        layer.cornerRadius = 20
        titleLabel?.font = UIFont(name: MM.FontNamed.HelveticaBold, size: 14)
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
}
