//
//  ViewController.swift
//  SpaceXAPI
//
//  Created by Rashad Abdul-Salam on 10/17/22.
//

import UIKit

class SXLaunchesViewController: UITableViewController {
    
    var launchProvider = SXLaunchProviderService()
    var launches = [SXLaunchData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.getLaunchData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SXLaunchSummaryCell.Identifier, for: indexPath) as? SXLaunchSummaryCell else { return UITableViewCell() }
        let launch = self.launches[indexPath.row]
//        cell.textLabel?.text = launch.missionName
//        cell.detailTextLabel?.text = launch.rocketName
        cell.configure(with: launch)
        return cell
    }
}

private extension SXLaunchesViewController {
    
    
    func getLaunchData() {
        self.launchProvider.getLaunchData { [weak self] launches, error in
            self?.launches = launches
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
