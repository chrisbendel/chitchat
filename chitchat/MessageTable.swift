//
//  MessageTable.swift
//  chitchat
//
//  Created by Robin Diddams on 4/10/18.
//  Copyright © 2018 Chris Bendel. All rights reserved.
//

import UIKit
import SwipeCellKit
import Kingfisher

class MessageTable: UITableViewController, SwipeTableViewCellDelegate {
    var messages: [Message] = [Message]()
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let m = messages[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! MessageCell
        if orientation == .right {
            //dislike
            let dislikeAction = SwipeAction(style: .destructive, title: "👎") { action, indexPath in
                dislikeMessage(id: m.id) {error in
                    if error == "disliked" {
                        cell.hideSwipe(animated: true)
                        return
                    }
                    getAllMessages() { newMessages in
                        DispatchQueue.main.async {
                            self.messages = newMessages
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            return [dislikeAction]
        } else {
            let likeAction = SwipeAction(style: .default, title: "👍") { action, indexPath in
                likeMessage(id: m.id) {error in
                    if error == "liked" {
                        cell.hideSwipe(animated: true)
                        return
                    }
                    getAllMessages() { newMessages in
                        DispatchQueue.main.async {
                            self.messages = newMessages
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            return [likeAction]
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "message", for: indexPath) as! MessageCell
        
        let m = messages[indexPath.row]
        cell.ClientLabel.text = m.client
        cell.LikesLabel.text = String(m.likes)
        cell.DislikesLabel.text = String(m.dislikes)
        cell.DateLabel.text = m.date
        cell.MessageLabel.text = m.message
        if (m.imageUrl != "") {
            let url = URL(string: m.imageUrl)
            cell.MessageImage.kf.setImage(with: url)
        } else {
            cell.MessageImage.image = nil
        }
    
        cell.id = m.id
        cell.delegate = self
        return cell
    }
}
