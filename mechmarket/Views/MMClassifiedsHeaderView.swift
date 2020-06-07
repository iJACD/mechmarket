//
//  MMClassifiedsHeaderView.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/6/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

final class MMClassifiedsHeaderView: UIView {
    private lazy var outerVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            headerTitleContainer,
            buttonHStack
        ])
        
        stack.distribution = .fillProportionally
        stack.spacing = 5
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var headerTitleContainer: UIView = {
        let v = UIView()
        v.heightAnchor.constraint(equalToConstant: 100).isActive = true
        v.backgroundColor = .blue
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var buttonHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            MMCategoryButton.configure(with: #selector(didTapBuying), from: self, color: .systemYellow, and: MM.ButtonTitles.buying),
            MMCategoryButton.configure(with: #selector(didTapSellTrade), from: self, color: .systemPurple, and: MM.ButtonTitles.sellOrTrade),
            MMCategoryButton.configure(with: #selector(didTapSold), from: self, color: .systemRed, and: MM.ButtonTitles.sold)
        ])
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapBuying() {
        print("Buying Tab")
    }
    
    @objc func didTapSellTrade() {
        print("SellTrade Tab")
    }
    
    @objc func didTapSold() {
        print("Sold Tab")
    }
    
    private func setup() {
        addSubview(outerVStack)
        outerVStack.fillSuperview()
    }
}

class MMCategoryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func configure(with action: Selector, from target: MMClassifiedsHeaderView, color: UIColor, and text: String) -> MMCategoryButton {
        let button = MMCategoryButton(frame: .zero)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.backgroundColor = color
        button.setTitle(text, for: .normal)
        return button
    }
    
    private func setup() {
        titleLabel?.font = UIFont(name: MM.FontNamed.HelveticaLight, size: 14)
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
}
