//
//  CommentTableCell.swift
//  News
//
//  Created by Maul on 19/02/22.
//

import UIKit

class CommentTableCell: UITableViewCell {

    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblCommennt: UILabel!
    @IBOutlet weak var dividerLine: UIView!
    
    static let identifier = "commentTableCell"
    static func commentTableNib() -> UINib {
        return UINib(nibName: "CommentTableCell", bundle: nil)
    }
    
    /// Set Value
    func setValue(username: String, comment: String) {
        lblUsername.text = username
        lblCommennt.text = comment
    }
    
    // MARK: - Configure View
    override func layoutSubviews() {
        super.layoutSubviews()
        dividerLine.backgroundColor = .grayStroke
    }
}
