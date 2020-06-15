//
//  MMImgurImages.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/12/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import Foundation

struct MMImgurGallery: Decodable {
    let images: [MMImgurImage]
}

struct MMImgurAlbum: Decodable {
    let images: [MMImgurImage]
}


struct MMImgurImage: Decodable {
    let link: String
}
