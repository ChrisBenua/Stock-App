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
            if (transaction.to == username) {
                toLabel.textColor = UIColor.green
            }
            
            if (transaction.from == username) {
                fromLabel.textColor = UIColor.green
            }
            toLabel.text = transaction.to
            fromLabel.text = transaction.from
            typeLabel.text = "Type : " + transaction.type
            amountLabel.text = String.init(format: "%.4f", transaction.Amount)
            amountLabel.widthAnchor.constraint(equalToConstant: amountLabel.sizeThatFits(CGSize(width: 200, height: 50)).width + 3).isActive = true
        }
    }
    
    var toLabel : PaddingLabel = {
       let label = PaddingLabel(padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.mainTextLabelColor()
        label.textColor = UIColor.lightText
        label.textAlignment = .left
        return label
    }()
    
    var fromLabel : PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.mainTextLabelColor()
        label.textColor = UIColor.lightText
        label.textAlignment = .left
        return label
    }()
    
    var typeLabel : PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
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
        let label = PaddingLabel(padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.mainTextLabelColor()
        label.textColor = UIColor.lightText
        label.textAlignment = .right
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        mainCellView.addSubview(toLabel)
        mainCellView.addSubview(fromLabel)
        mainCellView.addSubview(typeLabel)
        mainCellView.addSubview(amountLabel)
        mainCellView.addSubview(downArrowImageView)
        
        typeLabel.anchor(top: mainCellView.topAnchor, left: mainCellView.leftAnchor, bottom: fromLabel.topAnchor, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 200, height: 0)
        
        fromLabel.anchor(top: typeLabel.bottomAnchor, left: typeLabel.leftAnchor, bottom: downArrowImageView.topAnchor, right: mainCellView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
        downArrowImageView.anchor(top: fromLabel.bottomAnchor, left: nil, bottom: toLabel.topAnchor, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 4, paddingRight: 0, width: 50, height: 0)
        downArrowImageView.centerXAnchor.constraint(equalTo: fromLabel.centerXAnchor).isActive = true
        
        toLabel.anchor(top: downArrowImageView.bottomAnchor, left: mainCellView.leftAnchor, bottom: mainCellView.bottomAnchor, right: mainCellView.rightAnchor, paddingTop: 4, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
        amountLabel.anchor(top: mainCellView.topAnchor, left: typeLabel.rightAnchor, bottom: fromLabel.topAnchor, right: mainCellView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
