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

protocol DataSetSizeChangedDelegate {
    func dataSetSizeChanged(numberOfDays : Int);
}

class DetailCoinControllerHeader : UICollectionViewCell, UpdateDetailsViewControllerDelegate {
    func setChartData(lineData: LineChartData) {
        chartView.data = lineData
    }
    
    public static let headerId = "headerId"
    var delegate : DataSetSizeChangedDelegate?
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
    
    lazy var numberOfDaysControl : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["30 days", "15 days", "5 days"])
        sc.tintColor = UIColor.mainBlackColor()
        sc.addTarget(self, action: #selector(toggleNumberOfDaysControl), for: .valueChanged)
        return sc
    }()
    
    let nameHeaderLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        
        return label
    }()
    
    let graphView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.mainTitleLabelColor()
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    let chartView : LineChartView = {
        let chart = LineChartView()
        chart.gridBackgroundColor = UIColor.mainTextLabelColor()
        chart.drawGridBackgroundEnabled = true
        chart.backgroundColor = UIColor.mainTitleLabelColor()
        chart.legend.textColor = .white
        chart.autoScaleMinMaxEnabled = true
        chart.xAxis.labelTextColor = .white
        chart.leftAxis.labelTextColor = .white
        chart.rightAxis.labelTextColor = .white
        chart.xAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.rightAxis.drawGridLinesEnabled = false
        chart.xAxis.drawAxisLineEnabled = false
        //chart.leftAxis.drawAxisLineEnabled = false
        //chart.rightAxis.drawAxisLineEnabled = false
        chart.leftAxis.drawLabelsEnabled = false
        
        chart.xAxis.valueFormatter = TimestampToDateAxisValueFormatter()
        
        /*chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.labelTextColor = .white
        chart.xAxis.valueFormatter = TimestampToDateAxisValueFormatter()
        
        chart.leftAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawZeroLineEnabled = false
        chart.leftAxis.drawLabelsEnabled = false
        
        chart.rightAxis.drawGridLinesEnabled = false
        chart.rightAxis.drawZeroLineEnabled = false
        chart.rightAxis.labelTextColor = .white
        
        chart.gridBackgroundColor = UIColor.black
        chart.backgroundColor = UIColor.mainTitleLabelColor()*/
        
        return chart
    }()
    
    @objc func toggleNumberOfDaysControl() {
        self.delegate?.dataSetSizeChanged(numberOfDays: Configuration.daysSegmentControlData[numberOfDaysControl.selectedSegmentIndex])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(nameHeaderLabel)
        contentView.addSubview(graphView)
        graphView.addSubview(chartView)
        graphView.addSubview(numberOfDaysControl)
        
        nameHeaderLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        graphView.anchor(top: nameHeaderLabel.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 230)
        chartView.anchor(top: graphView.topAnchor, left: graphView.leftAnchor, bottom: nil, right: graphView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 180)
        numberOfDaysControl.anchor(top: chartView.bottomAnchor, left: nil, bottom: graphView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 200, height: 0)
        numberOfDaysControl.centerXAnchor.constraint(equalTo: graphView.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
