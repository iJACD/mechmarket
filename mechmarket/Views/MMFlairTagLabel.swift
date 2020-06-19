//
//  MMFlairTagLabel.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/18/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

class MMFlairTagLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with flair: MMFlair) {
        text = flair.description
        backgroundColor = color(for: flair)
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 25),
            widthAnchor.constraint(equalToConstant: 70)
        ])
        layer.cornerRadius = 12.5
        layer.masksToBounds = true
        font = UIFont(name: MM.FontNamed.HelveticaLight, size: 12)
        textColor = .white
        textAlignment = .center
    }
    
    private func color(for flair: MMFlair) -> UIColor {
        let color: UIColor
        
        switch flair {
        case .buying:
            color = .systemBlue
        case .selling:
            color = .systemPurple
        case .trading:
            color = .systemGreen
        case .sold:
            color = .systemRed
        case .purchased:
            color = .systemYellow
        default:
            color = .white
        }
        
        return color
    }
}
