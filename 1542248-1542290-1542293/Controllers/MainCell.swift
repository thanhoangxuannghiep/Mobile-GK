//
//  MainCell.swift
//  1542248-1542290-1542293
//
//  Created by Than Hoang Xuan Nghiep on 4/8/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {

    @IBOutlet weak var lbKhuVuc: UILabel!
    @IBOutlet weak var lbTenBanAn: UILabel!
    @IBOutlet weak var imgBanAn: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
