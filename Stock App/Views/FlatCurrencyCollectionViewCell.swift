//
//  FlatCurrencyCollectionViewCell.swift
//  Stock App
//
//  Created by Ирина Улитина on 04/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit

class FlatCurrencyCollectionViewCell : ShadowCollectionViewCellBase {
    
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
        let currentTimeStamp = coin.data.last!.date//Unix time in milisecond
        var prevDayValue : Double = 0
        for el in coin.data {
            if currentTimeStamp - el.date >= Configuration.secondInOneDay {
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
        var percent = todayValue/prevDayValue * 100 - 100
        if (percent.isNaN) {
            percent = 0
        }
        currentValueLabel.text = "\(String.init(format: "%.5f", todayValue)), \(String.init(format: "%.2f", percent))%"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mainCellView.addSubview(nameLabel)
        mainCellView.addSubview(currentValueLabel)
        
        nameLabel.anchor(top: nil, left: mainCellView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 150, height: 30)
        currentValueLabel.anchor(top: nil, left: nameLabel.rightAnchor, bottom: nil, right: mainCellView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 0, height: 30)
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        currentValueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        nameLabel.textAlignment = .left
        currentValueLabel.textAlignment = .right
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
