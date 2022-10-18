//
//  SXImageProviderService.swift
//  SpaceXAPI
//
//  Created by Rashad Abdul-Salam on 10/18/22.
//

import Foundation
import UIKit

/// Interface managing basic functionality for fetching & unwrapping UIImage resources
protocol SXImageRequestable : SXNetworkingRequestable {}

extension SXImageRequestable {
    func getImage(completion: @escaping (_ image: UIImage?, _ error: String?)->Void) {
        self.makeRequest { imgData, error in
            if let err = error {
                // Error
                completion(nil,err)
                return
            }
            
            guard let data = imgData, let image = UIImage(data: data) else { /*TODO: Error */return }
            completion(image,nil)
        }
    }
}

///
class SXImageProviderService : SXImageRequestable {
    static var ImageCache = NSCache<NSURL,UIImage>()
    var resourceURL: URL?
    
    init(resourceURL: URL?=nil) {
        self.resourceURL = resourceURL
    }
    
    /// Basic function for fetching image of Mission Patch
    func getMissionPatchImg(completion: @escaping (_ image: UIImage, _ error: String?)->Void) {
        
        // Try via ImageCache
        if let url = self.resourceURL as? NSURL, let cachedImg = Self.ImageCache.object(forKey: url) {
            completion(cachedImg,nil)
            return
        }
        
        // Fetch from Web
        self.getImage { image, error in
            if let err = error {
                
                return
            }
            
            guard let img = image else {
                // TODO: Provide Placeholder Image
                return
            }
            completion(img,nil)
        }
    }
}
