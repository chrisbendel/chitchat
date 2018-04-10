//
//  MessageCell.swift
//  chitchat
//
//  Created by Robin Diddams on 4/10/18.
//  Copyright © 2018 Chris Bendel. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var LikesLabel: UILabel!
    @IBOutlet weak var ClientLabel: UILabel!
    @IBOutlet weak var MessageLabel: UILabel!
//    var message: String = ""
//    var date: String = ""
//    var likes: Int = 0
//    var client: String = "robin"
//    var dislikes: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
