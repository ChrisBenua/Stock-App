//
//  MakeSafeUrl.swift
//  Stock App
//
//  Created by Ирина Улитина on 26/11/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation

extension String {
    func makeSafeUrl()->String {
        if (self.contains("http")) {
            return self.replacingOccurrences(of: "http:", with: "https:")
        }
        return self
    }
}
