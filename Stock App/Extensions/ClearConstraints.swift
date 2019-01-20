//
//  ClearConstraints.swift
//  Stock App
//
//  Created by Ирина Улитина on 04/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    ///Leaves no constraints for current view
    func removeAllConstraints() {
        for el in self.constraints {
            self.removeConstraint(el)
        }
    }
}
