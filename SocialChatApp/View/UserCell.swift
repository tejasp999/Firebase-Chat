//
//  UserCell.swift
//  SocialChatApp
//
//  Created by Teja PV on 9/17/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var selectedImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    
    var showSelected = false
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            selectedImg.isHidden = false
        }else{
            selectedImg.isHidden = true
        }
        // Configure the view for the selected state
    }
    
    func configureCell(profileImage image: UIImage, email: String, isSelected : Bool){
        self.userImg.image = image
        self.emailLbl.text = email
        if isSelected {
            if showSelected == false{
                self.selectedImg.isHidden = false
                showSelected = true
            }
        } else {
            self.selectedImg.isHidden = true
            showSelected = false
        }
    }

}
