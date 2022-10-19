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
            
            guard let data = imgData, let image = UIImage(data: data) else {
                /*TODO: Error */
                return
            }
            completion(image,nil)
        }
    }
}

typealias SXImageProviderCompletion = (_ image: UIImage, _ error: String?)->Void
///
class SXImageProviderService : SXImageRequestable {
    static var ImageCache = NSCache<NSURL,UIImage>()
    var resourceURL: URL?
    var defaultImage = UIImage.DefaultRocketLogo!
    
    init(resourceURL: URL?=nil) {
        self.resourceURL = resourceURL
    }
    
    /// Basic function for fetching image of Mission Patch
    func getMissionPatchImg(completion: @escaping (SXImageProviderCompletion)) {
        
        // Try via ImageCache
        if let url = self.resourceURL as? NSURL, let cachedImg = Self.ImageCache.object(forKey: url) {
            completion(cachedImg,nil)
            return
        }
        
        // Fetch from Web
        self.getImage { [weak self] image, error in
            guard let self = self else { return }
            if let err = error {
                print("ERROR: \(err)")
                self.cacheImageAndURL(self.defaultImage, url: self.resourceURL, error: err, completion: completion)
                return
            }
            
            guard let img = image else {
                // TODO: Provide Placeholder Image
//                completion(self.defaultImage,nil)
                self.cacheImageAndURL(self.defaultImage, url: self.resourceURL, completion: completion)
                return
            }
            self.cacheImageAndURL(img, url: self.resourceURL, completion: completion)
        }
    }
}

private extension SXImageProviderService {
    func cacheImageAndURL(_ image: UIImage, url: URL?, error: String?=nil, completion: @escaping (SXImageProviderCompletion)) {
        guard let url = url as? NSURL else { return }
        Self.ImageCache.setObject(image, forKey: url)
        completion(image,error)
    }
}
