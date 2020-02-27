//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 26/02/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import Foundation
enum GFError: String, Error{
    case invalidUsername = "This username created an invalid request. Please Try Again."
    case unableToComplete = "Unable to complete your request. Please chehck your internet connection"
    case invalidResponse = "Invalid response from the server. Please Try Again."
    case invalidData = "The data received from the server was invalid. Please Try Again."
}
