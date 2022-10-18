//
//  ViewController.swift
//  SpaceXAPI
//
//  Created by Rashad Abdul-Salam on 10/17/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var launchTableView: UITableView!
    
    var launchProvider = SXLaunchProviderService()
    var launches = [SXLaunchData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.launchTableView.delegate = self
        self.launchTableView.dataSource = self
        self.getLaunchData()
    }


}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SXLaunchSummaryCell.Identifier, for: indexPath) as? SXLaunchSummaryCell else { return UITableViewCell() }
        let launch = self.launches[indexPath.row]
//        cell.textLabel?.text = launch.missionName
//        cell.detailTextLabel?.text = launch.rocketName
        cell.configure(with: launch)
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    
}

private extension ViewController {
    
    
    func getLaunchData() {
        self.launchProvider.getLaunchData { [weak self] launches, error in
            self?.launches = launches
            DispatchQueue.main.async {
                self?.launchTableView.reloadData()
            }
        }
    }
}
