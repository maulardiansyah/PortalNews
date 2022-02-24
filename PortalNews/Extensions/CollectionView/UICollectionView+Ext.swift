//
//  UICollectionView+Ext.swift
//  PortalNews
//
//  Created by Maul on 24/02/22.
//

import UIKit

extension UICollectionView {
    
    /// Set Empty View
    func setEmptyView(img: UIImage?, title: String, desc: String) {
        let view = BaseEmptyView()
        view.sizeToFit()
        view.img.image = img
        view.judul.text = title
        view.desc.text = desc
        self.backgroundView = view
    }
    
    func removeEmptyView() {
        self.backgroundView = nil
    }
}
