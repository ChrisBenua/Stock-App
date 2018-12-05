//
//  ShadowCollectionViewCellBase.swift
//  Stock App
//
//  Created by Ирина Улитина on 05/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit

class ShadowCollectionViewCellBase : UICollectionViewCell {
    static let cellId = "CellId"

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
    
    ///Configure layer of mainCellView
    func layerSetUp() {
        mainCellView.layer.cornerRadius = 8
        mainCellView.backgroundColor = UIColor.mainCellBackgroundColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(shadowView)
        
        shadowView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        
        contentView.addSubview(mainCellView)
        layerSetUp()
        mainCellView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
