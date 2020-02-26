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
    
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void){
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else{
            // if we have a bad url then we return the error
            completed(nil, "This username created an invalid request. Please Try Again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // if error is not null
            if let _ = error{
                completed(nil, "Unable to complete your request. Please chehck your internet connection")
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(nil,"Invalid response from the server. Please Try Again.")
                return
            }
            
            guard let data = data else {
                completed(nil, "The data received from the server was invalid. Please Try Again.")
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            }catch{
                completed(nil, "The data received from the server was invalid. Please Try Again.")
            }
        }
        
        // task.resume() starts the network call IMPORTANT TO ADD
        task.resume()
        
    }
    
}
