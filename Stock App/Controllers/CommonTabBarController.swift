//
//  CommonTabBarController.swift
//  Stock App
//
//  Created by Ирина Улитина on 25/11/2018.
//  Copyright © 2018 Christian Benua. All rights reserved.
//

import UIKit

class CommonTabBarController: UITabBarController, UITabBarControllerDelegate {
    ///Separator view between tabbar and other views
    let separatorView : UIView = {
        let v = UIView()
        
        v.backgroundColor = .white
        v.alpha = 0.2
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        //navigationController?.navigationBar.isTranslucent = false
        setUpViewControllers()
        
        tabBar.addSubview(separatorView)
        separatorView.anchor(top: tabBar.topAnchor, left: tabBar.leftAnchor, bottom: nil, right: tabBar.rightAnchor, paddingTop: 0, paddingLeft: 1, paddingBottom: 0, paddingRight: 1, width: 0, height: 1)
        
        guard let items = tabBar.items else {return}
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
        // Do any additional setup after loading the view.
    }
    ///Setting up all nested controllers
    func setUpViewControllers() {
        let newsNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "newsUnselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "newsSelected").withRenderingMode(.alwaysOriginal), rootViewController: NewsCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        let currenciesNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "btcUnselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "btcSelected").withRenderingMode(.alwaysOriginal), rootViewController: MainCurrenciesController())
        
        let coinSearchController = templateNavController(unselectedImage: #imageLiteral(resourceName: "searchImageUnselected").withRenderingMode(.alwaysOriginal),
                                                         selectedImage: #imageLiteral(resourceName: "searchImageSelected").withRenderingMode(.alwaysOriginal), rootViewController: CoinSearchCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        let userInfoController = templateNavController(unselectedImage: #imageLiteral(resourceName: "account").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "account").withRenderingMode(.alwaysOriginal), rootViewController: UserInfoCollectionViewController(collectionViewLayout : UICollectionViewFlowLayout()))
        //view.backgroundColor = .black
        //tabBar.isTranslucent = false
        self.moreNavigationController.navigationBar.tintColor = .black
        viewControllers = [newsNavController, currenciesNavController, coinSearchController, userInfoController]
    }

    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if (tabBarController.selectedIndex == 0 || tabBarController.selectedIndex == 2) {
            var vc = ((viewControllers![tabBarController.selectedIndex] as! UINavigationController).viewControllers.first!)
            if vc is NewsCollectionViewController {
                (vc as! NewsCollectionViewController).searchController.isActive = false
            } else if (vc is CoinSearchCollectionViewController) {
                (vc as! CoinSearchCollectionViewController).searchController.isActive = false
            }
        }
        return true
    }
    
    /**
     Generates and returns NavController with following parameters
     - Parameter unselectedImage: this picture is set, when following navController isn't selected
     - Parameter selectedImage: this picture is set, when following navController is selected
     - Parameter rootViewController: controller to nest in NavController
     
    */
    fileprivate func templateNavController(unselectedImage : UIImage, selectedImage : UIImage?, rootViewController : UIViewController = UIViewController()) -> UINavigationController {
        let Controller = rootViewController
        let NavController = CustomNavigationController(rootViewController: Controller)
        NavController.tabBarItem.image = unselectedImage
        NavController.tabBarItem.selectedImage = selectedImage
        return NavController
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
