//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Ahmer Mughal on 01/02/2020.
//  Copyright © 2020 iDevelopStudio. All rights reserved.
//

import UIKit

protocol FollowerListVCDelegate: class {
    func didReuqestFollowers(for username: String)
}

class FollowerListVC: UIViewController {
    
    enum Section{
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    
    // isSearching variable is to know which arrey to get the user from. Filtered or normal
    var isSearching = false
    
    var collectionView : UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureSearchConroller()
        configureViewController()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonTapped(){
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
            guard let self = self else{return}
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistanceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard let error = error else{
                        self.presentGFAlertOnMainThread(title: "Success", message: "You have successfully favorited this user", buttonTitle: "Ok")
                        return
                    }
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                    
                }
            case.failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
    }
    
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UiHelper.createThreeColumnFlowLayout(in: view))
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func configureSearchConroller(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        // removes the slight tint when searchbar is active
        searchController.obscuresBackgroundDuringPresentation = false
        // adds the searchbar in the navigationbar
        navigationItem.searchController = searchController
    }
    
    
    func getFollowers(username: String, page: Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) {[weak self] result in
            guard let self = self else{ return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty{
                    let message = "This user doesnt have any followers. 😁"
                    DispatchQueue.main.async {                     self.showEmptyStateView(with: message, in: self.view)
                    }
                    
                }
                
                self.updateData(on: self.followers)
                
            case.failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Request", message: error.rawValue , buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // checks to see if at the bottom of the list
        if offsetY > contentHeight - height{
            guard hasMoreFollowers else {
                return
            }
            page += 1
            //print(page)
            getFollowers(username: username, page: page )
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        let destVC = UserInfoVC()
        destVC.delegate = self
        
        destVC.username = follower.login
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
        
    }
    
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        // check is text is nil or is empty string and returns otherwise
        // adds the string to filter variable
        guard let filter = searchController.searchBar.text, !filter.isEmpty else{return}
        isSearching = true
        // checks login contains the filered word for each follower
        filteredFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
        
    }
}

extension FollowerListVC : FollowerListVCDelegate{
    func didReuqestFollowers(for username: String) {
        // get followers for that user
        self.username = username
        // title of Navbar
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        // scroll to top
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
    
    
}
