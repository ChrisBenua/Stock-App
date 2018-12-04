//
//  CoinSearchCollectionViewController.swift
//  Stock App
//
//  Created by Ирина Улитина on 04/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit


class CoinSearchCollectionViewController : UICollectionViewController {
    public static var coinNames = [String]()
    var allCoins : [Coin] = [Coin]()
    var searchedCoins : [Coin] = [Coin]()
    
    let searchController = UISearchController(searchResultsController: nil)
    ///not to spam with queries, we will get banned
    var timer : Timer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.mainBlackColor()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.topItem?.title = "Search"

        setUpSearchBar()
        
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.register(FlatCurrencyCollectionViewCell.self, forCellWithReuseIdentifier: FlatCurrencyCollectionViewCell.cellId)
        
    }
    
    ///MARK:- UICollectiomViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedCoins.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlatCurrencyCollectionViewCell.cellId, for: indexPath) as! FlatCurrencyCollectionViewCell
        cell.coin = searchedCoins[indexPath.row]
        return cell
    }
}

//MARK:- UICollectionViewDelegateFlowLayout

extension CoinSearchCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 20, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

//MARK:- SearchBardelegate
extension CoinSearchCollectionViewController : UISearchBarDelegate {
    
    
    ///Set Search Bar fields
    fileprivate func setUpSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Enter coin to search"
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            //self.fetchNews(text: searchText)
            self.fetchCoinsWithNames(text: searchText)
        })
    }
}
//MARK:- API
extension CoinSearchCollectionViewController {
    func fetchCoinsWithNames(text : String) {
        var searchedNames = CoinSearchCollectionViewController.coinNames
        searchedNames = searchedNames.filter({ (str) -> Bool in
            return str.contains(text)
        })
        let timestamp = Int64.currentTimeStamp()
        searchedCoins.removeAll()
        collectionView.reloadData()
        for el in searchedNames {
            var currentCoin : Coin = Coin()
            PoloniexAPIHelper.fetchCurrencyData(params: ["currencyPair" : el, "start" : timestamp-86400*2, "end" : timestamp, "period" : 86400]) { (data) in
                currentCoin = Coin(name: el, data: data)
                self.searchedCoins.append(currentCoin)
                self.collectionView.reloadData()
            }
        }
    }
}
