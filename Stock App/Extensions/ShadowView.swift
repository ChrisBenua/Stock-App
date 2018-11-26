//
//  ShadowVIew.swift
//  Stock App
//
//  Created by Ирина Улитина on 25/11/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit

/// UIView with shadow Bezier Path
class ShadowView: UIView {
    
    /// When bounds are set, we update Shadows
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    /// Setting up shadow
    private func setupShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 1.5, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.15
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
