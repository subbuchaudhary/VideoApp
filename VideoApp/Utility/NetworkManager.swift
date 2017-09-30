//
//  NetworkManager.swift
//  VideoApp
//
//  Created by Subba Nelakudhiti on 9/29/17.
//  Copyright © 2017 Subba Nelakudhiti. All rights reserved.
//

import UIKit
import SystemConfiguration
import SwiftyJSON
//Network Call Response
enum Result<T> {
    case Success(T)
    case Failure(ErrorManager)
}
class NetworkManager: NSObject {
    let API_KEY = "AIzaSyBiCltG-0g6M8_xwP5JwPoAEHQFFVWNUgE"
    override init()
    {
        
    }
    //MARK: Check Neteork Connection
    func isNetworkAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    //MARK: Main Function Call by Whole Project for network call
    
    func callNetworkApi1(searchText: String!,completion:@escaping (Result<JSON>) -> Void)
    {
        if !isNetworkAvailable() {
            return completion(Result.Failure(ErrorManager.NoInternetAvaialble))
        }
        
        guard let searchQuery = searchText, !searchText.isEmpty else {
            return completion(Result.Failure(ErrorManager.NoBaseUrlAvailable))
        }
        
        var searchUrl = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=30&order=Relevance&q=\(searchQuery)&type=video&key=\(API_KEY)"
        searchUrl = searchUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
       // searchUrl = searchUrl.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        
        let url = URL(string: searchUrl )
        var request = URLRequest(url: url!)
        
        request.timeoutInterval = 10
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       // request.allHTTPHeaderFields = inputParameter![CTFSNetworkConstants.kHeader] as? [String:String];
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            
            guard error == nil else {
                return completion(Result.Failure(ErrorManager.HttpError(statusCode: error!._code)))
            }
            
            guard let data = data else {
                return completion( Result.Failure(ErrorManager.NoApiResponse))
            }
            
            let json = JSON(data: data)
            completion(Result.Success(json))
            }.resume()
    }
    
    
}
