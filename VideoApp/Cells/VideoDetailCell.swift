//
//  VideoDetailCell.swift
//  VideoApp
//
//  Created by Subba Nelakudhiti on 9/29/17.
//  Copyright © 2017 Subba Nelakudhiti. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
class VideoDetailCell: UITableViewCell {
    @IBOutlet weak var player:YTPlayerView!
    @IBOutlet weak var title:UILabel!
    @IBOutlet weak var detail:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
