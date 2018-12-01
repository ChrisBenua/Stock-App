//
//  Colors.swift
//  Stock App
//
//  Created by Ирина Улитина on 25/11/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /// Color for Preview Text Label
    static func mainTextLabelColor() -> UIColor {
        return UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1.0)
    }
    /// Color for Title Text Label
    static func mainTitleLabelColor() -> UIColor {
        return UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1.0)
    }
    /// Color for News Collection View Cell's Background
    static func mainCellBackgroundColor() -> UIColor {
        return UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
    }
    /// Color for News Collection View Background
    static func mainBlackColor() -> UIColor {
        return UIColor(red: 12/255, green: 27/255, blue: 27/255, alpha: 1.0)
    }
    ///Color for tabbar Color
    static func mainTabBarColor() -> UIColor {
        return UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1.0)
    }
}
