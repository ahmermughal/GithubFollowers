//
//  GFBodyLabel.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 15/02/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // using convenicne we dnt have to call configure here
    // see video optimization 2 to understand more if forgot
    convenience init(textAlignment: NSTextAlignment) { // no font size cuz use dynamic type (resizes according to system font size)
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    private func configure(){
        textColor = .secondaryLabel // (secondary) black color on white screen & white on black screen
        
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true// we get dynamic type font
        
        adjustsFontSizeToFitWidth = true // if text becomes to big then resize it
        minimumScaleFactor = 0.75 // resize 90%
        lineBreakMode = .byWordWrapping // if size too big then word wrap
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
