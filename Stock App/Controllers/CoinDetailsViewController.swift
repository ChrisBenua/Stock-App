//
//  CoinDetailsViewController.swift
//  Stock App
//
//  Created by Ирина Улитина on 05/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit
import Charts

class CoinDetailViewController : UICollectionViewController {
    
    var delegate : UpdateDetailsViewControllerDelegate?
    
    func setCoin(coin: Coin) {
        self.coin = coin
    }
    
    var coinName : String! {
        didSet {
            fetchFavoriteCoinData(numberOfDays: 30, numberOfItemsOnGraph: 5)

        }
    }
    
    var coin : Coin = Coin() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(scrollView)
        
        //scrollView.contentSize = CGSize(width: view.frame.width, height: 1000)
       collectionView.register(DetailCoinCollectionViewCell.self, forCellWithReuseIdentifier: DetailCoinCollectionViewCell.cellId)
        collectionView?.register(DetailCoinControllerHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailCoinControllerHeader.headerId)
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationItem.title = "Coin Data"
    }
}

//MARK:- UICollectionViewDataSource

extension CoinDetailViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coin.data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCoinCollectionViewCell.cellId, for: indexPath) as! DetailCoinCollectionViewCell
        cell.coinData = coin.data[indexPath.row]
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

//MARK:- UICollectionViewDelegate
extension CoinDetailViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 30, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 260)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailCoinControllerHeader.headerId, for: indexPath) as! DetailCoinControllerHeader
        header.coinName = coinName
        self.delegate = header
        return header
    }
}
//MARK:- API
extension CoinDetailViewController {
    func fetchFavoriteCoinData(numberOfDays : Int64, numberOfItemsOnGraph : Int) {
        if coinName == nil {
            return
        }
        let timestamp = Int64.currentTimeStamp()
        PoloniexAPIHelper.fetchCurrencyData(params: ["currencyPair" : coinName! as Any, "start" : timestamp-86400*(numberOfDays + 1), "end" : timestamp, "period" : 86400]) { (data) in
            //currentCoin = Coin(name: name, data: data)
            self.coin = Coin(name: self.coinName, data: data)
            
            
            var arr : [ChartDataEntry] = [ChartDataEntry]()
            
            for el in data.suffix(numberOfItemsOnGraph) {
                arr.append(ChartDataEntry(x: Double(el.date), y: el.close))
            }
            
            let dataSet : LineChartDataSet = LineChartDataSet(values: arr, label : self.coinName)
            dataSet.setColor(UIColor.green)
            dataSet.valueTextColor = .white
            dataSet.circleRadius = 3
            dataSet.fillColor = .black
            let lineData = LineChartData(dataSet: dataSet)
            self.delegate?.setChartData(lineData: lineData)
        }
    }
}
