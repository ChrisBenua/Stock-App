//
//  UserInfoHeader.swift
//  Stock App
//
//  Created by Ирина Улитина on 18/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit

enum UserProfileProvidedDataTypeEnum : Int {
    case balance = 0
    case transactions = 1
}

protocol UserProfileProvidedDataTypeChanged {
    func handleDataTypeChanged(type : UserProfileProvidedDataTypeEnum);
}

class UserInfoHeader : UICollectionViewCell {
    public static let headerId = "headerId"
    
    var delegate : UserProfileProvidedDataTypeChanged?
    
    let userNameTitle : PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 10))
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.numberOfLines = 2
        label.backgroundColor = UIColor.mainCellBackgroundColor()
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        return label
    }()
    
    lazy var segmentControl : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Balance", "Transactions"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(toggleDataTypeChanged), for: .valueChanged)
        sc.tintColor = UIColor.mainCellBackgroundColor()
        sc.backgroundColor = UIColor.mainBlackColor()
        
        return sc
    }()
    
    @objc func toggleDataTypeChanged() {
        print("toggleDataTypeChanged")
        delegate?.handleDataTypeChanged(type: UserProfileProvidedDataTypeEnum(rawValue: segmentControl.selectedSegmentIndex)!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(userNameTitle)
        contentView.addSubview(segmentControl)
        userNameTitle.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: segmentControl.topAnchor, right: contentView.rightAnchor, paddingTop: 4, paddingLeft: 13, paddingBottom: 10, paddingRight: 13, width: 0, height: 0)
        segmentControl.anchor(top: userNameTitle.bottomAnchor, left: nil, bottom: contentView.bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 300, height: 0)
        segmentControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
