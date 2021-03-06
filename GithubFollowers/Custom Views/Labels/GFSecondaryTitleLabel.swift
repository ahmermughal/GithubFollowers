//
//  GFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 28/03/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

   override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // using convenicne we dnt have to call configure here
    // see video optimization 2 to understand more if forgot
    convenience init(fontSize: CGFloat) { // no font size cuz use dynamic type (resizes according to system font size)
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    private func configure(){
        textColor = .secondaryLabel // (secondary) black color on white screen & white on black screen
        
        adjustsFontSizeToFitWidth = true // if text becomes to big then resize it
        minimumScaleFactor = 0.90 // resize 90%
        lineBreakMode = .byTruncatingTail // if size too big then word wrap
        translatesAutoresizingMaskIntoConstraints = false
    }

}
