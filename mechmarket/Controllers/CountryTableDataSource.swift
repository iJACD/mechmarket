//
//  CountryTableDataSource.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/5/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

final class CountryTableDataSource: NSObject {
    private var countries: [Country]
    
    override init() {
        self.countries = [
            Country(.all, .all),
            Country(.us, .us),
            Country(.ca, .ca),
            Country(.au, .au),
            Country(.eu, .eu)
        ]
    }
}

extension CountryTableDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        countries.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = countries[indexPath.section]
        
        if let countryButton = tableView.dequeueReusableCell(withIdentifier: CountryButtonCell.countryButtonCellId) as? CountryButtonCell  {
            countryButton.configure(with: country)
            return countryButton
        }
        
        return UITableViewCell()
    }
    
    
}
