import Foundation

struct Message {
    let id:String
    let client: String
    let date: String
    let dislikes: Int
    let ip: String
    let likes: Int
    let loc: [String]?
    let message: String
    
    init?(json: [String: Any]) {
        guard let idJSON = json["_id"] as? String,
            let clientJSON = json["client"] as? String,
            let dateJSON = json["date"] as? String,
            let dislikesJSON = json["dislikes"] as? Int,
            let ipJSON = json["ip"] as? String,
            let likesJSON = json["likes"] as? Int,
            
            let messageJSON = json["message"] as? String
            else {
                return nil
        }
        
        let coordinatesJSON = json["loc"] as? [String]
        
//        print(idJSON)
//        print(clientJSON)
//        print(dateJSON)
//        print(dislikesJSON)
//        
//        print(ipJSON)
//        print(likesJSON)
//        print(coordinatesJSON)
//        print(messageJSON)
        
        self.id = idJSON
        self.client = clientJSON
        self.date = dateJSON
        self.dislikes = dislikesJSON
        self.ip = ipJSON
        self.likes = likesJSON
        self.loc = coordinatesJSON
        self.message = messageJSON
    }
}


//"_id" = 5ac3ca134c17a831822f4dd1;
//client = "dkopec@champlain.edu";
//date = "Tue, 03 Apr 2018 18:38:11 GMT";
//dislikes = 0;
//ip = "216.93.146.138";
//likes = 1;
//loc =     (
//"<null>",
//"<null>"
//);
//message = hi;

