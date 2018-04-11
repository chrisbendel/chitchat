import UIKit

class ChatController: UIViewController {
    
    @IBOutlet weak var messageBox: UITextField!
    @IBOutlet weak var tableView: UIView!
    
    var mTable: MessageTable = MessageTable()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllMessages() { newMessages in
//            print(newMessages.count)
            DispatchQueue.main.async {
                self.mTable.messages = newMessages
                self.mTable.tableView.reloadData()
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func sendMessageButton(_ sender: Any) {
//        print("sending \(messageBox.text!)")
        if messageBox.text! == "" {
            //TODO notify user that theres nothing there
            return
        }
        sendMessage(message: messageBox.text!) { err in
            if err != nil {
//                print("error sending message I guess")
                return
            }
            getAllMessages() { newMessages in
//                print(newMessages.count)
                DispatchQueue.main.async {
                    self.mTable.messages = newMessages
                    self.mTable.tableView.reloadData()
                }
            }
        }
        messageBox.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("segue")
        if let t = segue.destination as? MessageTable {
            mTable = t
        }
    }
}

