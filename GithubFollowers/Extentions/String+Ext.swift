//
//  String+Ext.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 04/04/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import Foundation

extension String {
    // UPDATE
    // Not needed after changing model to Date and adding decoding
    // date Statergy
    
    // converts String recieved from server to date object
    func convertToDate() ->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    // converts string to date to manupilate then back to formatted string
    func convertToDisplayFormat() -> String{
        guard let date = self.convertToDate() else { return "N/A"}
        return date.convertToMonthYear()
    }
    
}
