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
    var lineChartDataSets = [LineChartData]()
    var coinNameToIndex = [String : Int]()
    
    var index : Int = 0 {
        didSet {
            if (index < 0) {
                index += lineChartDataSets.count
            }
            if (index >= lineChartDataSets.count) {
                index -= lineChartDataSets.count
            }
            chart.data = lineChartDataSets[index]
        }
    }
    
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
        view.backgroundColor = UIColor.mainTitleLabelColor()
        view.layer.cornerRadius = 9
        view.clipsToBounds = true
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.index = self.index >= UserDefaults.standard.getFavoriteCoinNames()?.count ?? 0 ? 0 : self.index
        fetchCoinsData()
        fetchFavoriteCoinData(numberOfDays: 5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetUp()
        //fetchCoinsData()
        fetchFavoriteCoinData(numberOfDays: 5)
    }
    
    ///All anchors and another stuff set up
    fileprivate func layoutSetUp() {
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
        
        let swipe = UIPanGestureRecognizer(target: self, action: #selector(handleLeftSwipe(_:)))
        chart.addGestureRecognizer(swipe)
        let doubleClick = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleClick.numberOfTapsRequired = 2
        chart.addGestureRecognizer(doubleClick)
        
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
        graphView.anchor(top: favoriteHeader.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 200)
        recentlyUsedLabel.anchor(top: graphView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 25, paddingLeft: 25, paddingBottom: 0, paddingRight: 20, width: 0, height: 40)
        recentlyUsedCollectionView.anchor(top: recentlyUsedLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 170)
        chart.anchor(top: graphView.topAnchor, left: graphView.leftAnchor, bottom: graphView.bottomAnchor, right: graphView.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 10, paddingRight: 5, width: 0, height: 0)
        //recentlyUsedCollectionView.layoutMargins.left = 20
    }
    
    @objc func doubleTapped() {
        let cv = CoinDetailViewController(collectionViewLayout: UICollectionViewFlowLayout())
        guard let names = UserDefaults.standard.getFavoriteCoinNames() else { return }
        cv.coinName = names[index]
        navigationController?.pushViewController(cv, animated: true)
    }
    
    @objc func handleLeftSwipe(_ sender:UIPanGestureRecognizer) {
        print("Left Swipe")
        if sender.state == .changed {
            let translation = sender.translation(in: graphView)
            graphView.transform = CGAffineTransform(translationX: translation.x, y: 0)
        }
        else if sender.state == .ended {
            let translation = sender.translation(in: graphView)
            /*UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.graphView.transform = .identity
                
                if translation.x > 50 {
                    print("going to prev")
                }
                
                if translation.x < -50 {
                    print("going to next")
                }
                
            })*/
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                if (translation.x > 50) {
                    self.graphView.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
                    self.index = self.index - 1
                } else if (translation.x < -50) {
                    self.graphView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
                    self.index = self.index + 1
                } else {
                    self.graphView.transform = .identity
                }
                //self.graphView.transform = CGAffineTransform(translationX: <#T##CGFloat#>, y: <#T##CGFloat#>)
            }) { (_) in
                if (translation.x > 50) {
                    self.graphView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
                } else if (translation.x < -50) {
                    self.graphView.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
                } else {
                    self.graphView.transform = .identity
                }
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                    self.graphView.transform = .identity
                }, completion: { (_) in
                    
                })
            }
        }
    }
    
    @objc func handleRightSwipe(_ sender:UISwipeGestureRecognizer) {
        print("Right Swipe")
    }
    
    func fetchCoinsData() {
        var recentCoinsNames = String.getCoinsNames()
        if (recentCoinsNames.isEmpty) {
            recentCoinsNames.append("USDC_BTC")
            recentCoinsNames.append("USDC_XMR")
            recentCoinsNames.append("USDC_XRP")
        }
        let timestamp = Int64.currentTimeStamp()
        recentCurrencies = Array(repeating: Coin(), count: recentCoinsNames.count)
        var places : [String : Int] = [String : Int]()
        
        for i in 0..<recentCoinsNames.count {
            places[recentCoinsNames[i]] = i
        }
        var cnt = 0
        for el in recentCoinsNames {
            var currentCoin : Coin = Coin()
            PoloniexAPIHelper.fetchCurrencyData(params: ["currencyPair" : el, "start" : timestamp-Configuration.secondInOneDay*2, "end" : timestamp, "period" : Configuration.secondInOneDay]) { (data) in
                currentCoin = Coin(name: el, data: data)
                self.recentCurrencies[places[el]!] = currentCoin
                cnt += 1
                //if (cnt == self.recentCurrencies.count) {
                    self.recentlyUsedCollectionView.reloadData()
                //}
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
        let nameArray = UserDefaults.standard.getFavoriteCoinNames() ?? ["USDC_BTC"]
        lineChartDataSets = Array(repeating: LineChartData(), count: nameArray.count)
        coinNameToIndex.removeAll()
        for i in 0..<nameArray.count {
            coinNameToIndex[nameArray[i]] = i
        }
        //let name = nameArray.first
        let timestamp = Int64.currentTimeStamp()
        for name in nameArray {
            PoloniexAPIHelper.fetchCurrencyData(params: ["currencyPair" : name as Any, "start" : timestamp-Configuration.secondInOneDay*(numberOfDays + 1), "end" : timestamp, "period" : Configuration.secondInOneDay]) { (data) in
                //currentCoin = Coin(name: name, data: data)
                var arr : [ChartDataEntry] = [ChartDataEntry]()
                for el in data.suffix(Int(numberOfDays)) {
                    arr.append(ChartDataEntry(x: Double(el.date), y: el.close))
                }
                guard let index = self.coinNameToIndex[name] else { return }
                let dataSet : LineChartDataSet = LineChartDataSet(values: arr, label : name + " \(index + 1) / \(self.coinNameToIndex.count)")
                dataSet.setColor(UIColor.green)
                dataSet.valueTextColor = .white
                dataSet.circleRadius = 3
                dataSet.fillColor = .black
                let lineData = LineChartData(dataSet: dataSet)
                self.lineChartDataSets[index] = lineData
                if (nameArray.index(of: name) == self.index || self.chart.data == nil) {
                    self.chart.data = lineData
                }
                //self.chart.data = lineData
                
            }
        }
    }
}
