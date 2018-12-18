//
//  BalanceCollectionCellView.swift
//  Stock App
//
//  Created by Ирина Улитина on 18/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit

class BalanceCollectionViewCell : ShadowCollectionViewCellBase {
    
    var coinBalance : CoinBalance! {
        didSet {
            symbolLabel.text = "Name:\n"+coinBalance.properties.propertyName
            var val = coinBalance.Value / Configuration.miliTokens
            valueLabel.text = "Amount:\n"+"\(val)"
        }
    }
    
    let symbolLabel : UILabel = {
       let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    let valueLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .right
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        mainCellView.addSubview(valueLabel)
        mainCellView.addSubview(symbolLabel)
        
        symbolLabel.anchor(top: nil, left: mainCellView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
        symbolLabel.centerYAnchor.constraint(equalTo: mainCellView.centerYAnchor).isActive = true
        valueLabel.anchor(top: nil, left: symbolLabel.rightAnchor, bottom: mainCellView.bottomAnchor, right: mainCellView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 50)
        valueLabel.centerYAnchor.constraint(equalTo: mainCellView.centerYAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
