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
    var alreadyFetched : [String : Coin] = [String : Coin]()
    var searchedCoins : [Coin] = [Coin]() {
        didSet {
            
        }
    }
    var searchedNames : [String]! {
        didSet {
            for el in searchedNames {
                alreadyFetched[el] = Coin()
            }
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    ///not to spam with queries, we will get banned
    var timer : Timer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchedNames = CoinSearchCollectionViewController.coinNames
        collectionView.backgroundColor = UIColor.mainBlackColor()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.topItem?.title = "Search"

        setUpSearchBar()
        
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.register(FlatCurrencyCollectionViewCell.self, forCellWithReuseIdentifier: FlatCurrencyCollectionViewCell.cellId)
        
    }
    
    
    //MARK:- UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cv = CoinDetailViewController(collectionViewLayout: UICollectionViewFlowLayout())
        cv.coinName = searchedCoins[indexPath.row].name
        navigationController?.pushViewController(cv, animated: true)
    }
    
    //MARK:- UICollectiomViewDataSource
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
        var Names = self.searchedNames!
        Names = Names.filter({ (str) -> Bool in
            return str.contains(text)
        })
        let timestamp = Int64.currentTimeStamp()
        searchedCoins.removeAll()
        collectionView.reloadData()
        for el in Names {
            var currentCoin : Coin = Coin()
            if !alreadyFetched[el]!.name.isEmpty {
                self.searchedCoins.append(alreadyFetched[el]!)
                self.collectionView.reloadData()
            } else {
                PoloniexAPIHelper.fetchCurrencyData(params: ["currencyPair" : el, "start" : timestamp-86400*2, "end" : timestamp, "period" : 86400]) { (data) in
                    currentCoin = Coin(name: el, data: data)
                    self.searchedCoins.append(currentCoin)
                    self.alreadyFetched[el] = currentCoin
                    self.collectionView.reloadData()
                    
                }
            }
        }
    }
}
