//
//  CustomCollectionViewCell.swift
//  DeisgnApp
//
//  Created by Talha Asif on 30/04/2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var labelText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupButton(button:UIButton) {
//        button.cornerRadius = 10.0
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 0.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 2.0
        button.layer.shadowOpacity = 0.3
        button.layer.masksToBounds = false
    }
}
