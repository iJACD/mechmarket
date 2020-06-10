//
//  MMClassifiedsHeaderView.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/6/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

final class MMClassifiedsHeaderView: UIView {
    private let size: CGFloat = 60
    private lazy var outerVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            headerTitleContainer,
            buttonHStack
        ])
        
        stack.distribution = .fillProportionally
        stack.spacing = 0
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var headerTitleContainer: UIView = {
        let v = UIView()
        v.heightAnchor.constraint(equalToConstant: 85).isActive = true
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(mmRoundImageButton)
        v.addSubview(mmTitleLabel)
        NSLayoutConstraint.activate([
            mmRoundImageButton.centerYAnchor.constraint(equalTo: v.centerYAnchor),
            mmRoundImageButton.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 20),
            
            mmTitleLabel.centerYAnchor.constraint(equalTo: v.centerYAnchor),
            mmTitleLabel.leadingAnchor.constraint(equalTo: mmRoundImageButton.trailingAnchor, constant: 10)
        ])
        return v
    }()
    
    private lazy var mmRoundImageButton: MMRoundImageButton = {
        let btn = MMRoundImageButton.configure(with: size, and: 18)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var mmTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: MM.FontNamed.HelveticaBold, size: 24)
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var buyingButton: UIButton = MMCategoryButton.configure(color: .systemBlue, and: MM.ButtonTitles.buying)
    
    private lazy var sellingAndTradingButton: UIButton = MMCategoryButton.configure(color: .systemPurple, and: MM.ButtonTitles.sellOrTrade)
    
    private lazy var soldButton: UIButton = MMCategoryButton.configure(color: .systemRed, and: MM.ButtonTitles.sold)
    
    private lazy var buttonHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            buyingButton,
            sellingAndTradingButton,
            soldButton
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
    
    static func configure(with country: Country?) -> MMClassifiedsHeaderView {
        let header = MMClassifiedsHeaderView()
        if let country = country {
            header.mmTitleLabel.text = country.name
        }
        return header
    }
    
    func setSellingAndTradingButton(target action: Selector, from target: MMClassifiedsSwipeController) {
        sellingAndTradingButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func setBuyingButton(target action: Selector, from vc: MMClassifiedsSwipeController) {
        buyingButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func setSoldButton(target action: Selector, from vc: MMClassifiedsSwipeController) {
        soldButton.addTarget(target, action: action, for: .touchUpInside)
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
    
    static func configure(color: UIColor, and text: String) -> MMCategoryButton {
        let button = MMCategoryButton(frame: .zero)
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
