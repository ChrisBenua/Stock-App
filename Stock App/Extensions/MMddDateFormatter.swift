//
//  MMddDateFormatter.swift
//  Stock App
//
//  Created by Ирина Улитина on 05/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit

extension DateFormatter {
    /**
     Constructs DateFormatter with needed format
     - Parameter format: Date format, that will contain DateFormatter
     */
    static func MMddDateFormatter(format : String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = format //Specify your format that you want
        return dateFormatter
    }
}
