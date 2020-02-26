//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 01/02/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { (followers, errorMessage) in
            
            guard let followers = followers else{
                self.presentGFAlertOnMainThread(title: "Bad Request", message: errorMessage!, buttonTitle: "Ok")
                return
            }
            
            print("Followers.count = \(followers.count)")
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
}
