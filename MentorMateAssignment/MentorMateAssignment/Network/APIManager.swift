//
//  APIManager.swift
//  MentorMateAssignment
//
//  Created by Zain Ali on 5/21/22.
//

import Foundation

class APIManager
{
    let headers = ["Accept": "application/json",
                   "Authorization" : APIKEY]
    
    static let shared = APIManager()
    
    func getNearByPlaces(latitude: String, longitude: String, completion: @escaping ([LocationModel]) -> Void)
    {
        let request = NSMutableURLRequest(url: URL(string: BASEURL + nearbyAPI + "ll=\(latitude),\(longitude)&limit=5")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        print(request)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if error != nil
            {
                print(error)
            }
            else
            {   
                let jsonString = String(data: data!, encoding: .utf8)
                let jsonData = jsonString?.data(using: .utf8)
                let decoder = JSONDecoder()

                do {
                    let locations = try decoder.decode(RootModel.self, from: jsonData!)
                    completion(locations.results)
                } catch {
                    print(error.localizedDescription)
                }
            }
        })
        dataTask.resume()
    }
}
