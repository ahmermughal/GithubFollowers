//
//  UIView+Ext.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 06/04/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit

extension UIView{
    
    func pinToEdges(of superview: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        topAnchor.constraint(equalTo: superview.topAnchor),
        leadingAnchor.constraint(equalTo: superview.leadingAnchor),
        trailingAnchor.constraint(equalTo: superview.trailingAnchor),
        bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    // ... makes so any number of views can be passed it
    func addSubviews(_ views: UIView...){
        for view in views {
            addSubview(view)
        }
    }
}
