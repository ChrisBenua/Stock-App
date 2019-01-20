//
//  ChartXAxisValueFormatter.swift
//  Stock App
//
//  Created by Ирина Улитина on 04/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import Charts
import UIKit

///Class that handler conversion from Unix TimeStamp to MM.dd Date Format
class TimestampToDateAxisValueFormatter : IAxisValueFormatter {
    ///IAxisValueFormatter protocol function
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(value))
        let strDate = DateFormatter.MMddDateFormatter(format: "MM.dd").string(from: date)
        return strDate
    }
    
}
