//
//  SXLaunchSummaryCell.swift
//  SpaceXAPI
//
//  Created by Rashad Abdul-Salam on 10/18/22.
//

import Foundation
import UIKit

protocol SXSelfIdentifiable { }

extension SXSelfIdentifiable {
    static var Identifier: String {
        return String(describing: self)
    }
}

class SXLaunchSummaryCell : UITableViewCell, SXSelfIdentifiable {
    
    @IBOutlet weak var missionPatchImageView: UIImageView!
    
    @IBOutlet weak var missionNameLabel: UILabel!
    
    @IBOutlet weak var rocketNameLabel: UILabel!
    
    @IBOutlet weak var launchSiteDateLabel: UILabel!
    
    var imageService = SXImageProviderService()
    
    func configure(with data: SXLaunchData) {
        self.imageService.resourceURL = URL(string: data.missionPatchImgURLSmall)
        self.missionPatchImageView.image = nil // TODO: Set to Default Image first
        self.imageService.getMissionPatchImg { image, error in
            if let err = error {
                // Just return with Default image
                return
            }
            DispatchQueue.main.async {
                self.missionPatchImageView.image = image
            }
        }
        self.missionNameLabel.text = data.missionName
        self.rocketNameLabel.text = data.rocketName
        self.launchSiteDateLabel.text = "\(data.launchSite) - \(data.launchDate)"
        
    }
}

protocol SXImageRequestable : SXNetworkingRequestable {}

extension SXNetworkingRequestable {
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

class SXImageProviderService : SXImageRequestable {
    static var ImageCache = NSCache<NSURL,UIImage>()
    var resourceURL: URL?
    
    init(resourceURL: URL?=nil) {
        self.resourceURL = resourceURL
    }
    
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
