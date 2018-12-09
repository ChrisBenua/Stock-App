//
//  DetailCoinControllerHeader.swift
//  Stock App
//
//  Created by Ирина Улитина on 05/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit
import Charts

protocol UpdateDetailsViewControllerDelegate {
    func setChartData(lineData : LineChartData);
}

class DetailCoinControllerHeader : UICollectionViewCell, UpdateDetailsViewControllerDelegate {
    func setChartData(lineData: LineChartData) {
        chartView.data = lineData
    }
    
    public static let headerId = "headerId"
    var delegate : UpdateDetailsViewControllerDelegate?
    var coinName : String! {
        didSet {
            nameHeaderLabel.text = coinName
        }
    }
    
    var coin : Coin = Coin() {
        didSet {
            //self.collectionView.reloadData()
        }
    }
    
    let nameHeaderLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        
        return label
    }()
    
    let graphView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.mainTitleLabelColor()
        return v
    }()
    
    let chartView : LineChartView = {
        let chart = LineChartView()
        chart.layer.cornerRadius = 8
        chart.clipsToBounds = true
        chart.xAxis.drawAxisLineEnabled = false
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.labelTextColor = .white
        chart.xAxis.valueFormatter = TimestampToDateAxisValueFormatter()
        
        chart.leftAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawAxisLineEnabled = false
        chart.leftAxis.drawZeroLineEnabled = false
        chart.leftAxis.drawLabelsEnabled = false
        
        chart.rightAxis.drawGridLinesEnabled = false
        chart.rightAxis.drawZeroLineEnabled = false
        chart.rightAxis.drawAxisLineEnabled = false
        chart.rightAxis.labelTextColor = .white
        
        chart.gridBackgroundColor = UIColor.mainTextLabelColor()
        chart.backgroundColor = UIColor.mainTitleLabelColor()
        
        return chart
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(nameHeaderLabel)
        contentView.addSubview(chartView)
        nameHeaderLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        chartView.anchor(top: nameHeaderLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 20, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
