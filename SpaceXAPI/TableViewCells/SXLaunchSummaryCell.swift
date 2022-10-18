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




