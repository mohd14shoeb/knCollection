//
//  knInt.swift
//  Fixir
//
//  Created by Ky Nguyen on 3/23/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

public extension UInt32 {
    public static func random(lower: UInt32 = min, upper: UInt32 = max) -> Int {
        return Int(arc4random_uniform(upper - lower) + lower)
    }
}
