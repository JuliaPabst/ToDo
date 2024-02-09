//
//  ItemCell.swift
//  ToDo
//
//  Created by Julia Pabst on 09.02.24.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
