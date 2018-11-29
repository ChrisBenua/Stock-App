//
//  APIHelper.swift
//  Stock App
//
//  Created by Ирина Улитина on 25/11/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import Alamofire
/// APIHelper for newsriver
class APIHelper {
    
    static var shared = APIHelper()
    
    ///API URL for newsriver.io
    static var QueryURL = "https://api.newsriver.io/v2/search?"
    
    /**
     fetch news from newsriver.io
     
     - Parameter luceneParams: Dict, Keys : "text", "website.domainName", "language"
     - Parameter luceneLogicParams : "AND" or "OR"
     - Parameter simpleParams: usual parameter, parsed like always, Keys : "sortBy", "sortOrder", "limit"
     - Parameter completionHandler: function for handling downloaded data Asynchronously
    */
    func fetchAllNews(luceneParams : [String : Any], luceneLogicParams : [String], simpleParams : [String : Any], completionHandler: @escaping (_ : [NewsItem]) -> ()) {
        let headers : HTTPHeaders = [
            "Authorization" : "sBBqsGXiYgF0Db5OV5tAw3To7PPsmyRAgIa73y4U1x2URrasZJ5GlR1abYpo_jlNn2pHZrSf1gT2PUujH1YaQA"
        ]
        var parsedParams : String = ""
        var luceneLogicCounter = 0
        for el in luceneParams.keys {
            parsedParams += el
            parsedParams += ":"
            parsedParams += luceneParams[el] as! String
            if (luceneLogicCounter < luceneLogicParams.count) {
                parsedParams += " " + luceneLogicParams[luceneLogicCounter] + " "
            }
            luceneLogicCounter += 1
        }
        //parsedParams = String(parsedParams.prefix(parsedParams.count - 5))
        var allParams : Parameters = simpleParams
        allParams["query"] = parsedParams
        Alamofire.request(APIHelper.QueryURL,
                          method: .get,
                          parameters: allParams, headers: headers)
            .responseJSON { (resp) in
                let dict = resp.result.value as! [[String : Any]]
                var items : [NewsItem] = [NewsItem]()
                do {
                    for el in dict {
                        let data : Data = try JSONSerialization.data(withJSONObject : el)
                        items.append(try JSONDecoder().decode(NewsItem.self, from: data))
                    }
                    completionHandler(items)
                } catch let err {
                    print(err)
                }
                print(resp.result.value)
        }
        
    }
}

