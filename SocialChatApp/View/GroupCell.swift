//
//  GroupCell.swift
//  SocialChatApp
//
//  Created by Teja PV on 9/17/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescLbl: UILabel!
    @IBOutlet weak var membersCountLbl: UILabel!

    func configureCell(title: String, description : String, memberCount: Int){
        self.groupTitleLbl.text = title
        self.groupDescLbl.text = description
        self.membersCountLbl.text = "\(memberCount) members"
    }
    
}
