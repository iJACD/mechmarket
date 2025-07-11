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
        static let optionsButton = UIImage(systemName: "ellipsis",
                                           withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .semibold, scale: .medium))
        static let optionsButtonCircle = UIImage(systemName: "ellipsis.circle.fill",
                                           withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .semibold, scale: .medium))
        static let closeButtonCircle = UIImage(systemName: "xmark.circle.fill",
                                         withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .semibold, scale: .medium))
    }
    
    struct FontNamed {
        static let HelveticaBold = "Helvetica-Bold"
        static let HelveticaLight = "Helvetica-Light"
        static let Helvetica = "Helvetica"
    }
    
    struct Links {
        static let mechmarket = "https://www.reddit.com/r/mechmarket"
    }
    
    struct Imgur {
        static let baseUrl = "https://imgur.com"
        static let apiBaseUrl = "https://api.imgur.com/3"
        static let image = "/image"
        static let gallery = "/gallery/album"
        static let album = "/album"
    }
}
