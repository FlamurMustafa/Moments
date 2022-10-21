//
//  MomentTableViewCell.swift
//  Moments
//
//  Created by user226725 on 10/21/22.
//

import UIKit

class MomentTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var momentPhotoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setCellWithValues(_ moment: Moment){
        nameLabel.text = moment.name
        descriptionLabel.text = moment.description
        
        let image = UIImage(data: moment.photo)
        momentPhotoImageView.image = image
        momentPhotoImageView.makeRound()
    }

}
