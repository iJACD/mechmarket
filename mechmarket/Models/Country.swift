//
//  Country.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/5/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

struct Country {
    var name: String
    var queryString: String
    
    
    init(_ name: CountryName, _ queryString: QueryString) {
        self.name = name.description
        self.queryString = queryString.description
    }
}

enum CountryName: CustomStringConvertible {
    case all
    case us
    case ca
    case au
    case eu 
    
    var description: String {
        switch self {
        case .all: return "All"
        case .us: return "United States"
        case .ca: return "Canada"
        case .au: return "Australia"
        case .eu: return "European Union"
        }
    }
}

enum QueryString: CustomStringConvertible {
    case all
    case us
    case ca
    case au
    case eu
    
    var description: String {
        switch self {
        case .all: return ""
        case .us: return "title:(\"[US-\")"
        case .ca: return "title:(\"[CA-\")"
        case .au: return "title:(\"[AU]\")"
        case .eu: return "title:(\"[EU-\")"
        }
    }
}
