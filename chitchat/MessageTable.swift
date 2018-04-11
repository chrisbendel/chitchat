//
//  MessageTable.swift
//  chitchat
//
//  Created by Robin Diddams on 4/10/18.
//  Copyright © 2018 Chris Bendel. All rights reserved.
//

import UIKit

class MessageTable: UITableViewController {
    
    var messages: [Message] = [Message]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "message", for: indexPath) as! MessageCell
        let m = messages[indexPath.row]
        print("\(m.message), \(m.likes)")
        cell.ClientLabel.text = m.client
        cell.LikesLabel.text = "(\(String(m.likes)))"
        cell.DislikesLabel.text = "(\(String(m.dislikes)))"
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
        return cell
    }
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // cell selected code here
//    }
}
