//
//  ViewController.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/4/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

class MKHomeViewController: UIViewController {
    private var isDarkMode: Bool {
        return traitCollection.userInterfaceStyle == .dark
    }
    
    private lazy var roundImageView: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "keyboardImage")
        let btnLbl = UILabel()
        
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor :  UIColor.black,
            NSAttributedString.Key.foregroundColor :  UIColor.white,
            NSAttributedString.Key.strokeWidth : -1.5,
            NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 36)!
        ] as [NSAttributedString.Key : Any]
        
        btnLbl.attributedText = NSMutableAttributedString(string: "r/mk",
                                                          attributes: strokeTextAttributes)
        btnLbl.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setImage(img, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.imageView?.layer.borderWidth = 2
        btn.imageView?.layer.borderColor = isDarkMode
                                            ? UIColor.white.cgColor
                                            : UIColor.black.cgColor
        btn.imageView?.layer.cornerRadius = 150/2
        btn.imageView?.layer.masksToBounds = true
        
        btn.imageView?.addSubview(btnLbl)
        if let parent = btn.imageView {
            NSLayoutConstraint.activate([
                btnLbl.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
                btnLbl.centerYAnchor.constraint(equalTo: parent.centerYAnchor)
            ])
        }

        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: Set colors function to set the colors of attributes that aren't
        // natively supported by dark mode.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(roundImageView)
        NSLayoutConstraint.activate([
            roundImageView.widthAnchor.constraint(equalToConstant: 150),
            roundImageView.heightAnchor.constraint(equalToConstant: 150),
            
            roundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            roundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }


}

