//
//  SXStartupCoordinator.swift
//  SpaceXAPI
//
//  Created by Rashad Abdul-Salam on 10/19/22.
//

import Foundation
import UIKit

/// Object that encapsulates all primary Master-Detail ViewController dependency configuration
final class SXStartupCoordinator {
    
    /// Enum providing human-readable Int-values for Master-Details VCs
    enum SplitChildVCs : Int {
        case Master, Details
    }
    
    var window: UIWindow?
    var launchProvider : SXLaunchProviderService
    
    init(window: UIWindow?, launchProvider: SXLaunchProviderService = SXLaunchProviderService()) {
        self.window = window
        self.launchProvider = launchProvider
    }
    
    func start() {
        self.getLaunchData()
    }
}

private extension SXStartupCoordinator {
    func getLaunchData() {
        guard
          let splitVC = window?.rootViewController as? SXSplitViewController,
            let masterVC = (splitVC.viewControllers[SplitChildVCs.Master.rawValue] as? UINavigationController)?.topViewController as? SXLaunchesViewController,
            let detailsVC = (splitVC.viewControllers[SplitChildVCs.Details.rawValue] as? UINavigationController)?.topViewController as? SXLaunchDetailsViewController
          else { fatalError() }
        masterVC.delegate = detailsVC
        self.launchProvider.getSortedLaunchData { launches, error in
            DispatchQueue.main.async {
                let firstLaunch = launches.first
                masterVC.launches = launches
                detailsVC.launch = firstLaunch
            }
        }
    }
}
