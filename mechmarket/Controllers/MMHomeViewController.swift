//
//  MMHomeViewController.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/4/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

class MMHomeViewController: UIViewController {
    private let size: CGFloat = 175
    private let spacing: CGFloat = 36
    private let countryTableDataSource = MMCountryTableDataSource()
    private lazy var mmRoundImageButton: MMRoundImageButton = {
        let btn = MMRoundImageButton.configure(with: size, and: 36)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy  var promptLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = MM.OriginPage.selectOriginText
        lbl.textColor = .secondaryLabel
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 2
        lbl.font = UIFont(name: MM.FontNamed.HelveticaLight, size: 36)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var countryTableView: UITableView = {
        let tbl = UITableView(frame: .zero, style: .plain)
        tbl.delegate = self
        tbl.dataSource = countryTableDataSource
        tbl.register(MMCountryButtonCell.self, forCellReuseIdentifier: MMCountryButtonCell.reuseIdentifier)
        tbl.isScrollEnabled = false
        tbl.separatorStyle = .none
        tbl.backgroundColor = .clear
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(mmRoundImageButton)
        view.addSubview(promptLabel)
        view.addSubview(countryTableView)
        NSLayoutConstraint.activate([
            mmRoundImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: spacing*2),
            mmRoundImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            promptLabel.topAnchor.constraint(equalTo: mmRoundImageButton.bottomAnchor, constant: spacing),
            promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            promptLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
            
            countryTableView.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: spacing),
            countryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing*1.5),
            countryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing*1.5),
            countryTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        let firstIndex = IndexPath(row: 0, section: 0)
        countryTableView.selectRow(at: firstIndex, animated: true, scrollPosition: .none)
    }
    
    func loadFeedForOrigin(completion: @escaping (Result<[MMListingData], Error>) -> ()) {
        let subreddit = "mechmarket"
        let urlString = "https://www.reddit.com/r/\(subreddit)/new.json?sort=new"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                completion(.failure(err))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MMData.self, from: data ?? Data())
                completion(.success(response.data.children))
            } catch let jsonErr {
                completion(.failure(jsonErr))
            }
        }.resume()
    }
}

extension MMHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 0 : spacing/2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        36*1.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let clearView = UIView()
        clearView.backgroundColor = .clear
        return clearView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        modalTransitionStyle = .flipHorizontal
//        modalPresentationStyle = .fullScreen
        let selectedCountry = countryTableDataSource.getCountry(at: indexPath.section)
        let dispatchGroup = DispatchGroup()
        var listings = [MMListing]()
        
        dispatchGroup.enter()
        loadFeedForOrigin() { res in
            switch res {
            case .success(let data):
                data.forEach {
                    listings.append($0.data)
                }
            case .failure(let err):
                print("Failed to fetch data:", err)
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            print(listings)
            let controller = MMClassifiedsSwipeController.configure(with: selectedCountry, and: listings)

            self.present(controller, animated: true)
        }
    }
}

struct MMData: Decodable {
    let data: MMEmbededData
    
    struct MMEmbededData: Decodable {
        let dist: Int
        let children: [MMListingData]
    }
}

struct MMListingData: Decodable {
    let data: MMListing
}

struct MMListing: Decodable {
    let selftext: String
    let author_fullname: String
    let title: String
    let link_flair_text: String
    let selftext_html: String?
    let author: String
    let url: String
}
