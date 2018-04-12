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
            let dislikeAction = SwipeAction(style: .destructive, title: "Dislike") { action, indexPath in
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
//            deleteAction.image = UIImage(named: "delete")
            return [dislikeAction]
        } else {
            let likeAction = SwipeAction(style: .default, title: "Like") { action, indexPath in
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
//            likeAction.image = UIImage(named: "delete")
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
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!) {
                    DispatchQueue.main.async {
                        cell.MessageImage.image = UIImage(data: data)
                    }
                } else {
                    print("bad image")
                }
            }
            
        } else {
            cell.MessageImage.image = nil
        }
    
        cell.id = m.id
        cell.delegate = self
        return cell
    }
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // cell selected code here
//    }
}
