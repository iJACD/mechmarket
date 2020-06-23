//
//  CountryButtonCell.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/5/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

final class MMButtonView: UIView {
    private lazy var textLabel: UILabel = {
        var lbl = UILabel()
        return lbl
    }()
    
    init(with title: String, and color: UIColor) {
        super.init(frame: .zero)
        textLabel.text = title
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(textLabel)
        textLabel.fillSuperview()
        
        backgroundColor = .systemGray6
        
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: MM.FontNamed.HelveticaBold, size: 24)
        textLabel.textColor = .secondaryLabel
      
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func updateButton(with color: UIColor?) {
        if let color = color { backgroundColor = color }
    }
    
    func updateLabel(with color: UIColor?) {
        if let color = color { textLabel.textColor = color }
    }
    
    func updateLabel(with font: UIFont?) {
        if let font = font { textLabel.font = font }
    }
}

class MMButtonTableCell: UITableViewCell {
    static let reuseIdentifier = "buttonTableViewCellId"
    private var buttonView: MMButtonView?
    private var selectedColor: UIColor?
    
    func configure(with text: String?, and color: UIColor? = .systemGreen) {
        if let text = text,
            let color = color {
            buttonView = MMButtonView(with: text, and: color)
            selectedColor = color
            setup()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        if let buttonView = buttonView {
            contentView.addSubview(buttonView)
            buttonView.fillSuperview()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            buttonView?.updateButton(with: selectedColor)
            buttonView?.updateLabel(with: .white)
        } else {
            buttonView?.updateButton(with: .systemGray6)
            buttonView?.updateLabel(with: .secondaryLabel)
        }
    }
}

class MMButtonCollectionCell: UICollectionViewCell {
    static let reuseIdentifier = "buttonCollectionViewCellId"
    private var buttonView: MMButtonView?
    private var selectedBackgroundColor: UIColor?
    private var selectedTextColor: UIColor?
    private var selectedFont: UIFont?
    
    func configure(with text: String?, bgColor: UIColor? = .systemGreen, textColor: UIColor? = .white, and font: UIFont? = UIFont(name: MM.FontNamed.HelveticaBold, size: 24)) {
        if let text = text,
            let bgColor = bgColor,
            let textColor = textColor,
            let font = font {
            buttonView = MMButtonView(with: text, and: bgColor)
            selectedBackgroundColor = bgColor
            selectedTextColor = textColor
            selectedFont = font
            setup()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        if let buttonView = buttonView {
            contentView.addSubview(buttonView)
            buttonView.updateButton(with: selectedBackgroundColor)
            buttonView.updateLabel(with: selectedTextColor)
            buttonView.updateLabel(with: selectedFont)
            buttonView.fillSuperview()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                
            } else {
                
            }
        }
    }
}
