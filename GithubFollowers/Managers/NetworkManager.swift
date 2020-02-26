//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 25/02/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import Foundation

class NetworkManager{
    
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    
    private init(){}
    
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, ErrorMessage?) -> Void){
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else{
            // if we have a bad url then we return the error
            completed(nil, ErrorMessage.invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // if error is not null
            if let _ = error{
                completed(nil, .unableToComplete)
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completed(nil, .invalidData)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            }catch{
                completed(nil, .invalidData)
            }
        }
        
        // task.resume() starts the network call IMPORTANT TO ADD
        task.resume()
        
    }
    
}
