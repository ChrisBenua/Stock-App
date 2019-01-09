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
    
    var currLayout : UserProfileProvidedDataTypeEnum = .balance {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var user : UserInfo = UserInfo() {
        didSet {
            collectionView.reloadData()
            collectionView.refreshControl?.endRefreshing()
        }
    }
    
    var transaction : [Transaction] = [Transaction]() {
        didSet {
            collectionView.reloadData()
            collectionView.refreshControl?.endRefreshing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OmniAPIHelper.shared.delegate = self
        let refreshControl = UIRefreshControl()
        navigationItem.title = "Your Wallet"
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = true
        refreshControl.tintColor = .white
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(toggleRefresh), for: .valueChanged)
        collectionView.register(BalanceCollectionViewCell.self, forCellWithReuseIdentifier: BalanceCollectionViewCell.cellId)
        collectionView.register(UserInfoHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UserInfoHeader.headerId)
        collectionView.register(TransactionCollectionViewCell.self, forCellWithReuseIdentifier: TransactionCollectionViewCell.cellId1)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(toggleSettings))]
        fetchUserData(userId: nil)
    }
    
    @objc func toggleSettings() {
        let alertController = UIAlertController(title: "Omni ID", message: "Enter your omni Id", preferredStyle: .alert)
        
        alertController.addTextField { (tf) in
            tf.placeholder = "Omni ID"
            //1NTMakcgVwQpMdGxRQnFKyb3G1FAJysSfztf.cop
        }
        
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] (action) in
            print(alertController?.textFields?.first?.text)
            //UserDefaults.standard.saveOmniId(id: alertController?.textFields?.first?.text ?? Configuration.defaultUserId)
            self.fetchUserData(userId: alertController?.textFields?.first?.text)
            self.fetchUserTransaction(userId: alertController?.textFields?.first?.text)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func toggleRefresh() {
        fetchUserData(userId: UserDefaults.standard.getOmniId() ?? "")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch (currLayout) {
        case .balance:
            return user.balance.count
        case .transactions:
            return transaction.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch currLayout {
        case .balance:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BalanceCollectionViewCell.cellId, for: indexPath) as! BalanceCollectionViewCell
            cell.coinBalance = user.balance[indexPath.row]
            return cell
        case .transactions:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionCollectionViewCell.cellId1, for: indexPath) as! TransactionCollectionViewCell
            cell.username = user.name
            cell.transaction = self.transaction[indexPath.row]
            return cell
        }
        
    }
}

//MARK:- API
extension UserInfoCollectionViewController {
    
    func showAlertController(text : String) {
        let alertController = UIAlertController(title: "Error", message: text, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Get it!", style: .destructive)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func fetchUserData(userId : String?) {
        var name = userId ?? ""
        if (name.isEmpty) {
            name = UserDefaults.standard.getOmniId() ?? Configuration.defaultUserId
            if (name == Configuration.defaultUserId) {
                let alertController = UIAlertController(title: "Specify your wallet id", message: "Press settings button and enter your wallet id(Omni explorer id)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Get it!", style: .destructive)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        OmniAPIHelper.shared.fetchUsersWalletData(address: name) { (us) in
            self.user = us
            UserDefaults.standard.saveOmniId(id: us.name)
        }
    }
    
    func fetchUserTransaction(userId : String?) {
        var name = userId ?? ""
        if (name.isEmpty) {
            name = UserDefaults.standard.getOmniId() ?? Configuration.defaultUserId
        }
        
        OmniAPIHelper.shared.fetchUsersTransactions(address: name, page: 0) { (trans) in
            self.transaction = trans
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
        switch currLayout {
        case .balance:
            return CGSize(width: (view.frame.width - 16) , height: 80)
        case .transactions:
            return CGSize(width: (view.frame.width - 16) , height: 160)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width - 16, height: 150)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UserInfoHeader.headerId, for: indexPath) as! UserInfoHeader
        header.userNameTitle.text = user.name
        header.delegate = self
        return header
    }
}

extension UserInfoCollectionViewController : UserProfileProvidedDataTypeChanged {
    func handleDataTypeChanged(type: UserProfileProvidedDataTypeEnum) {
        currLayout = type
        if (type == .transactions && transaction.count == 0) {
            fetchUserTransaction(userId: nil)
        }
    }
    
    
}

extension UserInfoCollectionViewController : OmniApiHelperOperationsFailed {
    func showApiAlertController(text : String) {
        self.showAlertController(text : text)
    }
    
}

