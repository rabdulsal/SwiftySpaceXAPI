//
//  ViewController.swift
//  SpaceXAPI
//
//  Created by Rashad Abdul-Salam on 10/17/22.
//

import UIKit

class SXLaunchesViewController: UITableViewController {
    
    var launchProvider = SXLaunchProviderService()
    var launches : [SXLaunchData]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    weak var delegate: SXLaunchListSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
//        self.getLaunchData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SXLaunchSummaryCell.Identifier, for: indexPath) as? SXLaunchSummaryCell, let launch = self.launches?[indexPath.row] else { return UITableViewCell() }
        
        cell.configure(with: launch)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let launch = self.launches?[indexPath.row] else { return }
        delegate?.selectedLaunchData(launch)
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
