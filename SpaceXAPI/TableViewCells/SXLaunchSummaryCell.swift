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

protocol SXLaunchDetailsInterface {
    var missionPatchImageView: UIImageView! { get set }
    var missionNameLabel: UILabel! { get set }
    var rocketNameLabel: UILabel! { get set }
    var launchSiteDateLabel: UILabel! { get set }
    var imageProviderService: SXImageProviderService { get set }
}

extension SXLaunchDetailsInterface {
    
    func decorateView(with launchData: SXLaunchData, patchImageURL: URL?=nil) {
        self.imageProviderService.resourceURL = patchImageURL ?? launchData.patchImgURLSmall
        self.missionPatchImageView.image = UIImage.DefaultRocketLogo
        self.imageProviderService.getMissionPatchImg { image, error in
            if let _ = error {
                // Do nothing as image is already pre-set to DefaultImage
                return
            }
            DispatchQueue.main.async {
                self.missionPatchImageView.image = image
            }
        }
        self.missionNameLabel.text = launchData.missionName
        self.rocketNameLabel.text = launchData.rocketName
        self.launchSiteDateLabel.text = "\(launchData.launchSite) - \(launchData.launchDateDisplay)"
    }
}

class SXLaunchSummaryCell : UITableViewCell, SXSelfIdentifiable, SXLaunchDetailsInterface {
    
    @IBOutlet weak var missionPatchImageView: UIImageView!
    
    @IBOutlet weak var missionNameLabel: UILabel!
    
    @IBOutlet weak var rocketNameLabel: UILabel!
    
    @IBOutlet weak var launchSiteDateLabel: UILabel!
    
    var imageProviderService = SXImageProviderService()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with launchData: SXLaunchData) {
        self.decorateView(with: launchData)
    }
}




