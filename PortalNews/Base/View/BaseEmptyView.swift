//
//  BaseEmptyView.swift
//  PortalNews
//
//  Created by Maul on 21/02/22.
//

import UIKit

class BaseEmptyView: UIView {
    
    let img: UIImageView = {
        let v = UIImageView()
        v.backgroundColor = .clear
        v.contentMode = .scaleAspectFit
        v.widthAnchor.constraint(equalToConstant: 128).isActive = true
        v.heightAnchor.constraint(equalToConstant: 160).isActive = true
        return v
    }()
    
    let judul: UILabel = {
        let v = UILabel()
        v.textColor = .darkBlue
        v.font = .systemFont(ofSize: 16, weight: .semibold)
        v.text = "Title"
        v.textAlignment = .center
        v.numberOfLines = 0
        return v
    }()
    
    let desc: UILabel = {
        let v = UILabel()
        v.textColor = .gray
        v.font = .systemFont(ofSize: 16)
        v.text = "Deskripsi"
        v.textAlignment = .center
        v.numberOfLines = 0
        return v
    }()
    
    let svContent: UIStackView = {
        let v  = UIStackView()
        v.axis = .vertical
        v.spacing = 12
        v.distribution = .fill
        return v
    }()
    
    let svTitle: UIStackView = {
        let v  = UIStackView()
        v.axis = .vertical
        v.distribution = .fill
        v.spacing = 6
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(svContent)
        [img, svTitle].forEach { svContent.addArrangedSubview($0)}
        [judul, desc].forEach { svTitle.addArrangedSubview($0) }
        
        addConstraintsWithFormat(format: "V:|-(>=8)-[v0]-(>=8)-|", views: svContent)
        svContent.centerYAnchor(centerY: centerYAnchor)
        addConstraintsWithFormat(format: "H:|-(16)-[v0]-(16)-|", views: svContent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
