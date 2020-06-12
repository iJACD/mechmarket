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
    case sellingOrTrading
    case soldOrPurchased
    
    var description: String {
        switch self {
        case .buying: return "flair:buying"
        case .sellingOrTrading: return "(flair:selling+OR+flair:trading)"
        case .soldOrPurchased: return "(flair:sold+OR+flair:purchased)"
        }
    }
}
