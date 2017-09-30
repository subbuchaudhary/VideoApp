//
//  HomeViewModel.swift
//  VideoApp
//
//  Created by Subba Nelakudhiti on 9/29/17.
//  Copyright © 2017 Subba Nelakudhiti. All rights reserved.
//

import UIKit
import SwiftyJSON
protocol HomeViewModelDelegate{
    func videoFetchSuccess(isSuccess:Bool)
}
class HomeViewModel: NSObject {
    /*LoginViewModelDelegats*/
    var delegate:HomeViewModelDelegate?
    var videoList = [Videos]()

    override init() {
        super.init()
    }
    
    func fetchYoutubeVideo(searchQuery:String?)
    {
        let manager = NetworkManager()
        manager.callNetworkApi1(searchText: searchQuery) { (result) in
            switch result
            {
            case .Failure(let error):
                print(error.descrption)
                self.delegate?.videoFetchSuccess(isSuccess: false)
                
            case .Success(let response):
                self.handleApiResponse(resultJson: response)
                if self.videoList.count==0{
                self.delegate?.videoFetchSuccess(isSuccess: false)
                }
                else
                {
                     self.delegate?.videoFetchSuccess(isSuccess: true)
                }
            }
        }
    }
    
    //MARK : Handle Json Response
    func handleApiResponse(resultJson:JSON)
    {

        let json  = resultJson["items"]
        switch json.type
        {
        case .array:
            if json.count == 0{
                return }
            
            for dictQuestion in json.array!
            {
                let video = Videos(jsonResponse: dictQuestion)
                print(video.videoId)
                print(video.etag)
                self.videoList.append(video)
            }
            return
            
        default:
            print("other")
        }
        return
    }
    
    //MARK: CollectionView Delegates
    
    func numberOfRowInSection() -> Int
    {
        return self.videoList.count
    }
    
    func cellForItemAtIndexPath(cell:VideoCollectionCell,indexPath:IndexPath) -> VideoCollectionCell
    {
        let video  = self.videoList[indexPath.row]
        cell.title.text = self.dateFormat(dateString: video.date)
        cell.coverImage.downloadVideoCoverImage(urlString: video.thumbnail)
        return cell
    }
    
    
    func dateFormat(dateString:String)-> String
    {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let myDate = dateFormatter.date(from: dateString)!
        
        dateFormatter.dateFormat = "MMM dd, YYYY"
        let dateStringNew = dateFormatter.string(from: myDate)
        
        return dateStringNew
    }
}
