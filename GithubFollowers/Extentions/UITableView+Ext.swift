//
//  UITableView+Ext.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 07/04/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit

extension UITableView{
    
    func reloadDataOnMainTheard(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells(){
        tableFooterView = UIView(frame: .zero)
    }
}
