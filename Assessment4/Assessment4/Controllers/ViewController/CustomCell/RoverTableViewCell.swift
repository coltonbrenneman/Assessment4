//
//  RoverTableViewCell.swift
//  Assessment4
//
//  Created by Colton Brenneman on 8/24/23.
//

import UIKit

class RoverTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var roverNameLabel: UILabel!
    @IBOutlet weak var roverImageView: UIImageView!
    
    // MARK: - Functions
    func updateUI(with rover: Photo?) {
        guard let rover = rover else { return }

        NetworkController().fetchImage(with: rover.imagePath) { [weak self] result in
            print(rover.imagePath)
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.roverImageView.image = image
                    self?.roverNameLabel.text = rover.camera.cameraName
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.roverImageView.image = UIImage(named: "colton")
                    self?.roverNameLabel.text = "Error: \(error)"
                }
            }
        }
    }

} // End of class
