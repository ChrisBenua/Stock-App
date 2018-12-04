//
//  PoloniexAPIHelper.swift
//  Stock App
//
//  Created by Ирина Улитина on 27/11/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import Alamofire
///APIHelper for working with PoliniexAPI
class PoloniexAPIHelper {
    ///singleton
    static var shared = PoloniexAPIHelper()
    static let QueryURL = "https://poloniex.com/public?"
    let secondInDay = 60 * 60 * 24;
    
    /**
     function for fetching with Poloniex API
     The time range in inclusive
     return data for date at 4am in UTC
     - Parameter params : ["currencyPair" : `name of CryptoCoin`], ["start" : `startTimeStam]`, ["end" : `endTimeStamp], ["period" : `period of data fetching`]
     period can be only 300, 900, 1800, 7200, 14400, and 86400
    */
    static func fetchCurrencyData(params : [String : Any], completionHandler: @escaping (_ : [CoinData]) -> ()) {
        //add command=returnChartData to our query
        var myparams : [String : Any] = params
        myparams["command"] = "returnChartData"
        Alamofire.request(QueryURL, method: .get, parameters: myparams, headers: nil).responseJSON { (resp) in
            //Add checker for status code
            print(resp.result.value)
            let dict = resp.result.value as! [[String : Any]]
            var items : [CoinData] = [CoinData]()
            do {
                for el in dict {
                    let data : Data = try JSONSerialization.data(withJSONObject : el)
                    items.append(try JSONDecoder().decode(CoinData.self, from: data))
                }
                completionHandler(items)
            } catch let err {
                print(err)
            }
        }
    }
    
}
