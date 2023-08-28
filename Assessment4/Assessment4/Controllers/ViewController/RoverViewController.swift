//
//  RoverViewController.swift
//  Assessment4
//
//  Created by Colton Brenneman on 8/24/23.
//

import UIKit

class RoverViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var roverTableView: UITableView!
   
    // MARK: - Properties
    var roverData: TopLevelDictionary?
    var roverImage: UIImage?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        roverTableView.dataSource = self
        searchBar.delegate = self
        roverTableView.reloadData()
    }
} // End of class

// MARK: - Extension
extension RoverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roverData?.photos.count ?? 0
    }
    //roverCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "roverCell", for: indexPath) as? RoverTableViewCell else { return UITableViewCell() }
                
        guard let photo = roverData?.photos[indexPath.row] else { return UITableViewCell() }
        cell.updateUI(with: photo)
        
        return cell
    }
}

extension RoverViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        NetworkController().fetchRover(searchTerm: searchTerm) { result in
            switch result {
            case .success(let tld):
                DispatchQueue.main.async {
                    self.roverData = tld
                    self.roverTableView.reloadData()
                }
            case .failure(let error):
                print(error.errorDescription)
            }
        }
        searchBar.resignFirstResponder()
    }
}
