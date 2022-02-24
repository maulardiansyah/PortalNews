//
//  DetailPostCell.swift
//  PortalNews
//
//  Created by Maul on 24/02/22.
//

import UIKit

class DetailPostCell: UITableViewCell {

    @IBOutlet weak var lblUserNamePost: UILabel!
    @IBOutlet weak var lblTitlePost: UILabel!
    @IBOutlet weak var lblDescPost: UILabel!
    
    var nameTapped: SelectionClosure?
    
    static let identifier = "detailPostNewsTableCell"
    static func detailPostNewsTableNib() -> UINib {
        return UINib(nibName: "DetailPostCell", bundle: nil)
    }
    
    /// Set value
    func setPost(title: String, desc: String, userName: String) {
        lblTitlePost.text = title
        lblDescPost.text = desc
        lblUserNamePost.text = userName
    }
    
    //MARK: - ConfigureView
     override func layoutSubviews() {
         setupViews()
     }
     
     private func setupViews() {
         contentView.backgroundColor = .white
         
         lblUserNamePost.textColor = .darkBlue
         lblUserNamePost.isUserInteractionEnabled = true
         lblUserNamePost.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nameTappedAction)))
     }
    
    @objc
    func nameTappedAction() {
        nameTapped?()
    }
}
