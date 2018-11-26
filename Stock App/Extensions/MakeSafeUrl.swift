//
//  MakeSafeUrl.swift
//  Stock App
//
//  Created by Ирина Улитина on 26/11/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation

extension String {
    /// Replaces http with https and deletes www in String, representing URL
    func makeSafeUrl() -> String {
        var curr : String = self
        if (self.contains("http")) {
            curr = self.replacingOccurrences(of: "http:", with: "https:")
        }
        /*if (self.contains("www.")) {
            return curr.replacingOccurrences(of: "www.", with: "")
        }*/
        return curr
    }
}
