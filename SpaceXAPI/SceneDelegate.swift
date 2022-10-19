//
//  SceneDelegate.swift
//  SpaceXAPI
//
//  Created by Rashad Abdul-Salam on 10/17/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    /**
     Startup Coordinator Methods
     */
    var launchProvider = SXLaunchProviderService()

    /// Enum providing human-readable Int-values for Master-Details VCs
    enum SplitChildVCs : Int {
        case Master, Details
    }
    
//    var masterVC : SXLaunchesViewController?
//    var detailsVC : SXLaunchDetailsViewController?
    
    func getLaunchData() {
        guard
          let splitVC = window?.rootViewController as? SXSplitViewController,
            let masterVC = (splitVC.viewControllers[SplitChildVCs.Master.rawValue] as? UINavigationController)?.topViewController as? SXLaunchesViewController,
            let detailsVC = (splitVC.viewControllers[SplitChildVCs.Details.rawValue] as? UINavigationController)?.topViewController as? SXLaunchDetailsViewController
          else { fatalError() }
        masterVC.delegate = detailsVC
        self.launchProvider.getLaunchData { launches, error in
//            self?.launches = launches
            DispatchQueue.main.async {
                let firstLaunch = launches.first
                masterVC.launches = launches
                detailsVC.launch = firstLaunch
            }
        }
    }
    
    
    
    // ***** END Coordinator Methods
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        self.getLaunchData()
//        guard
//          let splitVC = window?.rootViewController as? SXSplitViewController,
////          let leftNavController = splitViewController.viewControllers.first
////            as? UINavigationController,
//            let masterVC = (splitVC.viewControllers[ChildVCIdx.Master.rawValue] as? UINavigationController)?.topViewController as? SXLaunchesViewController,
////          let masterViewController = leftNavController.viewControllers.first
////            as? SXLaunchesViewController,
////          let detailViewController = splitViewController.viewControllers.last
////            as? SXLaunchDetailsViewController
//            let detailsVC = splitVC.viewControllers[ChildVCIdx.Details.rawValue] as? SXLaunchDetailsViewController
//          else { fatalError() }

//        let firstMonster = masterViewController.monsters.first
//        detailViewController.monster = firstMonster
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

