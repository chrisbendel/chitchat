//
//  MessageCell.swift
//  chitchat
//
//  Created by Robin Diddams on 4/10/18.
//  Copyright © 2018 Chris Bendel. All rights reserved.
//

import UIKit
import SwipeCellKit
import MapKit

class MessageCell: SwipeTableViewCell {
    
    var id: String!
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var ClientLabel: UILabel!
    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var DislikesLabel: UILabel!
    @IBOutlet weak var LikesLabel: UILabel!
    @IBOutlet weak var MessageImage: UIImageView!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
}
