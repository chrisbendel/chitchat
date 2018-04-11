//
//  MessageCell.swift
//  chitchat
//
//  Created by Robin Diddams on 4/10/18.
//  Copyright © 2018 Chris Bendel. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    var id: String!
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var ClientLabel: UILabel!
    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var LikesButton: LikeButton!
    @IBOutlet weak var DislikesButton: LikeButton!
    @IBOutlet weak var DislikesLabel: UILabel!
    @IBOutlet weak var LikesLabel: UILabel!
    @IBOutlet weak var MessageImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func DislikeButtonPressed(_ sender: LikeButton) {
        
        dislikeMessage(id: id) {error in
            print("yeah")
            //TODO upadte
        }
    }
    
    @IBAction func LikeButtonPressed(_ sender: LikeButton) {
        print("hi")
        likeMessage(id: id) {error in
            print("yeah")
            //TODO upadte
        }
    }
}
