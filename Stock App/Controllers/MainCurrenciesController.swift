//
// Created by Ирина Улитина on 2018-12-02.
// Copyright (c) 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit
import Charts

class MainCurrenciesController : UIViewController {
    /// We should fetch it from database(CoreData)
    var recentCurrencies = [Coin]()
    var chart : LineChartView = LineChartView()
    
    let favoriteHeader : UILabel = {
       let label = UILabel()
        label.text = "Your Favorite"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()

    let graphView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainBlackColor()
        return view
    }()

    let recentlyUsedLabel : UILabel = {
       let label = UILabel()
        label.text = "You've recently seen"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 1
        return label
    }()

    lazy var recentlyUsedCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.mainBlackColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CurrencyCollectionViewCell.self, forCellWithReuseIdentifier: CurrencyCollectionViewCell.cellId)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetUp()
        fetchCoinsData()
        fetchFavoriteCoinData(numberOfDays: 5)
    }
    
    ///All anchors and another stuff set up
    fileprivate func layoutSetUp() {
        chart.gridBackgroundColor = UIColor.mainTextLabelColor()
        chart.drawGridBackgroundEnabled = true
        chart.backgroundColor = UIColor.mainTitleLabelColor()
        chart.layer.cornerRadius = 8
        chart.clipsToBounds = true
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
        
        self.view.backgroundColor = UIColor.mainBlackColor()
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.topItem?.title = "All currencies"
        view.addSubview(favoriteHeader)
        view.addSubview(graphView)
        view.addSubview(recentlyUsedLabel)
        view.addSubview(recentlyUsedCollectionView)
        graphView.addSubview(chart)
        favoriteHeader.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 25, paddingBottom: 0, paddingRight: 3, width: 0, height: 40)
        graphView.anchor(top: favoriteHeader.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 200)
        recentlyUsedLabel.anchor(top: graphView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 25, paddingLeft: 25, paddingBottom: 0, paddingRight: 20, width: 0, height: 40)
        recentlyUsedCollectionView.anchor(top: recentlyUsedLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 170)
        chart.anchor(top: graphView.topAnchor, left: graphView.leftAnchor, bottom: graphView.bottomAnchor, right: graphView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        //recentlyUsedCollectionView.layoutMargins.left = 20
    }
    
    func fetchCoinsData() {
        let recentCoinsNames = String.getCoinsNames()
        let timestamp = Int64.currentTimeStamp()
        for el in recentCoinsNames {
            var currentCoin : Coin = Coin()
            PoloniexAPIHelper.fetchCurrencyData(params: ["currencyPair" : el, "start" : timestamp-86400*2, "end" : timestamp, "period" : 86400]) { (data) in
                currentCoin = Coin(name: el, data: data)
                self.recentCurrencies.append(currentCoin)
                self.recentlyUsedCollectionView.reloadData()
            }
        }
    }
}

//MARK:- UICollectionViewDelegate
extension MainCurrenciesController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cv = CoinDetailViewController(collectionViewLayout: UICollectionViewFlowLayout())
        cv.coinName = recentCurrencies[indexPath.row].name
        navigationController?.pushViewController(cv, animated: true)
    }
}

//MARK:- UICollectionViewDataSource
extension MainCurrenciesController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentCurrencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCollectionViewCell.cellId, for: indexPath) as! CurrencyCollectionViewCell
        cell.coin = recentCurrencies[indexPath.row]
        return cell
    }
    
    
}

//MARK:- UICollectionViewDelegateFlowLayout
extension MainCurrenciesController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
}

///MARK:- Charts
extension  MainCurrenciesController {
    func fetchFavoriteCoinData(numberOfDays : Int64) {
        let name = String.getCoinsNames().first
        let timestamp = Int64.currentTimeStamp()
        PoloniexAPIHelper.fetchCurrencyData(params: ["currencyPair" : name! as Any, "start" : timestamp-86400*(numberOfDays + 1), "end" : timestamp, "period" : 86400]) { (data) in
            //currentCoin = Coin(name: name, data: data)
            var arr : [ChartDataEntry] = [ChartDataEntry]()
            for el in data {
                arr.append(ChartDataEntry(x: Double(el.date), y: el.close))
            }
            
            let dataSet : LineChartDataSet = LineChartDataSet(values: arr, label : name)
            dataSet.setColor(UIColor.green)
            dataSet.valueTextColor = .white
            dataSet.circleRadius = 3
            dataSet.fillColor = .black
            let lineData = LineChartData(dataSet: dataSet)
            self.chart.data = lineData
        }
    }
}
