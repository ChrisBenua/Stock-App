//
//  UserDefaultsExtension.swift
//  Stock App
//
//  Created by Ирина Улитина on 09/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation


extension UserDefaults {
    ///UserDefaults key to save user's wallet id
    static let omniIdKey = "omniId"
    ///This constant controls how many recent currencies will be shown
    static let maxRecentSize = 10
    ///UserDefaults key to save user's favourites currencies
    static let favoriteCoinNamesKey = "favoriteKey"
    ///UserDefaults key to save recent coin names
    static let recentCoinNamesKey = "recent"
    
    ///Gets user's wallet id from UserDefaults
    func getOmniId() -> String? {
        guard let data = UserDefaults.standard.data(forKey: UserDefaults.omniIdKey) else { return nil}
        guard let id = NSKeyedUnarchiver.unarchiveObject(with: data) as? String else { return nil }
        return id
    }
    
    ///Saves user's wallet id to UserDefaults
    func saveOmniId(id : String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: id)
        UserDefaults.standard.set(data, forKey: UserDefaults.omniIdKey)
    }
    
    ///Gets user's favourite currencies from UserDefaults
    func getFavoriteCoinNames() -> [String]? {
        guard let data = UserDefaults.standard.data(forKey: UserDefaults.favoriteCoinNamesKey) else {return nil}
        guard let names = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] else { return nil }
        return names
    }
    
    ///Erases currency from user's favourite List
    func eraseCoinNameFromFavorites(nameToErase : String) {
        guard let data = UserDefaults.standard.data(forKey: UserDefaults.favoriteCoinNamesKey) else {return }
        guard var names = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] else { return }
        
        names.removeAll { (str) -> Bool in
            str == nameToErase
        }
        
        let currData = NSKeyedArchiver.archivedData(withRootObject: names)
        UserDefaults.standard.set(currData, forKey: UserDefaults.favoriteCoinNamesKey)
    }
    
    ///Adds currency to user;s favourite List
    func addToFavoritesCoinNames(newName : String) {
        var prevNames = UserDefaults.standard.getFavoriteCoinNames() ?? [String]()
        prevNames.append(newName)
        //at this moment only one favorite Coin will be availiable
        //let prevNames = [newName]
        let currData = NSKeyedArchiver.archivedData(withRootObject: prevNames)
        UserDefaults.standard.set(currData, forKey: UserDefaults.favoriteCoinNamesKey)
    }
    
    ///Gets recently explored coin Names from User Defaults
    func getRecentCoinNames() -> [String] {
        guard let data = UserDefaults.standard.data(forKey: UserDefaults.recentCoinNamesKey) else {return [String]()}
        guard let names = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] else { return [String]()}
        return names
    }
    
    /**
     Adds coin name to recenlty explored list
     - Parameter newName: Name te be added in recentCoinNamesList
     */
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
