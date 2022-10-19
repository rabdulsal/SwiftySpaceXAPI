//
//  SXSplitViewController.swift
//  SpaceXAPI
//
//  Created by Rashad Abdul-Salam on 10/18/22.
//

import Foundation
import UIKit

class SXSplitViewController : UISplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    
}

extension SXSplitViewController : UISplitViewControllerDelegate {
    
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary
    }
}
