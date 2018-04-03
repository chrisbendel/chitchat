import Foundation

let apikey = "3f9c1d3b-50c8-4bae-8f9e-98e41f0baf14";
let base = "https://www.stepoutnyc.com/chitchat";

//https://stackoverflow.com/a/27724627
func sendRequest(_ url: String, parameters: [String: String], completion: @escaping ([String: Any]?, Error?) -> Void) {
    var components = URLComponents(string: base + url)!
    
    var newParams = parameters
    newParams["key"] = apikey
    newParams["client"] = "christopher.bendel@mymail.champlain.edu"
    
    components.queryItems = newParams.map { (key, value) in
        URLQueryItem(name: key, value: value)
    }
    
    components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
    let request = URLRequest(url: components.url!)
    print(components.url!)

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data,                            // is there data
            let response = response as? HTTPURLResponse,  // is there HTTP response
            (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
            error == nil else {                           // was there no error, otherwise ...
                completion(nil, error)
                return
        }
        
        let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
        completion(responseObject, nil)
    }
    task.resume()
}
