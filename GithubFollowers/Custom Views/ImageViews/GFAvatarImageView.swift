//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 02/03/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let cache =  NetworkManager.shared.cache
    let placeholderImage = UIImage(named: "avatar-placeholder")!
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
 
    func downloadImage(from urlString: String){
        // making urlString into NSString
        let cacheKey = NSString(string: urlString)
        // checking to see if cached image exsists.
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else{ return }
        // making the network call
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // handling all the errors
            guard let self = self else { return }
            if error != nil {return}
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else {return}
            guard let image = UIImage(data: data) else { return }
            // caching the downloaded image
            self.cache.setObject(image, forKey: cacheKey)
            // setting the image on the main thread
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}


