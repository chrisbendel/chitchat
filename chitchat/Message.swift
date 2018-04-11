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
    let imageUrl: String
    
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
        let url = detectUrl(s: messageJSON)
        
        self.id = idJSON
        self.client = clientJSON.components(separatedBy: "@")[0]
        self.date = dateJSON
        self.dislikes = dislikesJSON
        self.ip = ipJSON
        self.likes = likesJSON
        self.loc = coordinatesJSON
        self.message = removeUrl(s: messageJSON, u: url)
        self.imageUrl = url
    }
}

func removeUrl(s: String, u: String) -> String {
    print(s)
    print(u)
    if (u == "") {
        return s
    }
    
    return s.replacingOccurrences(of: u, with: "")
}

func detectUrl(s: String) -> String {
    let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
    let matches = detector.matches(in: s, options: [], range: NSRange(location: 0, length: s.utf16.count))
    
    for match in matches {
        if let url = match.url {
            let sUrl = url.absoluteString
            let validUrl = sUrl.components(separatedBy: "http")[1]
            return "http\(validUrl)"
        }
    }
    
    return ""
}
