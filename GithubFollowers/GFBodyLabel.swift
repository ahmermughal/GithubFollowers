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
    
    init(textAlignment: NSTextAlignment) { // no font size cuz use dynamic type (resizes according to system font size)
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    private func configure(){
        textColor = .secondaryLabel // (secondary) black color on white screen & white on black screen
        
        font = UIFont.preferredFont(forTextStyle: .body) // we get dynamic type font
        
        adjustsFontSizeToFitWidth = true // if text becomes to big then resize it
        minimumScaleFactor = 0.75 // resize 90%
        lineBreakMode = .byWordWrapping // if size too big then word wrap
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
