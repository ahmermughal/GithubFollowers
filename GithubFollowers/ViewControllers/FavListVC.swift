//
//  FavListVC.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 01/02/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit

class FavListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        PersistanceManager.retrieveFavorites { (resut) in
            switch resut{
            case .success(let fav):
                print(fav)
            case .failure(let error):
               break
            }
        }
    }
}
