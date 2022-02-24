//
//  CollectionAlbumCell.swift
//  PortalNews
//
//  Created by Maul on 24/02/22.
//

import UIKit

class CollectionAlbumCell: UICollectionViewCell {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var iconAlbums: UIImageView!
    @IBOutlet weak var lblAlbumName: UILabel!
    
    static let identifier = "albumCollectionCell"
    static func albumCollectionNib() -> UINib {
        return UINib(nibName: "CollectionAlbumCell", bundle: nil)
    }
    
    /// Set Value
    func setValue(albumName: String) {
        lblAlbumName.text = albumName
    }
    
    // MARK: - Configure View
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    private func setupViews() {
        lblAlbumName.textColor = .darkBlue
        
        container.layer.cornerRadius = 8
        container.layer.borderWidth = 0.8
        container.layer.borderColor = UIColor.grayStroke.cgColor
    }
}
