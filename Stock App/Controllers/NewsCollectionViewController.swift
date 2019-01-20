//
//  NewsCollectionViewController.swift
//  Stock App
//
//  Created by Ирина Улитина on 25/11/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"


class CustomSearchController : UISearchController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

class NewsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    ///Pull to refresh control
    var refresher : UIRefreshControl!
    
    ///Activity indicator
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)

    ///Add it to searchbar not to spam queries
    var timer : Timer?
    
    ///If there is nothing found on query
    var foundedZero = false
    
    ///SearchController for searching news
    let searchController = CustomSearchController(searchResultsController: nil)
    
    /// NewsItem DataSource
    var news = [NewsItem]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        PoloniexAPIHelper.fetchNames { (data) in
            CoinSearchCollectionViewController.coinNames = data
        }
        
        self.edgesForExtendedLayout = []
        collectionView.backgroundColor = UIColor.mainBlackColor()
        collectionView.alwaysBounceVertical = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        //self.navigationController?.navigationBar.barStyle = .black
        self.collectionView!.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.navigationController?.navigationBar.topItem?.title = "News"
        //Because of tabbar
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        setUpSearchBar()
        
        fetchNews()
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: #imageLiteral(resourceName: "refresh").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(toggleRefresher))]
        //Just for test
        //PoloniexAPIHelper.fetchCurrencyData(params: ["currencyPair" : "BTC_XMR", "start" : "1405699200", "end" : "1405728000", "period" : "14400"]) { (coinDataArr) in
            
        //}
        // Do any additional setup after loading the view.
    }

    //MARK:- Refresher
    @objc func toggleRefresher() {
        news.removeAll()
        collectionView.reloadData()
        fetchNews(text: searchController.searchBar.text!)
    }

    // MARK:- UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return news.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsCollectionViewCell
        
        
        cell.newsItem = news[indexPath.row]
        // Configure the cell
        
        return cell
    }

    //opening link, corresponding to news in browser
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: news[indexPath.row].externalUrl) else { return }
        UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly : false], completionHandler: nil)
    }
    
    //MARK:- UICollectionViewDelegateFlowLayOut
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    
    //MARK:- Working with API
    /// Fetching Data From newsriver.io
    func fetchNews(text : String = "Apple") {
        /*let ans : Data = APIHelper.shared.GetNews()
        do {
            let res = try JSONDecoder().decode(SearchResults.self, from: ans)
            news = res.elements
            collectionView.reloadData()
        } catch let err {
            print("Error while fetching data", err)
        }*/
        //news = APIHelper.shared.GetNews()
        //collectionView.reloadData()
        var finalText : String
        if (text.isEmpty) {
            finalText = "Apple"
        } else {
            finalText = text
        }
        AddActivityIndicator()
        APIHelper.shared.fetchAllNews(luceneParams: ["text" : finalText, "website.domainName" : "(coindesk.com OR cointelegraph.com)"], luceneLogicParams: ["AND"], simpleParams: ["sortBy" : "discoverDate", "sortOrder" : "DESC"], completionHandler: { (res) in
            self.news = res
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
            self.removeActivityIndicator()
        })
    }
}

//MARK:- SearchBarDelegate
extension NewsCollectionViewController : UISearchBarDelegate {
    
    
    ///Set Search Bar fields
    fileprivate func setUpSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Enter text to search"
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.fetchNews(text: searchText)
        })
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Began editing searchbar")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("End editing")
    }
    
}

//MARK:- ActivityIndicator
///Show and hide activity indicator
extension NewsCollectionViewController {
    fileprivate func AddActivityIndicator() {
        self.news = [NewsItem]()
        collectionView.reloadData()
        self.view.addSubview(activityIndicator)
        activityIndicator.frame.origin.y = 45 + (navigationController?.navigationBar.frame.height ?? 0) + (searchController.searchBar.frame.height)//45 because of status bar and uncollapsing bar
        //center it
        activityIndicator.frame.origin.x = view.frame.width / 2 - activityIndicator.frame.width / 2
        activityIndicator.startAnimating()
    }
    fileprivate func removeActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
