//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 04/04/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import Foundation

extension Date{
        
    // converts date to formatted string
    func convertToMonthYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
