//
//  MMRoundImageButton.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/7/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

class MMRoundImageButton: UIButton {
    private var size: CGFloat = 175
    private lazy var keyboardImage = MM.Images.keyBoardImage
    private lazy var buttonLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func configure(with size: CGFloat, and fontSize: CGFloat) -> MMRoundImageButton {
        let btn = MMRoundImageButton()
        btn.imageView?.layer.cornerRadius = size/2
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor :  UIColor.systemBackground,
            NSAttributedString.Key.foregroundColor :  UIColor.secondaryLabel,
            NSAttributedString.Key.strokeWidth : -1.5,
            NSAttributedString.Key.font : UIFont(name: MM.FontNamed.HelveticaBold, size: fontSize)!
        ] as [NSAttributedString.Key : Any]
        
        btn.buttonLabel.attributedText = NSMutableAttributedString(string: MM.OriginPage.imageOverlayText,
                                                       attributes: strokeTextAttributes)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: size).isActive = true
        btn.heightAnchor.constraint(equalToConstant: size).isActive = true
        return btn
    }
    
    private func setup() {
        setImage(keyboardImage, for: .normal)
        imageView?.contentMode = .scaleAspectFill
        imageView?.layer.borderWidth = 2
        imageView?.layer.borderColor = UIColor.secondaryLabel.cgColor
        imageView?.layer.masksToBounds = true
        
        imageView?.addSubview(buttonLabel)
        if let parent = imageView {
            NSLayoutConstraint.activate([
                buttonLabel.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
                buttonLabel.centerYAnchor.constraint(equalTo: parent.centerYAnchor)
            ])
        }
        
        addTarget(self, action: #selector(didTouchMKButton), for: .touchUpInside)
    }
    
    @objc func didTouchMKButton() {
        if let link = URL(string: MM.Links.mechmarket) {
            UIApplication.shared.open(link)
        }
    }
}
