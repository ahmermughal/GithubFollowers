//
//  PersistenceManager.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 04/04/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import Foundation

enum PresistenceActionType{
    case add, remove
}

enum PersistanceManager{
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static  let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PresistenceActionType, completed: @escaping (GFError?) -> Void){
        retrieveFavorites { result in
            switch result{
            case .success(let favorites):
                var retrivedFavorties = favorites
                switch actionType {
                case .add:
                    // check to see if it doenst contain our favorite already
                    guard !retrivedFavorties.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    retrivedFavorties.append(favorite)
                    break
                case .remove:
                    retrivedFavorties.removeAll { $0.login == favorite.login}
                    break
                }
                completed(save(favorites: retrivedFavorties))
                
            case .failure(let error):
                completed(error)
                break
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void){
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        }catch{
            completed(.failure(.unableToFav))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError?{
        do{
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        }catch{
            return .unableToFav
        }
    }
}