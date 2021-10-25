//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Maria  Condemaita on 10/19/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var TweetContent: UILabel!
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
