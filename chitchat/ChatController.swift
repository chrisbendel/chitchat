import UIKit

class ChatController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var MessageTable: UITableView!
    
    var messages: [Message] = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllMessages() { newMessages in
            print(self.messages.count)
            print("hello")
            self.messages = newMessages
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        let m = messages[indexPath.row]
        cell.ClientLabel.text = m.client
        cell.LikesLabel.text = String(m.likes)
        cell.MessageLabel.text = m.message
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell selected code here
    }

    @IBAction func sendMessage(_ sender: Any) {
        getAllMessages() { newMessages in
            print(self.messages.count)
            print("hello")
            self.messages = newMessages
        }
    }
}

