//
//  ShadowView.swift
//  SocialChatApp
//
//  Created by Teja PV on 9/7/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        super.awakeFromNib()
    }

}
