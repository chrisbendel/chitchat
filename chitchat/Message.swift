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
        
        //Parse the date into a date object
        //Call relative time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss zzz" //Your date format
        let date = dateFormatter.date(from: dateJSON) //according to date format your date string
        
        let coordinatesJSON = json["loc"] as? [String]
        let url = detectUrl(s: messageJSON)
        
        self.id = idJSON
        self.client = clientJSON.components(separatedBy: "@")[0]
        self.date = (date?.relativeTime)!
        self.dislikes = dislikesJSON
        self.ip = ipJSON
        self.likes = likesJSON
        self.loc = coordinatesJSON
        self.message = removeUrl(s: messageJSON, u: url)
        self.imageUrl = url
    }
}

func removeUrl(s: String, u: String) -> String {
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

//Stolen from https://stackoverflow.com/a/27337951
extension Date {
    var yearsFromNow:   Int { return Calendar.current.dateComponents([.year],       from: self, to: Date()).year        ?? 0 }
    var monthsFromNow:  Int { return Calendar.current.dateComponents([.month],      from: self, to: Date()).month       ?? 0 }
    var weeksFromNow:   Int { return Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear  ?? 0 }
    var daysFromNow:    Int { return Calendar.current.dateComponents([.day],        from: self, to: Date()).day         ?? 0 }
    var hoursFromNow:   Int { return Calendar.current.dateComponents([.hour],       from: self, to: Date()).hour        ?? 0 }
    var minutesFromNow: Int { return Calendar.current.dateComponents([.minute],     from: self, to: Date()).minute      ?? 0 }
    var secondsFromNow: Int { return Calendar.current.dateComponents([.second],     from: self, to: Date()).second      ?? 0 }
    var relativeTime: String {
        if yearsFromNow   > 0 { return "\(yearsFromNow) year"    + (yearsFromNow    > 1 ? "s" : "") + " ago" }
        if monthsFromNow  > 0 { return "\(monthsFromNow) month"  + (monthsFromNow   > 1 ? "s" : "") + " ago" }
        if weeksFromNow   > 0 { return "\(weeksFromNow) week"    + (weeksFromNow    > 1 ? "s" : "") + " ago" }
        if daysFromNow    > 0 { return daysFromNow == 1 ? "Yesterday" : "\(daysFromNow) days ago" }
        if hoursFromNow   > 0 { return "\(hoursFromNow) hour"     + (hoursFromNow   > 1 ? "s" : "") + " ago" }
        if minutesFromNow > 0 { return "\(minutesFromNow) minute" + (minutesFromNow > 1 ? "s" : "") + " ago" }
        if secondsFromNow > 0 { return secondsFromNow < 15 ? "Just now"
            : "\(secondsFromNow) second" + (secondsFromNow > 1 ? "s" : "") + " ago" }
        return ""
    }
}
