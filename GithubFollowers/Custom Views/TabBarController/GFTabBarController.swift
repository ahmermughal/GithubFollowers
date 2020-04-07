//
//  GFTabBarController.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 05/04/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        self.viewControllers = [createSearchNC(), createFavNC()]
    }
    
    func createSearchNC() ->  UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavNC() -> UINavigationController {
        let favListVC = FavListVC()
        favListVC.title = "Favorites"
        favListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favListVC)
    }    

}
