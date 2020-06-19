//
//  MMFlair.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/12/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import Foundation

enum MMFlair: CustomStringConvertible {
    case buying
    case selling
    case trading
    case sold
    case purchased
    case sellingOrTrading
    case soldOrPurchased
    
    var queryString: String {
        switch self {
        case .buying: return "flair:buying"
        case .selling: return "flair:selling"
        case .trading: return "flair:trading"
        case .sold: return "flair:sold"
        case .purchased: return "flair:purchased"
        case .sellingOrTrading: return "(flair:selling+OR+flair:trading)"
        case .soldOrPurchased: return "(flair:sold+OR+flair:purchased)"
        }
    }
    
    var description: String {
        switch self {
        case .buying: return "Buying"
        case .selling: return "Selling"
        case .trading: return "Trading"
        case .sold: return "Sold"
        case .purchased: return "Purchased"
        case .sellingOrTrading: return "Sell/Trade"
        case .soldOrPurchased: return "Sold/Purchased"
        }
    }
    
}
