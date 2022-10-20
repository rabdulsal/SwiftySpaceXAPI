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
    var launchProviderDelegate: SXLaunchProvidable?
    
    func getLaunchData(completion: @escaping (_ launches: [SXLaunchData], _ error: String?)->Void) {
        self.makeRequest { launchData, error in
            if let err = error {
                completion([],err)
                return
            }
            var launches = [SXLaunchData]()
            guard let launchData = launchData else { return }
            do {
                launches = try JSONDecoder().decode([SXLaunchData].self, from: launchData)
                completion(launches,nil)
            } catch {
                completion(launches,error.localizedDescription)
            }
        }
    }
    
    func getSortedLaunchData(completion: @escaping (_ launches: [SXLaunchData], _ error: String?)->Void) {
        self.getLaunchData { launches, error in
            if let e = error {
                completion(launches,e)
                return
            }
            let sortedLaunches = launches.sorted { l1, l2 in
                l1.launchDate > l2.launchDate
            }
            completion(sortedLaunches,nil)
        }
    }
}
