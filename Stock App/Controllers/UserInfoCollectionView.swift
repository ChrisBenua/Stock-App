//
//  UserInfoCollectionView.swift
//  Stock App
//
//  Created by Ирина Улитина on 18/12/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import Foundation
import UIKit

class UserInfoCollectionViewController : UICollectionViewController {
    
    var user : UserInfo = UserInfo() {
        didSet {
            collectionView.reloadData()
            collectionView.refreshControl?.endRefreshing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        navigationItem.title = "Your Omni Data"
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = true
        refreshControl.tintColor = .white
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(toggleRefresh), for: .valueChanged)
        collectionView.register(BalanceCollectionViewCell.self, forCellWithReuseIdentifier: BalanceCollectionViewCell.cellId)
        collectionView.register(UserInfoHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UserInfoHeader.headerId)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(toggleSettings))]
        fetchUserData()
    }
    
    @objc func toggleSettings() {
        let alertController = UIAlertController(title: "Omni ID", message: "Enter your omni Id", preferredStyle: .alert)
        
        alertController.addTextField { (tf) in
            tf.placeholder = "Omni ID"
            //1NTMakcgVwQpMdGxRQnFKyb3G1FAJysSfztf.cop
        }
        
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] (action) in
            print(alertController?.textFields?.first?.text)
            UserDefaults.standard.saveOmniId(id: alertController?.textFields?.first?.text ?? "1FoWyxwPXuj4C6abqwhjDWdz6D4PZgYRjA")
            self.fetchUserData()
            
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func toggleRefresh() {
        fetchUserData()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.balance.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BalanceCollectionViewCell.cellId, for: indexPath) as! BalanceCollectionViewCell
        cell.coinBalance = user.balance[indexPath.row]
        return cell
    }
}

//MARK:- API
extension UserInfoCollectionViewController {
    func fetchUserData() {
        var name = UserDefaults.standard.getOmniId() ?? ""
        if (name.isEmpty) {
            name = "1FoWyxwPXuj4C6abqwhjDWdz6D4PZgYRjA"
        }
        OmniAPIHelper.shared.getchUsersData(address: name) { (us) in
            self.user = us
        }
    }
}

//MARK:- CollectionFlowLayoutDelegate
extension UserInfoCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 16) , height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width - 16, height: 80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailCoinControllerHeader.headerId, for: indexPath) as! UserInfoHeader
        header.userNameTitle.text = user.name + " balance:"
        return header
    }
}

