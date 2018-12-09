//
//  UserDefaultsExtension.swift
//  Stock App
//
//  Created by Ирина Улитина on 09/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation


extension UserDefaults {
    static let maxRecentSize = 10
    static let favoriteCoinNamesKey = "favoriteKey"
    static let recentCoinNamesKey = "recent"
    func getFavoriteCoinNames() -> [String]? {
        guard let data = UserDefaults.standard.data(forKey: UserDefaults.favoriteCoinNamesKey) else {return nil}
        guard let names = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] else { return nil }
        return names
    }
    
    func eraseCoinNameFromFavorites(nameToErase : String) {
        guard let data = UserDefaults.standard.data(forKey: UserDefaults.favoriteCoinNamesKey) else {return }
        guard var names = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] else { return }
        
        names.removeAll { (str) -> Bool in
            str == nameToErase
        }
        
        let currData = NSKeyedArchiver.archivedData(withRootObject: names)
        UserDefaults.standard.set(currData, forKey: UserDefaults.favoriteCoinNamesKey)
    }
    
    func addToFavoritesCoinNames(newName : String) {
        /*var prevNames = UserDefaults.standard.getFavoriteCoinNames()
        prevNames.append(newName)*/
        //at this moment only one favorite Coin will be availiable
        let prevNames = [newName]
        let currData = NSKeyedArchiver.archivedData(withRootObject: prevNames)
        UserDefaults.standard.set(currData, forKey: UserDefaults.favoriteCoinNamesKey)
    }
    
    func getRecentCoinNames() -> [String] {
        guard let data = UserDefaults.standard.data(forKey: UserDefaults.recentCoinNamesKey) else {return [String]()}
        guard let names = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] else { return [String]()}
        return names
    }
    
    func addToRecentCoinNames(newName : String) {
        var prevNames = UserDefaults.standard.getRecentCoinNames()
        prevNames.removeAll { (str) -> Bool in
            str == newName
        }
        prevNames.insert(newName, at: 0)
        prevNames = Array(prevNames.prefix(10))
        let currData = NSKeyedArchiver.archivedData(withRootObject: prevNames)
        UserDefaults.standard.set(currData, forKey: UserDefaults.recentCoinNamesKey)
    }
}
