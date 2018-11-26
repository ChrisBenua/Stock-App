//
//  NewsCollectionViewController.swift
//  Stock App
//
//  Created by Ирина Улитина on 25/11/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class NewsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var news = [NewsItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.mainBlackColor()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        fetchNews()
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
    
    func fetchNews() {
        /*let ans : Data = APIHelper.shared.GetNews()
        do {
            let res = try JSONDecoder().decode(SearchResults.self, from: ans)
            news = res.elements
            collectionView.reloadData()
        } catch let err {
            print("Error while fetching data", err)
        }*/
        news = APIHelper.shared.GetNews()
        collectionView.reloadData()
    }
}
