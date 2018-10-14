//
//  GroupFeedVC.swift
//  SocialChatApp
//
//  Created by Teja PV on 9/17/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {

    @IBOutlet weak var groupTableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messageTxtField: InsetTextField!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var groupTitleLbl: UILabel!
    
    var group : Group?
    var groupMessages = [Message]()
    func initData(forGroup group: Group){
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBtn.bindToKeyboard()
        groupTableView.delegate = self as? UITableViewDelegate
        groupTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.groupTitleLbl.text = group?.groupTitle
        DataService.instance.getEmails(forGroup: self.group!) { (returnedEmails) in
            self.membersLbl.text = returnedEmails.joined(separator: ", ")
        }
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessages(forgroup: self.group!, handler: { (returnedGroupMessages) in
                self.groupMessages = returnedGroupMessages
                self.groupTableView.reloadData()
                if self.groupMessages.count > 0{
                    self.groupTableView.scrollToRow(at: IndexPath.init(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
                }
            })
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        dismissDetail()
    }
    
    @IBAction func sendBtnClicked(_ sender: Any) {
        if messageTxtField.text != "" {
            messageTxtField.isEnabled = false
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTxtField.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.groupKey) { (complete) in
                if complete{
                    self.messageTxtField.isEnabled = true
                    self.sendBtn.isEnabled = true
                    self.messageTxtField.text = ""
                }
            }
        }
    }
}

extension GroupFeedVC : UITabBarDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell") as? GroupFeedCell else { return UITableViewCell()}
        let message = groupMessages[indexPath.row]
        DataService.instance.getUserName(forUID: message.senderId) { (email) in
            cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: email, content: message.content)
        }
        return cell
        
    }
}
