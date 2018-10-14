//
//  AccountVC.swift
//  SocialChatApp
//
//  Created by Teja PV on 9/15/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit
import Firebase

class AccountVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
    }

    @IBAction func signOutPressed(_ sender: Any) {
        let logOutPopup = UIAlertController(title: "Logout?", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        let logOutAction = UIAlertAction(title: "Logout", style: .destructive) { (buttonAction) in
            do{
               try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            } catch{
                print(error)
            }
        }
        logOutPopup.addAction(logOutAction)
        present(logOutPopup, animated: true, completion: nil)
    }
}
