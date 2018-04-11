import UIKit

class ChatController: UIViewController {
    
    @IBOutlet weak var message: UITextField!
//    @IBOutlet weak var mTable: MessageTable!
    @IBOutlet weak var tableView: UIView!
    
    var mTable: MessageTable = MessageTable()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let t = tableView as? MessageTable {
            print("hi")
        }
        for v in tableView.subviews {
            if let table = v as? MessageTable {
                print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>it happenned")
            }
        }
        getAllMessages() { newMessages in
            print(newMessages.count)
            print("loaded")
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


    @IBAction func sendMessage(_ sender: Any) {
        getAllMessages() { newMessages in
            print(newMessages.count)
            print("hello")
            DispatchQueue.main.async {
                print("async")
//                self.mTable.messages = newMessages
//                self.mTable.reloadData()
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue")
        if let t = segue.destination as? MessageTable {
            print("huh")
            mTable = t
        }
    }
}

