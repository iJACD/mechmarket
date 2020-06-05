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
    
    private let size: CGFloat = 175
    private let spacing: CGFloat = 36
    private let countryTableDataSource = CountryTableDataSource()
    private lazy var roundImageView: UIButton = {
        let btn = UIButton()
        let img = MK.Images.keyBoardImage
        let btnLbl = UILabel()
        
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor :  UIColor.systemBackground,
            NSAttributedString.Key.foregroundColor :  UIColor.secondaryLabel,//UIColor.white,
            NSAttributedString.Key.strokeWidth : -1.5,
            NSAttributedString.Key.font : UIFont(name: MK.FontNamed.HelveticaBold, size: 36)!
        ] as [NSAttributedString.Key : Any]
        
        btnLbl.attributedText = NSMutableAttributedString(string: MK.OriginPage.imageOverlayText,
                                                          attributes: strokeTextAttributes)
        btnLbl.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setImage(img, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.imageView?.layer.borderWidth = 2
        btn.imageView?.layer.borderColor = UIColor.secondaryLabel.cgColor
        btn.imageView?.layer.cornerRadius = size/2
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
    
    private lazy  var promptLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = MK.OriginPage.selectOriginText
        lbl.textColor = .secondaryLabel
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 2
        lbl.font = UIFont(name: MK.FontNamed.HelveticaLight, size: 36)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var countryTableView: UITableView = {
        let tbl = UITableView()
        tbl.delegate = self
        tbl.register(CountryButtonCell.self, forCellReuseIdentifier: CountryButtonCell.countryButtonCellId)
        tbl.dataSource = countryTableDataSource
        tbl.isScrollEnabled = false
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: Set colors function to set the colors of attributes that aren't
        // natively supported by dark mode.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(roundImageView)
        view.addSubview(promptLabel)
        view.addSubview(countryTableView)
        NSLayoutConstraint.activate([
            roundImageView.widthAnchor.constraint(equalToConstant: size),
            roundImageView.heightAnchor.constraint(equalToConstant: size),
            roundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            roundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            promptLabel.topAnchor.constraint(equalTo: roundImageView.bottomAnchor, constant: spacing),
            promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            promptLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
            
            countryTableView.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: spacing),
            countryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing*1.5),
            countryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing*1.5),
            countryTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }


}

extension MKHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 0 : spacing
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        36*1.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let clearView = UIView()
        clearView.backgroundColor = .clear
        return clearView
    }
}
