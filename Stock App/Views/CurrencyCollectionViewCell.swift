//
//  CurrencyCollectionViewCell.swift
//  Stock App
//
//  Created by Ирина Улитина on 02/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit

class CurrencyCollectionViewCell : ShadowCollectionViewCellBase {
    ///this coin's data should be represented in this cell somehow
    var coin : Coin! {
        didSet {
            configureCurrentValueLabel()
            //let name = coin.name.split(separator: "_")
            //nameLabel.text = name.last
            nameLabel.text = coin.name
        }
    }
    
    ///Label for coin name
    let nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22)
        label.numberOfLines = 1
        return label
    }()
    
    ///Label for current value
    let currentValueLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 1
        
        return label
    }()
    
    ///View update
    func configureCurrentValueLabel() {
        guard let currentTimeStamp = coin.data.last else {return}//Unix time in milisecond
        var prevDayValue : Double = coin.data.last!.close
        for el in coin.data {
            if currentTimeStamp.date - el.date >= Configuration.secondInOneDay {
                prevDayValue = el.close
            }
        }
        let todayValue : Double = coin.data.last!.close
        
        if (todayValue > prevDayValue) {
            currentValueLabel.textColor = UIColor.green
        } else {
            currentValueLabel.textColor = UIColor.red
        }
        // formats like "123, +2%"
        currentValueLabel.text = "\(String.init(format: "%.2f", todayValue)), \(String.init(format: "%.2f", todayValue/prevDayValue * 100 - 100))%"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mainCellView.addSubview(nameLabel)
        nameLabel.anchor(top: mainCellView.topAnchor, left: mainCellView.leftAnchor, bottom: nil, right: mainCellView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 10, width: 0, height: 35)
        
        mainCellView.addSubview(currentValueLabel)
        currentValueLabel.anchor(top: nil, left: mainCellView.leftAnchor, bottom: mainCellView.bottomAnchor, right: mainCellView.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 30)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
