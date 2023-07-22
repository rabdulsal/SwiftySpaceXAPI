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

class SXLaunchProviderService {
    
    private var launchRequestService = SXLaunchRequestService()
    var launchProviderDelegate: SXLaunchProvidable?
    
    func getLaunchData(completion: @escaping (_ launches: [SXLaunchData], _ error: String?)->Void) {
        launchRequestService.makeRequest { launchData, error in
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
    
    func getAsyncLaunchData() async throws -> Result<[SXLaunchData],Error> {
        do {
            let dataResult = try await self.launchRequestService.makeAsyncRequest()
            
            switch dataResult {
            case .success(let data):
                let launchData = try JSONDecoder().decode([SXLaunchData].self, from: data)
                return .success(launchData)
            case.failure(let error):
                throw error
            }
        } catch {
            throw SXNetworkingError.badData
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
    
    func getAsyncSortedLaunchData() async throws -> [SXLaunchData] {
        
        do {
            let result = try await self.getAsyncLaunchData()
            switch result {
            case .success(let launchData):
                return launchData.sorted { $0.launchDate < $1.launchDate }
            case.failure(let error):
                throw error
            }
           
        } catch {
            throw error
        }
    }
}
