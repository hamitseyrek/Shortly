//
//  HistoryCell.swift
//  Shortly
//
//  Created by Hamit Seyrek on 24.04.2022.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var shortLink: UILabel!
    @IBOutlet weak var originalLink: UILabel!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var delIcon: UIImageView!
    
    var didDelete: () -> ()  = { }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        whiteView.layer.cornerRadius = 10
        copyButton.layer.cornerRadius = 5
        // Initialization code
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(delImageTapped(tapGestureRecognizer:)))
            delIcon.isUserInteractionEnabled = true
            delIcon.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func delImageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        didDelete()
    }
    
    @IBAction func copyClicked(_ sender: Any) {
        UIPasteboard.general.string = shortLink.text
        copyButton.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        copyButton.setTitle("COPIED",for: .normal)
        copyButton.titleLabel?.textColor = .blue
    }
}
