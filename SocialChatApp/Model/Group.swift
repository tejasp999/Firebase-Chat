//
//  Group.swift
//  SocialChatApp
//
//  Created by Teja PV on 9/17/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import Foundation

class Group{
    private var _groupTitle : String
    private var _groupDescription : String
    private var _groupKey : String
    private var _groupCount : Int
    private var _groupMembers : [String]
    
    var groupTitle : String{
        return _groupTitle
    }
    
    var groupDescription : String{
        return _groupDescription
    }
    
    var groupKey : String{
        return _groupKey
    }
    
    var groupCount : Int{
        return _groupCount
    }
    
    var groupMembers : [String]{
        return _groupMembers
    }
    
    init(title: String, description : String, key: String, groupCount: Int, members : [String]) {
        self._groupTitle = title
        self._groupDescription = description
        self._groupKey = key
        self._groupCount = groupCount
        self._groupMembers = members
    }
    
}
