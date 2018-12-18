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
    public static var Url = "https://api.omniexplorer.info/v1/address/addr/"
    public static var shared = OmniAPIHelper()
    
    func getchUsersData(address : String, completionHandler: @escaping (_ : UserInfo) -> ()) {
        if (address.isEmpty) {
            return
        }
        Alamofire.request(OmniAPIHelper.Url, method: .post, parameters: ["addr" : address]).responseJSON { (resp) in
            print(resp)
            guard let dict = resp.result.value as? [String : Any] else { return }
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
}
