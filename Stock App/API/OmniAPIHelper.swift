//
//  OmniAPIHelper.swift
//  Stock App
//
//  Created by Ирина Улитина on 17/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import Alamofire

class OmniAPIHelper {
    public static var UrlBalance = "https://api.omniexplorer.info/v1/address/addr/"
    public static var UrlTransaction = "https://api.omniexplorer.info/v1/transaction/address"
    public static var shared = OmniAPIHelper()
    
    func fetchUsersWalletData(address : String, completionHandler: @escaping (_ : UserInfo) -> ()) {
        if (address.isEmpty) {
            return
        }
        Alamofire.request(OmniAPIHelper.UrlBalance, method: .post, parameters: ["addr" : address]).responseJSON { (resp) in
            print(resp)
            guard let dict = resp.result.value as? [String : Any] else {
                completionHandler(UserInfo(name: "ERROR", balance: [CoinBalance]()))
                return
            }
            do {
                let data : Data = try JSONSerialization.data(withJSONObject : dict)
                var item = try JSONDecoder().decode(UserInfo.self, from: data)
                item.name = address
                completionHandler(item)
            } catch let err {
                print("OMNI  fetch   ", err)
            }
            
        }
        
        /*let url = URL(string: "api.omniexplorer.info/v1/address/addr/\(address)")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        
        task.resume()*/
    }
    
    func fetchUsersTransactions(address : String, page : Int, completionHandler : @escaping (_ : [Transaction]) -> ()) {
        if address.isEmpty {
            return
        }
        
        Alamofire.request(OmniAPIHelper.UrlTransaction, method: .post, parameters: ["addr" : address, "page" : page]).responseJSON { (response) in
            if let err = response.error {
                print("Error fetching transactions ", err)
            }
            print(response)
            //TODO : make here completion handler with error
            guard let dict = response.result.value as? [String : Any] else { return }
            do {
                let data : Data = try JSONSerialization.data(withJSONObject : dict)
                var items = try JSONDecoder().decode(TransactionSearchResult.self, from: data)
                completionHandler(items.transactions)
            } catch let err {
                print("error in parsing Transaction", err)
            }
        }
    }
}
