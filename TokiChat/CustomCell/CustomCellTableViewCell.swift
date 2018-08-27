//
//  CustomCellTableViewCell.swift
//  TokiChat
//
//  Created by Petar Lemajic on 8/24/18.
//  Copyright © 2018 Metalic_archaea. All rights reserved.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var messageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
