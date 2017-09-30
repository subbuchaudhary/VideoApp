//
//  VideoDetailController.swift
//  VideoApp
//
//  Created by Subba Nelakudhiti on 9/29/17.
//  Copyright © 2017 Subba Nelakudhiti. All rights reserved.
//

import UIKit

class VideoDetailController: UIViewController {
    var selectedVideo:Videos!
    @IBOutlet weak var tblVideo:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVideo.estimatedRowHeight = 300
        self.tblVideo.rowHeight = UITableViewAutomaticDimension

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension VideoDetailController:UITableViewDelegate,UITableViewDataSource
{
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoDetailCell", for: indexPath) as! VideoDetailCell
        cell.player.load(withVideoId: selectedVideo.videoId)
        cell.title.text = selectedVideo.videoTitle
        cell.detail.text = selectedVideo.videodes
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}



