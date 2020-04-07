//
//  GFTitleLabel.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 06/02/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit

class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // using convenicne we dnt have to call configure here
    // see video optimization 2 to understand more if forgot
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private func configure(){
        textColor = .label // black color on white screen & white on black screen
        adjustsFontSizeToFitWidth = true // if text becomes to big then resize it
        minimumScaleFactor = 0.90 // resize 90%
        lineBreakMode = .byTruncatingTail // if size too big then shows ... at the end
        translatesAutoresizingMaskIntoConstraints = false
    }    
}
