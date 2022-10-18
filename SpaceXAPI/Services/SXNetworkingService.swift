//
//  SXNetworkingService.swift
//  SpaceXAPI
//
//  Created by Rashad Abdul-Salam on 10/17/22.
//

import Foundation

class SXNetworkingService : NSObject {
    
    var baseURL = URL(string:"https://api.spacexdata.com/v3/launches")
    
    func getData(completion: @escaping (_ rocketJSON: [[String:Any]]?, _ error: String?)->Void) {
        guard let url = baseURL else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let err = error {
                print("ERROR: \(err.localizedDescription)")
                return
            }
            
            do {
                if
                    let rocketData = data,
                    let json = try JSONSerialization.jsonObject(with: rocketData) as? [[String:Any]],
                    let resp = response as? HTTPURLResponse,
                        resp.statusCode == 200
                {
                     completion(json,nil)
                } else {
                    print("ERROR: Couldn't unwrap Data or Response")
                }
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }).resume()
    }
}
