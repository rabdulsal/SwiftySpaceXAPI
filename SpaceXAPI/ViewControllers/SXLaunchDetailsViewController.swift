//
//  SXLaunchDetailsViewController.swift
//  SpaceXAPI
//
//  Created by Rashad Abdul-Salam on 10/18/22.
//

import Foundation
import UIKit



/// Callback to inform Delegate-Implementer to decorate Receiver's View
protocol SXLaunchListSelectionDelegate : AnyObject {
    func selectedLaunchData(_ launchData: SXLaunchData)
}

/// ViewController representing
class SXLaunchDetailsViewController : UIViewController, SXLaunchDetailsInterface {
    
    @IBOutlet weak var missionPatchImageView: UIImageView!
    @IBOutlet weak var missionNameLabel: UILabel!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var launchSiteDateLabel: UILabel!
    
    var imageProviderService = SXImageProviderService()
    
    var launch: SXLaunchData? {
        didSet {
            self.loadViewIfNeeded()
            decorateView(with: launch!, patchImageURL: launch!.patchImgURL)
        }
    }
//    var delegate: SXLaunchListSelectionDelegate?
    
}

extension SXLaunchDetailsViewController : SXLaunchListSelectionDelegate {
    
    func selectedLaunchData(_ launchData: SXLaunchData) {
        self.decorateView(with: launchData)
    }
}

