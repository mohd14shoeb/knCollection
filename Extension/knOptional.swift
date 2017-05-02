//
//  knOptional.swift
//  Ogenii
//
//  Created by Ky Nguyen on 4/29/17.
//  Copyright © 2017 Ogenii. All rights reserved.
//

import UIKit

extension Optional {
    func or<T>(defaultValue: T) -> T {
        switch(self) {
        case .none:
            return defaultValue
        case .some(let value):
            return value as! T
        }
    }
}
