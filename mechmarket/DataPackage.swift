//
//  DataWrapper.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/12/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import Foundation

struct DataPackage<T: Decodable>: Decodable {
    let data: T
}
