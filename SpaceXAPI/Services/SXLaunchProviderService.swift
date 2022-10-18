//
//  SXLaunchProviderService.swift
//  SpaceXAPI
//
//  Created by Rashad Abdul-Salam on 10/18/22.
//

import Foundation

protocol SXLaunchProvidable {
    func fetchedLaunchData(_ launchData: [SXLaunchData])
}

class SXLaunchProviderService : SXNetworkingRequestable {
    
    var resourceURL = URL(string:"https://api.spacexdata.com/v3/launches")
//    var allLaunches = [SXLaunchData]()
    var launchProviderDelegate: SXLaunchProvidable?
    
    func getLaunchData(completion: @escaping (_ launches: [SXLaunchData], _ error: String?)->Void) {
        self.makeRequest { launchData, error in
            if let err = error {
                print("ERROR: \(err)")
                return
            }
            var launches = [SXLaunchData]()
            guard let launchData = launchData else { return }
            do {
                launches = try JSONDecoder().decode([SXLaunchData].self, from: launchData)
                completion(launches,nil)
            } catch {
                print("ERROR: \(error.localizedDescription)")
                completion(launches,error.localizedDescription)
            }
        }
    }
    
}
