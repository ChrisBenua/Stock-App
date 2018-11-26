//
//  CharacterExtension.swift
//  Stock App
//
//  Created by Ирина Улитина on 26/11/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation

extension Character {
    func isUpper() -> Bool {
        if (self >= Character("A") && self <= Character("Z")) {
            return true
        }
        return false;
    }
}
