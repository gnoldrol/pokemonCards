//
//  ListCardCell.swift
//  PokemonCard
//
//  Created by GnolDrol on 12/17/20.
//

import UIKit

class ListCardCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    class func cellName() -> String {
        return "ListCardCell"
    }
    
    class func cellHeight() -> CGFloat {
        return 80.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
