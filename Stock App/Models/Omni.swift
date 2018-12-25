//
//  Omni.swift
//  Stock App
//
//  Created by Ирина Улитина on 18/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation

class TransactionSearchResult : Decodable {
    var transactions : [Transaction]!
}

class Transaction : Decodable {
    
    var Amount : Double {
        get {
            return Double.init(amount)!
        }
    }
    
    var amount : String
    var coinName : String
    
    var type : String
    var from : String
    var to : String
    
    init() {
        amount = ""
        coinName = ""
        type = ""
        from = ""
        to = ""
    }
    
    init(amount : String, coinName : String, type : String, from : String, to : String) {
        self.amount = amount
        self.coinName = coinName
        self.type = type
        self.from = from
        self.to = to
    }
    
    enum CodingKeys : String, CodingKey {
        case amount = "amount"
        case coinName = "propertyname"
        case type = "type"
        case from = "referenceaddress"
        case to = "sendingaddress"
    }
    required init?(coder aDecoder : Decoder) {
        do {
            let container = try aDecoder.container(keyedBy: CodingKeys.self)
            self.amount = try container.decode(String.self, forKey: .amount)
            self.coinName =  try container.decode(String.self, forKey: .coinName)
            self.type =  try container.decode(String.self, forKey: .type)
            self.from =  try container.decode(String.self, forKey: .from)
            self.to =  try container.decode(String.self, forKey: .to)
        } catch let err {
            self.amount = ""
            self.coinName = ""
            self.type = ""
            self.from = ""
            self.to = ""
            print("Error when decoding transaction ", err)
        }
    }
}

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


