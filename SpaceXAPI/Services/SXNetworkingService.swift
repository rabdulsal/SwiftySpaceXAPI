//
//  SXNetworkingService.swift
//  SpaceXAPI
//
//  Created by Rashad Abdul-Salam on 10/17/22.
//

import Foundation

enum SXNetworkingError : String, Error {
    case badURL
    case requestFail
    case badData
}

protocol SXNetworkingRequestable {
    var resourceURL: URL? { get set }
}

extension SXNetworkingRequestable {
    
    func makeRequest(completion: @escaping (_ data: Data?, _ error: String?)->Void) {
        guard let url = resourceURL else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let err = error {
                completion(nil,"ERROR: \(err.localizedDescription)")
                return
            }
            
            if let data = data, let resp = response as? HTTPURLResponse,
                        resp.statusCode == 200
                {
                     completion(data,nil)
                } else {
                    completion(nil,"ERROR: Couldn't unwrap Data or Response")
                }
        }).resume()
    }
    
    func makeAsyncRequest() async throws -> Result<Data,Error> {
        guard let url = resourceURL else {
            throw SXNetworkingError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
               throw SXNetworkingError.requestFail
            }
            
        return .success(data)
    }
}

class SXLaunchRequestService : SXNetworkingRequestable {
    
    var resourceURL = URL(string:"https://api.spacexdata.com/v3/launches")
    
    func getLaunchData(completion: @escaping (_ rocketJSON: [[String:Any]]?, _ error: String?)->Void) {
        self.makeRequest{ data, error in
            if let err = error {
                completion(nil,"ERROR: \(err)")
                return
            }
            
            do {
                if
                    let rocketData = data,
                    let json = try JSONSerialization.jsonObject(with: rocketData) as? [[String:Any]]
                {
                     completion(json,nil)
                } else {
                    completion(nil,"ERROR: Couldn't unwrap Data or Response")
                }
            } catch {
                completion(nil,"ERROR: \(error)")
            }
        }
    }
    
    func getLaunchData() async throws -> Result<Data,Error> {
        
        return try await self.makeAsyncRequest()
    }
}
