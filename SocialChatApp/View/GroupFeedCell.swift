//
//  GroupFeedCell.swift
//  SocialChatApp
//
//  Created by Teja PV on 9/17/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(profileImage image: UIImage, email: String, content : String){
        self.profileImg.image = image
        self.contentLbl.text = content
        self.emailLbl.text = email
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
