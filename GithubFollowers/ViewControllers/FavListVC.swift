//
//  FavListVC.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 01/02/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit

class FavListVC: GFDataLoadingViewController {
    
    let tableView = UITableView()
    var favorites: [Follower] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseID)
        
    }

    func getFavorites(){
        PersistanceManager.retrieveFavorites { [weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let fav):
                self.updateUI(with: fav)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                break
            }
        }
    }
    
    func updateUI(with fav: ([Follower])) {
        if fav.isEmpty{
            self.showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen", in: self.view)
        }else{
            self.favorites = fav
            DispatchQueue.main.async {
                self.tableView.reloadData()
                // if emptystate was called first then
                // bring tableview to front
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
}
 

 

extension FavListVC : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseID) as! TableViewCell
        
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowerListVC(username: favorite.login)
       
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else{return}
       
        PersistanceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else {return}
            
            guard let error = error else{
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }            
            self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
        }
    }
    
}
