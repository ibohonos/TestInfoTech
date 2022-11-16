//
//  CityTableViewCell.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import UIKit

class CityTableViewCell: UITableViewCell, ReusableCell {
    // MARK: - Outlets
    @IBOutlet private weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var cellImageView: UIImageView!
    @IBOutlet private weak var cellTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public
    func setupCell(with city: City, image: String) {
        imageActivityIndicator.startAnimating()
        
        cellTitleLabel.text = city.name
        
        if let url = URL(string: image) {
            ImageFromWeb.shared.loadImage(url: url) { [weak self] image, error in
                if let error {
                    print(error)
                }

                DispatchQueue.main.async {
                    self?.imageActivityIndicator.stopAnimating()
                    self?.imageActivityIndicator.isHidden = true

                    if let image {
                        self?.cellImageView.image = image
                    }
                }
            }
        }
    }
}
