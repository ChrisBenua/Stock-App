//
//  Omni.swift
//  Stock App
//
//  Created by Ирина Улитина on 18/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation

class UserInfo : Decodable {
    var name : String!
    var balance : [CoinBalance]

    
    init(name : String, balance : [CoinBalance]) {
        self.name = name
        self.balance = balance
    }
    
    init() {
        self.name = ""
        self.balance = [CoinBalance]()
    }
    
    enum CodingKeys : String, CodingKey {
        case name = "id"
        case balance = "balance"
    }
    
    required init?(coder aDecoder: Decoder) {
        do {
            let container = try aDecoder.container(keyedBy: CodingKeys.self)
            //self.name = try container.decode(String.self, forKey: .name)
            self.balance = try container.decode([CoinBalance].self, forKey: .balance)
        } catch let err {
            //self.name = "UNDEF"
            self.balance = [CoinBalance]()
            print("Error in parsing Poloniex JSON ", err)
        }
    }
}

class CoinBalance : Decodable {
    var value : String
    var Value : Double {
        get {
            return Double(value) ?? 0
        }
    }
    var symbol : String
    
    var properties : PropertyInfo
    
    init(value : String, symbol : String) {
        self.value = value
        self.symbol = symbol
        properties = PropertyInfo.init()
    }
    
    init(value : String, symbol : String, prop : PropertyInfo) {
        self.value = value
        self.symbol = symbol
        self.properties = prop
    }
    
    enum CodingKeys : String, CodingKey {
        case value = "value"
        case symbol = "symbol"
        case properties = "propertyinfo"
    }
    
    required init?(coder aDecoder: Decoder) {
        do {
            let container = try aDecoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(String.self, forKey: .value)
            self.symbol = try container.decode(String.self, forKey: .symbol)
            self.properties = try container.decode(PropertyInfo.self, forKey: .properties)
        } catch let err {
            self.value = "0"
            self.symbol = "UNDEF"
            self.properties = PropertyInfo()
            print("Error in parsing Poloniex JSON ", err)
        }
    }
}

class PropertyInfo : Decodable {
    var propertyName : String
    
    init(name : String) {
        propertyName = name
    }
    
    init() {
        propertyName = ""
    }
    
    enum CodingKeys : String, CodingKey {
        case propertyName = "name"
    }
    
    required init?(coder aDecoder: Decoder) {
        do {
            let container = try aDecoder.container(keyedBy: CodingKeys.self)
            self.propertyName = try container.decode(String.self, forKey: .propertyName)
        } catch let err {
            self.propertyName = ""
            print("Error in parsing Poloniex JSON ", err)
        }
    }
    
}
