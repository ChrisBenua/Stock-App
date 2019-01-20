//
//  Omni.swift
//  Stock App
//
//  Created by Ирина Улитина on 18/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
///Class to decode search result(because array of transaction will be inside of common json object, so that's why we need certain container)
class TransactionSearchResult : Decodable {
    ///Transactions, that contain JSON object from API call
    var transactions : [Transaction]!
}

///Class that represents OMNI layer transaction
class Transaction : Decodable {
    ///How much value was transfered(converts string to double)
    var Amount : Double {
        get {
            return Double.init(amount)!
        }
    }
    var amount : String
    /// what currency transaction had
    var coinName : String
    /// Type of transaction
    var type : String
    /// from whom currency was transfered
    var from : String
    /// to whom currency was transeferd
    var to : String
    var blockTime : Double
    
    init() {
        amount = ""
        coinName = ""
        type = ""
        from = ""
        to = ""
        blockTime = 0
    }
    
    init(amount : String, coinName : String, type : String, from : String, to : String, blocktime : Double) {
        self.amount = amount
        self.coinName = coinName
        self.type = type
        self.from = from
        self.to = to
        self.blockTime = blocktime
    }
    
    enum CodingKeys : String, CodingKey {
        case amount = "amount"
        case coinName = "propertyname"
        case type = "type"
        case from = "sendingaddress"
        case to = "referenceaddress"
        case blockTime = "blocktime"
    }
    required init?(coder aDecoder : Decoder) {
        do {
            let container = try aDecoder.container(keyedBy: CodingKeys.self)
            self.amount = try container.decode(String.self, forKey: .amount)
            self.coinName =  try container.decode(String.self, forKey: .coinName)
            self.type =  try container.decode(String.self, forKey: .type)
            self.from =  try container.decode(String.self, forKey: .from)
            self.to =  try container.decode(String.self, forKey: .to)
            self.blockTime = try container.decode(Double.self, forKey: .blockTime)
        } catch let err {
            self.amount = ""
            self.coinName = ""
            self.type = ""
            self.from = ""
            self.to = ""
            self.blockTime = 0
            print("Error when decoding transaction ", err)
        }
    }
}

///Class that describes user balance
class UserInfo : Decodable {
    ///user's wallet id
    var name : String!
    /// currencies, that this user owns
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
/// Describes info about currency in user's balance
class CoinBalance : Decodable {
    ///Amount of currency user has
    var value : String
    ///Amount of currency user has
    var Value : Double {
        get {
            return Double(value) ?? 0
        }
    }
    ///Currency symbol aka id
    var symbol : String
    
    /// properties this currency has, I will use only it's name
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
///class to  describe info about currency
class PropertyInfo : Decodable {
    ///full coin name
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


