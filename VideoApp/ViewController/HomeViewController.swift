//
//  HomeViewController.swift
//  VideoApp
//
//  Created by Subba Nelakudhiti on 9/29/17.
//  Copyright © 2017 Subba Nelakudhiti. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var userDetail:SignInViewModel!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchActive : Bool = false
    var homeViewModel = HomeViewModel()
    
    @IBOutlet weak var videoCollection:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Videos"
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController:HomeViewModelDelegate
{
    func videoFetchSuccess(isSuccess: Bool) {
        
        if isSuccess
        {
            DispatchQueue.main.async {
                self.videoCollection.isHidden = false
                self.videoCollection.reloadData()
                
            }
        }
        else
        {
            DispatchQueue.main.async {
                //self.videoCollection.isHidden = true
            }
            print("Hide collectionview")
        }
    }
}

extension HomeViewController:UICollectionViewDataSource,UICollectionViewDelegate
{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.homeViewModel.numberOfRowInSection()
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCollectionCell
        cell = self.homeViewModel.cellForItemAtIndexPath(cell: cell, indexPath: indexPath)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : VideoDetailController = storyboard.instantiateViewController(withIdentifier: "VideoDetailController") as! VideoDetailController
        vc.selectedVideo = self.homeViewModel.videoList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    @objc func showProfile()
    {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : ProfileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.userProfile = self.userDetail.userDetail
        self.navigationController?.pushViewController(vc, animated: true)
        //ProfileViewController
    }
   

}

extension HomeViewController:UISearchBarDelegate
{

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        homeViewModel = HomeViewModel()
        homeViewModel.delegate = self
        homeViewModel.fetchYoutubeVideo(searchQuery: searchText)
    }

}
