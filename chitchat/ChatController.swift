import UIKit
import CoreLocation

class ChatController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var messageBox: UITextField!
    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    // stolen from https://developer.apple.com/documentation/corelocation/choosing_the_authorization_level_for_location_services/requesting_always_authorization
    let locationManager = CLLocationManager()
    
    func enableLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
//            disableMyLocationBasedFeatures()
            break
            
        case .authorizedWhenInUse:
            // Enable basic location features
//            enableMyWhenInUseFeatures()
            break
            
        case .authorizedAlways:
            // Enable any of your app's location features
//            enableMyAlwaysFeatures()
            print("hey!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            break
        }
    }

    
    var mTable: MessageTable = MessageTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateMessages()
        enableLocationServices()
    }

    @IBAction func userTyped(_ sender: UITextField) {
        if (sender.text != "") {
            sendButton.isEnabled = true
        } else {
            sendButton.isEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func refreshChat(_ sender: UIButton) {
        self.updateMessages()
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.mTable.messages.count - 1, section: 0)
            self.mTable.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func updateMessages() {
        getAllMessages() { newMessages in
            DispatchQueue.main.async {
                self.mTable.messages = newMessages
                self.mTable.tableView.reloadData()
                self.scrollToBottom()
            }
        }
    }
    
    @IBAction func sendMessageButton(_ sender: Any) {
        sendMessage(message: messageBox.text!) { err in
            if err != nil {
                //print("error sending message I guess")
                return
            }
            self.updateMessages()
        }
        messageBox.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let t = segue.destination as? MessageTable {
            mTable = t
        }
    }
}

