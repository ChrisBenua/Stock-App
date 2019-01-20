//
//  CurrentTimeStamp.swift
//  Stock App
//
//  Created by Ирина Улитина on 02/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation

extension Int64 {
    /// Gets Current Unix Time Stamp 
    static func currentTimeStamp() -> Int64 {
        return Int64(Date().timeIntervalSince1970)
    }
}
