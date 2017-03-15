//
//  GlobalSupporter.swift
//  Fixir
//
//  Created by Ky Nguyen on 3/9/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

func run(_ action: @escaping (Void) -> Void, after second: Double) {
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(second * 1000))) {
        action()
    }
}
