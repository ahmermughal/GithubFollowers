//
//  UiHelper.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 05/03/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit

struct UiHelper {
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout{
        let width = view.bounds.width // width of the device
        let padding: CGFloat = 12 // padding of the layout
        let minimumItemSpacing: CGFloat = 10 // space between two items
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2) // total width of device - (padding x 2) - (itemspace x 2) to get the remaining space left for items
        let itemWidth = availableWidth / 3 // available width is divided by 3 becuase of 3 columns which gives width of 1 item
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40 )
        
        return flowLayout
    }
}
