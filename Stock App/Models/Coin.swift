//
//  Coin.swift
//  Stock App
//
//  Created by Ирина Улитина on 27/11/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation

/// Class for storing all needed data for CryptoCoins for one date
class CoinData : Decodable {
    ///Date of following data
    var date : Int64
    
    ///The highest value for following period
    var high : Double
    
    ///The lowest value for following period
    var low : Double
    
    ///Price of Coin in the beggining of period
    var open : Double
    
    ///Price of Coin in the end of period
    var close : Double
    
    init() {
        date = 0
        self.high = 0
        self.low = 0
        self.open = 0
        self.close = 0
    }
    
    init(date : Int64, high : Double, low : Double, open : Double, close : Double) {
        self.date = date
        self.high = high
        self.low = low
        self.open = open
        self.close = close
    }
    
    enum CodingKeys : String, CodingKey {
        case date = "date"
        case high = "high"
        case low = "low"
        case open = "open"
        case close = "close"
    }
    
    required init?(coder aDecoder: Decoder) {
        do {
            let container = try aDecoder.container(keyedBy: CodingKeys.self)
            self.date = try container.decode(Int64.self, forKey: .date)
            self.high = try container.decode(Double.self, forKey: .high)
            self.low = try container.decode(Double.self, forKey: .low)
            self.open = try container.decode(Double.self, forKey: .open)
            self.close = try container.decode(Double.self, forKey: .close)
        } catch let err {
            date = 0
            high = 0
            low = 0
            open = 0
            close = 0
            print("Error in parsing Poloniex JSON ", err)
        }
    }
}

///Class for storing data for
class Coin {
    
    ///Name for this Coin
    var name : String
    
    ///Stores all data in time-interval
    var data : [CoinData]
    
    ///Begining of corresponding data interval
    var beginTimeStamp : Int64
    
    ///End of corresponding data interval
    var endTimeStamp : Int64
    
    ///init fields with default values
    init() {
        name = ""
        data = [CoinData]()
        beginTimeStamp = 0
        endTimeStamp = 0
    }
    
    /**
     Constructor with all fields values in it
     - Parameter name : Name of Coin
     - Parameter data : array of CoinData for some date Period
     - Parameter beginTimeStamp : beginning of time interval, that will store this Coin object
     - Parameter endTimeStamp : end of time interval
    */
    init(name : String, data : [CoinData], beginTimeStamp : Int64, endTimeStamp : Int64) {
        self.name = name
        self.data = data
        self.beginTimeStamp = beginTimeStamp
        self.endTimeStamp = endTimeStamp
    }
    /**
     simple constructor, but it calculates beginTimeStamp and endTimeStamp automatically
     - Parameter name : Name of Coin
     - Parameter data : Array of CoinData for some date Period
     */
    init(name : String, data : [CoinData]) {
        if (data.isEmpty) {
            beginTimeStamp = 0
            endTimeStamp = 0
            print("Some error occured in Coin class, init(:String, :[CoinData])")
        } else {
            beginTimeStamp = data.first!.date
            endTimeStamp = data.last!.date
        }
        self.data = data
        self.name = name
    }
    
    
    
}
