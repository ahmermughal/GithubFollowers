//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 01/04/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import Foundation

class GFFollowerItemVC: GFItemInfoVC{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    
}
