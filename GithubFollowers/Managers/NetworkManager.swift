//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 25/02/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit

class NetworkManager{
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    private init(){}
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void){
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else{
            // if we have a bad url then we return the error
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // if error is not null
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        // task.resume() starts the network call IMPORTANT TO ADD
        task.resume()
        
    }
    
    func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void){
        let endpoint = baseURL + "\(username)"
        
        guard let url = URL(string: endpoint) else{
            // if we have a bad url then we return the error
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // if error is not null
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        // task.resume() starts the network call IMPORTANT TO ADD
        task.resume()
        
    }
    
}
