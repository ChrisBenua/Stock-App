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
    /// All coins names, fetched in NewsCollectionController
    public static var coinNames = [String]()
    /// Last fetch for coin name
    var fetchDate : [String : Int64] = [String : Int64]()
    /// Points whether coin with following name was fetched or not
    var alreadyFetched : [String : Coin] = [String : Coin]()
    /// DataSource for collection view
    var searchedCoins : [Coin] = [Coin]() {
        didSet {
            
        }
    }
    
    var searchedNames : [String]! {
        didSet {
            for el in searchedNames {
                alreadyFetched[el] = Coin()
                fetchDate[el] = 0
            }
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    ///timer to delay queries, not to spam with them, we will get banned
    var timer : Timer?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Enter coin to search"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomHeader()
        searchedNames = CoinSearchCollectionViewController.coinNames
        collectionView.backgroundColor = UIColor.mainBlackColor()
        navigationController?.navigationBar.topItem?.title = "Search"

        setUpSearchBar()
        
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.register(FlatCurrencyCollectionViewCell.self, forCellWithReuseIdentifier: FlatCurrencyCollectionViewCell.cellId)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Help", style: .plain, target: self, action: #selector(handleInfoTap))
    }
    
    @objc func handleInfoTap() {
        let alertController = UIAlertController(title: "About search", message: "1) All search letters should be capital\n 2) Format: Search query should be like USDC_BTC: BTC price in USDC currency", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Get it!", style: .destructive, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    ///View to represent message, that nothing was found
    lazy var customHeaderView : UIView = {
        let v = UIView()
        let label = UILabel()
        label.text = "I Found Nothing"
        label.textColor = .white
        v.backgroundColor = UIColor.mainBlackColor()
        v.addSubview(label)
        label.anchor(top: v.topAnchor, left: v.leftAnchor, bottom: v.bottomAnchor, right: v.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        label.textAlignment = .center
        return v
    }()
    
    //MARK:- UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cv = CoinDetailViewController(collectionViewLayout: UICollectionViewFlowLayout())
        cv.coinName = searchedCoins[indexPath.row].name
        searchController.isActive = false
        navigationItem.searchController = nil
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
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
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

//MARK:- Custom Header

extension CoinSearchCollectionViewController {
    ///Nothing Found
    func addCustomHeader() {
        if (customHeaderView.superview == nil) {
            view.addSubview(customHeaderView)
            customHeaderView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        }
    }
    func removeCustomHeader() {
        customHeaderView.removeFromSuperview()
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
        addCustomHeader()
        for el in Names {
            var currentCoin : Coin = Coin()
            print(Int64.currentTimeStamp())
            print(fetchDate[el]!)
            print(Int64.currentTimeStamp() - fetchDate[el]!)
            if !alreadyFetched[el]!.name.isEmpty && Int64.currentTimeStamp() - fetchDate[el]! < Configuration.expiringDataTime {
                self.searchedCoins.append(alreadyFetched[el]!)
                self.removeCustomHeader()
                self.collectionView.reloadData()
            } else {
                PoloniexAPIHelper.fetchCurrencyData(params: ["currencyPair" : el, "start" : timestamp-Configuration.secondInOneDay*2, "end" : timestamp, "period" : Configuration.secondInOneDay]) { (data) in
                    currentCoin = Coin(name: el, data: data)
                    self.alreadyFetched[el] = currentCoin
                    self.fetchDate[el] = Int64.currentTimeStamp()
                    print(self.searchController.searchBar.text!)
                    if (text == self.searchController.searchBar.text!) {
                        self.searchedCoins.append(currentCoin)
                        self.removeCustomHeader()
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
}
