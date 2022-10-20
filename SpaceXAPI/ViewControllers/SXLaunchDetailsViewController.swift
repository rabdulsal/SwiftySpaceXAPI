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
    @IBOutlet weak var launchDetailsLabel: UILabel!
    @IBOutlet weak var spinnerView: UIView!
    
    var imageProviderService = SXImageProviderService()
    
    var launch: SXLaunchData? {
        didSet {
            self.loadViewIfNeeded()
            self.populateLaunchDetails(with: launch!, patchImageURL: launch!.patchImgURL)
            self.spinnerView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinnerView.isHidden = false
    }
    
}

extension SXLaunchDetailsViewController : SXLaunchListSelectionDelegate {
    
    func selectedLaunchData(_ launchData: SXLaunchData) {
        self.populateLaunchDetails(with: launchData)
    }
}

private extension SXLaunchDetailsViewController {
    
    func populateLaunchDetails(with launchData: SXLaunchData, patchImageURL: URL?=nil) {
        self.launchDetailsLabel.text = launchData.launchDetails
        self.decorateView(with: launchData, patchImageURL: patchImageURL)
    }
}

