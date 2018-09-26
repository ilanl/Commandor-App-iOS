//
//  AddressOf.swift
//  App
//
//  Created by IlanL on 26/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Foundation

func address<T: AnyObject>(o: T) -> Int {
    return unsafeBitCast(o, to: Int.self)
}
