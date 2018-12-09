//
//  DetailCoinCollectionViewCell.swift
//  Stock App
//
//  Created by Ирина Улитина on 05/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit

class DetailCoinCollectionViewCell : ShadowCollectionViewCellBase {
    
    var coinData : CoinData! {
        didSet {
            dateLabel.text = DateFormatter.MMddDateFormatter(format : "MM-dd-yyyy").string(from: Date(timeIntervalSince1970: TimeInterval(coinData.date)))
            openLabel.text = "Open:\n \(String.init(format: "%.4f", coinData.open))"
            closeLabel.text = "Close:\n \(String.init(format: "%.4f", coinData.close))"
            lowLabel.text = "Low:\n \(String.init(format: "%.4f", coinData.low))"
            highLabel.text = "High:\n \(String.init(format: "%.4f", coinData.high))"
        }
    }
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        //label.backgroundColor = .yellow
        label.textAlignment = .center
        return label
    }()
    
    let openLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        //label.backgroundColor = .red
        return label
    }()
    
    let closeLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        //label.backgroundColor = .green
        label.textAlignment = .center
        return label
    }()
    
    let highLabel : UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.numberOfLines = 2
        //label.backgroundColor = .red
        label.textAlignment = .center
        return label
    }()
    
    let lowLabel : UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        mainCellView.addSubview(dateLabel)
        mainCellView.addSubview(openLabel)
        mainCellView.addSubview(closeLabel)
        mainCellView.addSubview(highLabel)
        mainCellView.addSubview(lowLabel)
        print(contentView.frame.width)
        dateLabel.anchor(top: mainCellView.topAnchor, left: mainCellView.leftAnchor, bottom: nil, right: mainCellView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 25)
        openLabel.anchor(top: dateLabel.bottomAnchor, left: mainCellView.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: contentView.frame.width / 2 - 5, height: 50)
        closeLabel.anchor(top: openLabel.bottomAnchor, left: mainCellView.leftAnchor, bottom: mainCellView.bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: contentView.frame.width / 2 - 5, height: 0)
        highLabel.anchor(top: dateLabel.bottomAnchor, left: openLabel.rightAnchor, bottom: nil, right: mainCellView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 5, width: 0, height: 50)
        lowLabel.anchor(top: highLabel.bottomAnchor, left: openLabel.rightAnchor, bottom: mainCellView.bottomAnchor, right: mainCellView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
