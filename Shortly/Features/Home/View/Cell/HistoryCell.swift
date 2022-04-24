//
//  HistoryCell.swift
//  Shortly
//
//  Created by Hamit Seyrek on 24.04.2022.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var copyButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        whiteView.layer.cornerRadius = 10
        copyButton.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
