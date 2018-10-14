//
//  FeedCell.swift
//  SocialChatApp
//
//  Created by Teja PV on 9/15/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var userEmailLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(profileImage:UIImage, email: String, content: String){
        self.profileImage.image = profileImage
        self.userEmailLbl.text = email
        self.contentLbl.text = content
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
