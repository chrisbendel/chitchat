//
//  MessageCell.swift
//  chitchat
//
//  Created by Robin Diddams on 4/10/18.
//  Copyright © 2018 Chris Bendel. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var LikesLabel: UIButton!
    @IBOutlet weak var DisikesLabel: UIButton!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var ClientLabel: UILabel!
    @IBOutlet weak var MessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
