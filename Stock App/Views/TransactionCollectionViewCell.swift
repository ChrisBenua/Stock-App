//
//  TransactionCollectionViewCell.swift
//  Stock App
//
//  Created by Ирина Улитина on 22/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit

class TransactionCollectionViewCell : ShadowCollectionViewCellBase {
    public static var cellId1 = "cellid1"
    
    var username : String!
    
    var transaction : Transaction! {
        didSet {
            if (transaction.from == username) {
                toLabel.textColor = UIColor.green
            }
            
            if (transaction.to == username) {
                fromLabel.textColor = UIColor.green
            }
            toLabel.text = transaction.from
            fromLabel.text = transaction.to
            typeLabel.text = "Type : " + transaction.type
            if (transaction.Amount >= 10000) {
                amountLabel.text = String.init(format: "%.0f", transaction.Amount) + " \(transaction.coinName)"
            } else {
                amountLabel.text = String.init(format: "%.4f", transaction.Amount) + " \(transaction.coinName)"
            }
            
            amountLabel.widthAnchor.constraint(equalToConstant: amountLabel.sizeThatFits(CGSize(width: 200, height: 50)).width + 3).isActive = true
            
            dateLabel.text = "Date: " + DateFormatter.MMddDateFormatter(format: "MM/dd/yy").string(from: Date(timeIntervalSince1970: transaction.blockTime))
        }
    }
    
    var toLabel : PaddingLabel = {
       let label = PaddingLabel(padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.mainTextLabelColor()
        label.textColor = UIColor.lightText
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    var fromLabel : PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.mainTextLabelColor()
        label.textColor = UIColor.lightText
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    var typeLabel : PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        //label.backgroundColor = UIColor.darkGray
        label.textColor = UIColor.white
        return label
    }()
    
    var downArrowImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "downarrow")
        return iv
    }()
    
    var amountLabel : PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 4, left: 2, bottom: 4, right: 2))
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.mainTextLabelColor()
        label.textColor = UIColor.lightText
        label.textAlignment = .right
        return label
    }()
    
    var dateLabel : UILabel = {
       var label = UILabel()
        label.textColor = UIColor.lightText
        label.textAlignment = .left
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        mainCellView.addSubview(toLabel)
        mainCellView.addSubview(fromLabel)
        mainCellView.addSubview(typeLabel)
        mainCellView.addSubview(amountLabel)
        mainCellView.addSubview(downArrowImageView)
        mainCellView.addSubview(dateLabel)
        
        typeLabel.anchor(top: mainCellView.topAnchor, left: mainCellView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        
        fromLabel.anchor(top: typeLabel.bottomAnchor, left: typeLabel.leftAnchor, bottom: downArrowImageView.topAnchor, right: mainCellView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
        downArrowImageView.anchor(top: nil, left: nil, bottom: toLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 4, paddingRight: 0, width: 50, height: 0)
        downArrowImageView.centerXAnchor.constraint(equalTo: fromLabel.centerXAnchor).isActive = true
        
        toLabel.anchor(top: nil, left: mainCellView.leftAnchor, bottom: mainCellView.bottomAnchor, right: mainCellView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
        amountLabel.anchor(top: mainCellView.topAnchor, left: typeLabel.rightAnchor, bottom: fromLabel.topAnchor, right: mainCellView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
        dateLabel.anchor(top: downArrowImageView.topAnchor, left: mainCellView.leftAnchor, bottom: downArrowImageView.bottomAnchor, right: downArrowImageView.leftAnchor, paddingTop: 0, paddingLeft: 14, paddingBottom: 5, paddingRight: 0, width: 0, height: 0)
        
        //shadowView.setupShadow()
        //shadowView.layer.shadowOpacity = 1
        //shadowView.layer.shadowRadius = 10
        //print(bounds)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
