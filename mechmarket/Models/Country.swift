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
    
    
    init(_ name: CountryName, _ queryString: CountryQueryString) {
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

enum CountryQueryString: CustomStringConvertible {
    case all
    case us
    case ca
    case au
    case eu
    
    // %22 translates to "
    var description: String {
        switch self {
        case .all: return ""
        case .us: return "title:(%22[US-%22)+AND+"
        case .ca: return "title:(%22[CA-%22+NOT+%22[US-CA]%22)+AND+"
        case .au: return "title:(%22[AU]%22)+AND+"
        case .eu: return "title:(%22[EU-%22)+AND+"
        }
    }
}
