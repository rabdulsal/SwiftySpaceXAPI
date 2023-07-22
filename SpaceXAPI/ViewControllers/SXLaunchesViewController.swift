//
//  ViewController.swift
//  SpaceXAPI
//
//  Created by Rashad Abdul-Salam on 10/17/22.
//

import UIKit

class SXLaunchesViewController: UIViewController {
    
    @IBOutlet weak var launchesTableView: UITableView!
    @IBOutlet weak var spinnerView: UIView!
    
    var launchProvider = SXLaunchProviderService()
    var launches : [SXLaunchData]? {
        didSet {
            self.loadViewIfNeeded()
            self.launchesTableView.reloadData()
            self.spinnerView.isHidden = true
        }
    }
    
    weak var delegate: SXLaunchListSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SpaceX Launches List"
        self.launchesTableView.delegate = self
        self.launchesTableView.dataSource = self
        self.spinnerView.isHidden = false
    }
    
    func setLaunchListDelegate(_ delegate: SXLaunchListSelectionDelegate) async {
        self.delegate = delegate
    }
    
}

extension SXLaunchesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SXLaunchSummaryCell.Identifier, for: indexPath) as? SXLaunchSummaryCell, let launch = self.launches?[indexPath.row] else { return UITableViewCell() }
        
        cell.configure(with: launch)
        return cell
    }
}

extension SXLaunchesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let launch = self.launches?[indexPath.row] else { return }
        delegate?.selectedLaunchData(launch)
        if let launchDetailsVC = delegate as? SXLaunchDetailsViewController {
            splitViewController?.showDetailViewController(launchDetailsVC, sender: nil)
        }
    }
}
