//
//  Constants.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/5/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

public struct MM {
    struct OriginPage {
        static let imageOverlayText = "r/mm"
        static let selectOriginText = "Select search origin: "
    }
    
    struct Images {
        static let keyBoardImage = UIImage(named: "keyboardImage")
        static let optionsButton = UIImage(systemName: "ellipsis", withConfiguration: UIImage.SymbolConfiguration(weight: .black))
    }
    
    struct FontNamed {
        static let HelveticaBold = "Helvetica-Bold"
        static let HelveticaLight = "Helvetica-Light"
    }
    
    struct Links {
        static let mechmarket = "https://www.reddit.com/r/mechmarket"
    }
    
    struct ButtonTitles {
        static let buying = "Buying"
        static let sellOrTrade = "Selling/Trading"
        static let sold = "Sold"
    }
}
