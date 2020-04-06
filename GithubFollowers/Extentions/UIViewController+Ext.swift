//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 15/02/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit
import SafariServices
// fileprivate is private to this particule file

extension UIViewController{
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVCViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
        
    func presentSafariVC(with url: URL){
               let safariVC = SFSafariViewController(url: url)
               safariVC.preferredControlTintColor = .systemGreen
               present(safariVC, animated: true)
    }
}
