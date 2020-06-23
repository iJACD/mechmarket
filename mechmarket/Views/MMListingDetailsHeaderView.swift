//
//  MMListingDetailsHeaderView.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/18/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

final class MMListingDetailsHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "MMListingDetailsHeaderViewId"
    
    lazy var imageView: CachedImageView = {
        let imgV = CachedImageView()
        imgV.contentMode = .scaleAspectFill
        return imgV
    }()
    
    private lazy var mmOptionsButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(MM.Images.optionsButton, for: .normal)
        btn.tintColor = .label
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTapOptions), for: .touchUpInside)
        return btn
    }()
    
    private lazy var mmCloseButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(MM.Images.closeButton, for: .normal)
        btn.tintColor = .label
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return btn
    }()
    
    private lazy var userNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: MM.FontNamed.HelveticaBold, size: 18)
        lbl.textColor = UIColor.white.withAlphaComponent(0.85)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var tagLabel: MMFlairTagLabel = {
        let tag = MMFlairTagLabel(frame: .zero)
        return tag
    }()
    
    weak var delegate: MMDetailsPageDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with listing: MMListing?) {
        if let listing = listing {
            userNameLabel.text = "u/\(listing.author)"
            imageView.loadImage(urlString: listing.imageUrlString)
            if let flair = listing.getFlair {
                tagLabel.configure(with: flair)
            }
        }
    }
    
    @objc func didTapClose() {
        delegate?.didTapClose()
    }
    
    @objc func didTapOptions() {
        
    }
    
    private func setup() {
        addSubview(imageView)
        imageView.fillSuperview()
        backgroundColor = .systemGray4
        
        setupGradientLayer()
        setupElements()
    }
    
    private func setupElements() {
        addSubview(mmCloseButton)
        addSubview(tagLabel)
        addSubview(mmOptionsButton)
        addSubview(userNameLabel)
        NSLayoutConstraint.activate([
            mmCloseButton.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            mmCloseButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            
            mmOptionsButton.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            mmOptionsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            tagLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            tagLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            userNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.65, 1]
        
        let gradientContainerView = UIView()
        gradientContainerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gradientContainerView)
        
        NSLayoutConstraint.activate([
            gradientContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientContainerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        gradientContainerView.layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.bounds
        gradientLayer.frame.origin.y -= bounds.height
    }
}

protocol MMDetailsPageDelegate: class {
    func didTapClose()
}
