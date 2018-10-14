//
//  CreatePostVC.swift
//  SocialChatApp
//
//  Created by Teja PV on 9/15/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var textViewData: UITextView!
    
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var profileImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewData.delegate = self
        sendBtn.bindToKeyboard()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
    }

    @IBAction func sendBtnPressed(_ sender: Any) {
        if textViewData.text != nil && textViewData.text != "Say Something here...."{
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: textViewData.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil) { (success) in
                if success{
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else{
                    self.sendBtn.isEnabled = true
                    print("Error occured")
                }
            }
        }
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreatePostVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
