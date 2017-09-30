//
//  Videos.swift
//  VideoApp
//
//  Created by Subba Nelakudhiti on 9/29/17.
//  Copyright © 2017 Subba Nelakudhiti. All rights reserved.
//

import UIKit
import SwiftyJSON
class Videos: NSObject {
    
    var kind : String = ""
    var etag:String = ""
    var videoId:String = ""
    var videoTitle: String =  ""
    var videodes:String = ""
    var thumbnail:String = "'"
    var channelTitle:String = ""
    var date : String = ""
    
    init(jsonResponse:JSON) {
        
        super.init()

        self.kind = jsonResponse["kind"].stringValue
        self.etag = jsonResponse["etag"].stringValue
        self.videoId = jsonResponse["id"]["videoId"].stringValue
         self.etag = jsonResponse["etag"].stringValue
         self.videoTitle = jsonResponse["snippet"]["title"].stringValue
        self.videodes = jsonResponse["snippet"]["description"].stringValue
        self.channelTitle = jsonResponse["snippet"]["channelTitle"].stringValue
        self.thumbnail = jsonResponse["snippet"]["thumbnails"]["high"]["url"].stringValue
        self.date = jsonResponse["snippet"]["publishedAt"].stringValue
        
    }
}
