//
//  CollectionPhotoCell.swift
//  PortalNews
//
//  Created by Maul on 24/02/22.
//

import UIKit

class CollectionPhotoCell: UICollectionViewCell {

    @IBOutlet weak var imgPhotos: UIImageView!
    
    static let identifier = "CollectionPhotoCell"
    static func collectionPhotoNib() -> UINib {
        return UINib(nibName: "CollectionPhotoCell", bundle: nil)
    }
    
    /// Set Value
    func setValue(photoUrl: String) {
        imgPhotos.setImage(photoUrl, placeholder: .imgPlaceholder)
    }
}
