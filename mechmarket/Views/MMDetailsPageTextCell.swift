//
//  MMDynamicHeightCell.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/22/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

final class MMDetailsPageTextCell: UICollectionViewCell {
    private lazy var textLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = isTitle
            ? UIFont(name: MM.FontNamed.HelveticaBold, size: 18)
            : UIFont(name: MM.FontNamed.Helvetica, size: 12)
        lbl.textColor = isTitle
            ? .label
            : .secondaryLabel
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()

    var isTitle: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String?, and isTitle: Bool) {
        self.isTitle = isTitle
        textLabel.text = text
        setup()
    }
    
    private func setup() {
        contentView.addSubview(textLabel)
        textLabel.fillSuperview()
    }
}
