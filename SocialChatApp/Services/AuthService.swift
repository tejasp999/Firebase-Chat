//
//  File.swift
//  SocialChatApp
//
//  Created by Teja PV on 9/7/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import Foundation
import Firebase

class AuthService{
    static let instance = AuthService()
    
    func registerUser(withEmail email:String, andPassword password: String, userCreationComplete : @escaping(_ status : Bool, _ error: Error?) -> ()){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user?.user else {
                userCreationComplete(false, error)
                return
            }
            let userData = ["provider" : user.providerID, "email":user.email]
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email:String, andPassword password: String, userLoginComplete : @escaping (_ status : Bool, _ error: Error?) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                userLoginComplete(false, error)
                return
            }
            userLoginComplete(true, nil)
        }
    }
    
    
}
