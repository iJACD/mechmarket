//
//  MMBuyingPage.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/12/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

class MMBuyingPage: UICollectionViewCell {
    static let reuseIdentifier = "MMBuyingPage"
    private let spacing: CGFloat = 10
    
    private lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return rc
    }()

    private lazy var tableView: UITableView = {
        let tbl = UITableView(frame: .zero, style: .plain)
        tbl.delegate = self
        tbl.dataSource = self
        tbl.register(MMBuyingListCell.self, forCellReuseIdentifier: MMBuyingListCell.reuseIdentifier)
        tbl.separatorStyle = .none
        tbl.backgroundColor = .clear
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.refreshControl = self.refreshControl
        return tbl
    }()
    
    private lazy var listings = [MMListing]()
    private lazy var afterId: String? = nil
    private lazy var dispatchGroup = DispatchGroup()
    private var selectedCountry: Country?
    weak var delegate: MMClassifiedsPageDelegate?
    private var isLoading = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(for origin: Country) {
        isLoading = true
        dispatchGroup.enter()
        refreshControl.beginRefreshing()
        selectedCountry = origin
        var listings = [MMListing]()
        MMService.shared.loadFeed(for: origin, and: .buying) { res in
            switch res {
            case .success(let data):
                self.afterId = data.after
                data.children.forEach {
                    listings.append($0.data)
                }
            case .failure(let err):
                print("Failed to fetch data:", err)
            }
            
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.listings = listings
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
            self.isLoading = false
        }
    }
    
    private func loadMore() {
        isLoading = true
        print("Going to start loading now...")
        if let id = afterId,
           let selectedCountry = selectedCountry {
            // footer loading spinner start
            dispatchGroup.enter()
            MMService.shared.loadMoreFeed(after: id, for: selectedCountry, and: .buying) { res in
                switch res {
                case .success(let data):
                    self.afterId = data.after
                    data.children.forEach {
                        self.listings.append($0.data)
                    }
                case .failure(let err):
                    print("Failed to load more data:", err)
                }
                
                self.dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                // footer loading spinner stop
                self.tableView.reloadData()
                self.isLoading = false
            }
        }
    }
    
    private func setup() {
        backgroundColor = .systemBackground
        tableView.backgroundColor = .systemBackground
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: frame.height/7+15),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc func didPullToRefresh() {
        if let selectedCountry = selectedCountry {
            reload(for: selectedCountry)
        }
    }
}

extension MMBuyingPage: UITableViewDataSource, UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section >= listings.count - listings.count/3 && !isLoading {
            loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listing = listings[indexPath.section]
        delegate?.didSelectMMPageCell(with: listing)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listing = listings[indexPath.section]
        
        if let buyingListCell = tableView.dequeueReusableCell(withIdentifier: MMBuyingListCell.reuseIdentifier) as? MMBuyingListCell  {
            buyingListCell.configure(with: listing)
            let imgView = CachedImageView()
            if !listing.imageUrlString.isEmpty {
                imgView.loadImage(urlString: listing.imageUrlString)
            }
            imgView.contentMode = .scaleAspectFill
            buyingListCell.accessoryView = imgView
            buyingListCell.accessoryView?.layer.masksToBounds = true
            buyingListCell.accessoryView?.layer.cornerRadius = 5
            buyingListCell.accessoryView?.layer.borderWidth = 1
            buyingListCell.accessoryView?.layer.borderColor = UIColor.secondaryLabel.cgColor
            buyingListCell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            return buyingListCell
        }
        
        return UITableViewCell()
    }
}
