//
//  MMSoldPage.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/13/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

class MMSoldPage: UICollectionViewCell {
    static let reuseIdentifier = "MMSoldPage"
    private let spacing: CGFloat = 10

    private lazy var tableView: UITableView = {
        let tbl = UITableView(frame: .zero, style: .plain)
        tbl.delegate = self
        tbl.dataSource = self
        tbl.register(MMSoldListCell.self, forCellReuseIdentifier: MMSoldListCell.reuseIdentifier)
        tbl.separatorStyle = .none
        tbl.backgroundColor = .clear
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()
    
    private lazy var listings = [MMListing]()
    private lazy var dispatchGroup = DispatchGroup()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(for origin: Country, and flair: MMFlair) {
        dispatchGroup.enter()
        var listings = [MMListing]()
        MMService.shared.loadFeed(for: origin, and: flair) { res in
            switch res {
            case .success(let data):
                data.forEach {
                    listings.append($0.data)
                }
            case .failure(let err):
                print("Failed to fetch data:", err)
            }
            
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.listings = listings
            self.tableView.reloadData()
        }
    }
    
    private func setup() {
        tableView.backgroundColor = .systemBackground
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: frame.height/7+15),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension MMSoldPage: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let clearView = UIView()
        clearView.backgroundColor = .clear
        return clearView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        spacing
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        listings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listing = listings[indexPath.section]
        
        if let soldListCell = tableView.dequeueReusableCell(withIdentifier: MMSoldListCell.reuseIdentifier) as? MMSoldListCell  {
            soldListCell.configure(with: listing)
            return soldListCell
        }
        
        return UITableViewCell()
    }
}
