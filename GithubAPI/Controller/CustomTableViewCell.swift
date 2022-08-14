//
//  CustomTableViewCell.swift
//  GithubAPI
//
//  Created by Subodh Mahajan on 14/08/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {


    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var closedDateLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    // Setup movies values
    func setCellWithValuesOf(_ owner: Owner) {
        updateUI(title: owner.title, createdAt: owner.createdAt, closedAt: owner.closedAt, userName: owner.user?.login, userImage: owner.user?.avatarURL)
    }
    
    // Update the UI Views
    private func updateUI(title: String?, createdAt: String?, closedAt: String?, userName: String?, userImage: String?) {
        
        self.titleLabel.text = title
        self.createdDateLabel.text = createdAt
        self.closedDateLabel.text = closedAt
        self.userNameLabel.text = userName
        
        guard let userImageURL = URL(string: userImage!) else {
            self.userImage.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we clear out the old one
        self.userImage.image = nil
        
        getImageDataFrom(url: userImageURL)
        
    }
    
    // MARK: - Get image data
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.userImage.image = image
                }
            }
        }.resume()
    }

}
