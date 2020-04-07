//
//  UIView+Ext.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 06/04/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit

extension UIView{    
    // ... makes so any number of views can be passed it
    func addSubviews(_ views: UIView...){
        for view in views {
            addSubview(view)
        }
    }
}
