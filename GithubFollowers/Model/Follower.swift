//
//  Follower.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 25/02/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import Foundation

struct Follower: Codable{
    // make login optional if there is a chance that it will be null
    // in this case it will not be null
    var login: String
    var avatarUrl: String
}
