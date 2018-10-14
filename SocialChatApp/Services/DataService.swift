//
//  DataService.swift
//  SocialChatApp
//
//  Created by Teja PV on 9/7/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import Foundation
import Firebase

let DB_REF = Database.database().reference()

class DataService{
    static let instance = DataService()
    
    private var REFER_BASE = DB_REF
    private var REFER_USERS = DB_REF.child("Users")
    private var REFER_GROUPS = DB_REF.child("Groups")
    private var REFER_FEED = DB_REF.child("Feed")
    
    var REF_BASE : DatabaseReference{
        return REFER_BASE
    }
    
    var REF_USERS: DatabaseReference{
        return REFER_USERS
    }
    
    var REF_GROUPS: DatabaseReference{
        return REFER_GROUPS
    }
    
    var REF_FEED: DatabaseReference{
        return REFER_FEED
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>){
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func getUserName(forUID uid: String, handler: @escaping(_ username: String)->()){
        REF_USERS.observeSingleEvent(of: .value) { (userSnapShot) in
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapShot{
                if user.key == uid{
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
            
        }
    }
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping(_ status: Bool) -> ()){
        if groupKey != nil{
         REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content":message,"senderId":uid])
            sendComplete(true)
        } else{
            REF_FEED.childByAutoId().updateChildValues(["content":message,"senderId":uid])
            sendComplete(true)
        }
    }
    
    func getAllFeedMessages(handler: @escaping (_ messages : [Message])->()){
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for message in feedMessageSnapshot{
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let message = Message(content: content, senderId: senderId)
                messageArray.append(message)
            }
            handler(messageArray)
        }
    }
    
    func getAllMessages(forgroup group: Group, handler: @escaping(_ messagesArray : [Message])->()){
        var groupMessageArray = [Message]()
        REF_GROUPS.child(group.groupKey).child("messages").observeSingleEvent(of: .value) { (groupMessageSnapshot) in
            guard let groupMessageSnapshot = groupMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for groupMessage in groupMessageSnapshot{
                let content = groupMessage.childSnapshot(forPath: "content").value as! String
                let senderId = groupMessage.childSnapshot(forPath: "senderId").value as! String
                let groupMessage = Message(content: content, senderId: senderId)
                groupMessageArray.append(groupMessage)
            }
            handler(groupMessageArray)
        }
    }
    
    func getEmail(forSeacrhQuery query : String, handler : @escaping(_ emailArray : [String])->()){
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapShot) in
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapShot{
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) == true && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func getIds(forUserNames usernames: [String], handler : @escaping(_ uidArray : [String])->()){
        var idArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (userSnapShot) in
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapShot{
                let email = user.childSnapshot(forPath: "email").value as! String
                if usernames.contains(email){
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
    }
    
    func createGroup(withTitle title: String, andDesc description : String, forUserIds userIds : [String], handler : @escaping(_ groupCreated : Bool)->()){
        REF_GROUPS.childByAutoId().updateChildValues(["title":title,"description":description,"members":userIds])
        handler(true)
    }
    
    func getAllGroups(handler: @escaping(_ groupsArray : [Group])->()){
        var groupsArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapShot) in
            guard let groupSnapShot = groupSnapShot.children.allObjects as? [DataSnapshot] else { return }
            for group in groupSnapShot{
                let memberArray = group.childSnapshot(forPath: "members").value as! [String]
                if memberArray.contains((Auth.auth().currentUser?.uid)!){
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let description = group.childSnapshot(forPath: "description").value as! String
                    let group = Group(title: title, description: description, key: group.key, groupCount: memberArray.count, members: memberArray)
                    groupsArray.append(group)
                }
            }
            handler(groupsArray)
        }
    }
    
    func getEmails(forGroup group: Group, handler: @escaping(_ emails : [String])->()){
        var emailArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (userSnapShot) in
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapShot{
                if group.groupMembers.contains(user.key){
                    let email = user.childSnapshot(forPath: "email").value as! String
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
}
