//
//  PostNewsTableCell.swift
//  PortalNews
//
//  Created by Maul on 24/02/22.
//

import UIKit

class PostNewsTableCell: UITableViewCell {
    
    @IBOutlet weak var containerContent: UIView!
    @IBOutlet weak var lblTitlePost: UILabel!
    @IBOutlet weak var lblDescPost: UILabel!
    @IBOutlet weak var commentCountButton: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserCompany: UILabel!
    
    static let identifier = "postNewsTableCell"
    static func postNewsTableNib() -> UINib {
        return UINib(nibName: "PostNewsTableCell", bundle: nil)
    }
    
    /// Set value
    func setPost(title: String, desc: String, commentCount: Int) {
        lblTitlePost.text = title
        lblDescPost.text = desc
        commentCountButton.setTitle("\(commentCount)", for: .normal)
    }
    
    func setUser(name: String, company: String) {
        lblUserName.text = name
        lblUserCompany.text = company
    }

   //MARK: - ConfigureView
    override func layoutSubviews() {
        setupViews()
    }
    
    private func setupViews() {
        containerContent.layer.cornerRadius = 8
        containerContent.layer.borderColor = UIColor.grayStroke.cgColor
        containerContent.layer.borderWidth = 0.8
        
        commentCountButton.titleEdgeInsets.left = 10
        contentView.backgroundColor = .bgSoftBlue
        
        lblUserName.textColor = .darkBlue
        lblUserCompany.textColor = .gray
    }
}
