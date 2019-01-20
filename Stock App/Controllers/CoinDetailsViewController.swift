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
    /// was this coin marked as favourite by user
    private var isFavorite : Bool = false

    
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
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    fileprivate func setUpBarButtons() {
        let nameArray = UserDefaults.standard.getFavoriteCoinNames() ?? [String]()
        if (nameArray.contains(coinName)) {
            navigationItem.rightBarButtonItems = [UIBarButtonItem(image: #imageLiteral(resourceName: "starSelected").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(favoriteButtonPressed))]
        } else {
            navigationItem.rightBarButtonItems = [UIBarButtonItem(image: #imageLiteral(resourceName: "starUnselected").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(favoriteButtonPressed))]
        }
    }
    
    ///Switches image of star, if user clicked on favourite button
    fileprivate func switchImage() {
        if (isFavorite) {
            navigationItem.rightBarButtonItems?.first?.image = UIImage(imageLiteralResourceName: "starUnselected").withRenderingMode(.alwaysOriginal)
            isFavorite = false
            UserDefaults.standard.eraseCoinNameFromFavorites(nameToErase: coinName)
        } else {
            navigationItem.rightBarButtonItems?.first?.image = UIImage(imageLiteralResourceName: "starSelected").withRenderingMode(.alwaysOriginal)
            isFavorite = true
            UserDefaults.standard.addToFavoritesCoinNames(newName: coinName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let names = UserDefaults.standard.getFavoriteCoinNames() ?? [String]()
        isFavorite = names.contains(coinName)
        //view.addSubview(scrollView)
        self.navigationItem.title = coinName
        //self.navigationItem.rightBarButtonItem
        UserDefaults.standard.addToRecentCoinNames(newName: coinName)
        
        //self.navigationController?.navigationBar.isTranslucent = true
        print(navigationController?.navigationBar)
        //print(navigationItem.searchController?.searchBar.frame)
        //navigationItem.searchController?.searchBar.isHidden = true
        //scrollView.contentSize = CGSize(width: view.frame.width, height: 1000)
        
        let refresh = UIRefreshControl()
        refresh.tintColor = .white
        collectionView.refreshControl = refresh
        refresh.addTarget(self, action: #selector(toggleRefresh), for: .valueChanged)
        
        
       collectionView.register(DetailCoinCollectionViewCell.self, forCellWithReuseIdentifier: DetailCoinCollectionViewCell.cellId)
        collectionView?.register(DetailCoinControllerHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailCoinControllerHeader.headerId)
        
        setUpBarButtons()
    }
    
    @objc func toggleRefresh() {
        self.coin.data.removeAll()
        self.collectionView.reloadData()
        fetchFavoriteCoinData(numberOfDays: 30, numberOfItemsOnGraph: 5)

    }
    
    @objc func favoriteButtonPressed() {
        switchImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
        return CGSize(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailCoinControllerHeader.headerId, for: indexPath) as! DetailCoinControllerHeader
        header.coinName = coinName
        self.delegate = header
        header.delegate = self
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
        PoloniexAPIHelper.fetchCurrencyData(params: ["currencyPair" : coinName! as Any, "start" : timestamp-Configuration.secondInOneDay*(numberOfDays + 1), "end" : timestamp, "period" : Configuration.secondInOneDay]) { (data) in
            //currentCoin = Coin(name: name, data: data)
            var rData = data
            rData.reverse()
            self.coin = Coin(name: self.coinName, data: rData)
            
            
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

//MARK:- DataSetSizeChangedDelegate

extension CoinDetailViewController : DataSetSizeChangedDelegate {
    func dataSetSizeChanged(numberOfDays: Int) {
        var data = coin.data
        data.reverse()
        var arr : [ChartDataEntry] = [ChartDataEntry]()
        
        for el in data.suffix(numberOfDays) {
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
