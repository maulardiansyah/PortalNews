//
//  UIImageView+Ext.swift
//  PortalNews
//
//  Created by Maul on 21/02/22.
//

import Kingfisher
import UIKit

extension UIImageView {
    /// To set image from  API
    func setImage(_ urlstring: String, placeholder: UIImage? = .imgPlaceholder) {
        if let url = URL(string: urlstring) {
            self.contentMode = .scaleAspectFill
            self.clipsToBounds = true
            self.kf.indicatorType = .activity
            self.kf.setImage(
                with: url,
                placeholder: placeholder,
                options: [.transition(.fade(1))],
                completionHandler: { result in })
        }
    }
}
