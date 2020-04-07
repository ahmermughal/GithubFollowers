//
//  GFAlertContaninerView.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 06/04/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit

class GFAlertContaninerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }    
}
