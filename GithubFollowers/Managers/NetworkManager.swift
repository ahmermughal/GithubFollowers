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
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        // task.resume() starts the network call IMPORTANT TO ADD
        task.resume()
        
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void){
        // making urlString into NSString
        let cacheKey = NSString(string: urlString)
        // checking to see if cached image exsists.
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else{
            completed(nil)
            return
        }
        // making the network call
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // handling all the errors
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data)
            else {
                completed(nil)
                return
            }
            
            // caching the downloaded image
            self.cache.setObject(image, forKey: cacheKey)
            // setting the image on the main thread
            completed(image)
        }
        task.resume()
    }
}


