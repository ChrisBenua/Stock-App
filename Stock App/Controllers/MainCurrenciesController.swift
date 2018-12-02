//
// Created by Ирина Улитина on 2018-12-02.
// Copyright (c) 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit

class MainCurrenciesController : UIViewController {
    /// We should fetch it from database(CoreData)
    var recentCurrencies = [Coin]()
    
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
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ViewForGraph")
        view.addSubview(imageView)
        imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CurrencyCollectionViewCell.self, forCellWithReuseIdentifier: CurrencyCollectionViewCell.cellId)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetUp()
        fetchCoinsData()
    }
    
    ///All anchors and another stuff set up
    fileprivate func layoutSetUp() {
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.topItem?.title = "All currencies"
        view.addSubview(favoriteHeader)
        view.addSubview(graphView)
        view.addSubview(recentlyUsedLabel)
        view.addSubview(recentlyUsedCollectionView)
        favoriteHeader.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 25, paddingBottom: 0, paddingRight: 3, width: 0, height: 40)
        graphView.anchor(top: favoriteHeader.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 200)
        recentlyUsedLabel.anchor(top: graphView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 25, paddingLeft: 25, paddingBottom: 0, paddingRight: 20, width: 0, height: 40)
        recentlyUsedCollectionView.anchor(top: recentlyUsedLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 160)
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
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
}


