//
//  CurrencyCollectionViewCell.swift
//  Stock App
//
//  Created by Ирина Улитина on 02/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit

class CurrencyCollectionViewCell : UICollectionViewCell {
    static let cellId = "CellId"
    ///this coin's data should be represented in this cell somehow
    var coin : Coin! {
        didSet {
            configureCurrentValueLabel()
            var name = coin.name
            let fifthIndex = String.Index(encodedOffset: 4)
            nameLabel.text = String(coin.name.suffix(from: fifthIndex))
        }
    }
    
    
    /// Cornered analog for ContentView
    let mainCellView : UIView = {
        let iv = UIView()
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.mainCellBackgroundColor()
        return iv
    }()
    /// View with shadows, below all views in cells
    let shadowView : ShadowView = {
        let view = ShadowView()
        return view
    }()
    
    ///Label for coin name
    let nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24)
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
    
    ///Configure layer of mainCellView
    func layerSetUp() {
        mainCellView.layer.cornerRadius = 8
        mainCellView.backgroundColor = UIColor.mainCellBackgroundColor()
    }
    
    func configureCurrentValueLabel() {
        let currentTimeStamp = coin.data.last!.date//Unix time in milisecond
        var prevDayValue : Double = 0
        for el in coin.data {
            if currentTimeStamp - el.date >= 86400 {
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
        currentValueLabel.text = "\(String.init(format: "%.4f", todayValue)), \(String.init(format: "%.2f", todayValue/prevDayValue * 100 - 100))%"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(shadowView)
        
        shadowView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        
        contentView.addSubview(mainCellView)
        layerSetUp()
        mainCellView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        
        mainCellView.addSubview(nameLabel)
        nameLabel.anchor(top: mainCellView.topAnchor, left: mainCellView.leftAnchor, bottom: nil, right: mainCellView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 10, width: 0, height: 35)
        
        mainCellView.addSubview(currentValueLabel)
        currentValueLabel.anchor(top: nil, left: mainCellView.leftAnchor, bottom: mainCellView.bottomAnchor, right: mainCellView.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
