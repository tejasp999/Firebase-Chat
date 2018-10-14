//
//  CreateGroupsVC.swift
//  SocialChatApp
//
//  Created by Teja PV on 9/16/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupMembersLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTxtField: InsetTextField!
    @IBOutlet weak var emailSearchTxtField: InsetTextField!
    
    var emailArray = [String]()
    var selectedUserArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchTxtField.delegate = self
        emailSearchTxtField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }

    @objc func textFieldDidChange(){
        if emailSearchTxtField.text == ""{
            emailArray = []
            tableView.reloadData()
        }else{
            DataService.instance.getEmail(forSeacrhQuery: emailSearchTxtField.text!) { (dataArray) in
                if dataArray.count > 0 {
                    self.emailArray = dataArray
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        if titleTextField.text != "" && descriptionTxtField.text != ""{
            DataService.instance.getIds(forUserNames: selectedUserArray) { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                DataService.instance.createGroup(withTitle: self.titleTextField.text!, andDesc: self.descriptionTxtField.text!, forUserIds: userIds, handler: { (groupCreated) in
                    if groupCreated{
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        print("Could not create the group")
                    }
                })
            }
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreateGroupsVC : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else{
            return UITableViewCell()
        }
        let profileImg = UIImage(named: "defaultProfileImage")
        if selectedUserArray.contains(emailArray[indexPath.row]){
            cell.configureCell(profileImage: profileImg!, email: emailArray[indexPath.row], isSelected: true)
        }else{
            cell.configureCell(profileImage: profileImg!, email: emailArray[indexPath.row], isSelected: false)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else{ return }
        if !selectedUserArray.contains(cell.emailLbl.text!){
            selectedUserArray.append(cell.emailLbl.text!)
            groupMembersLbl.text = selectedUserArray.joined(separator: ",")
            doneBtn.isHidden = false
        }else{
            selectedUserArray = selectedUserArray.filter({ $0 != cell.emailLbl.text! })
            if selectedUserArray.count >= 1{
                groupMembersLbl.text = selectedUserArray.joined(separator: ",")
            } else {
                groupMembersLbl.text = "Add People to the group"
                doneBtn.isHidden = true
            }
        }
    }
}

extension CreateGroupsVC : UITextFieldDelegate{
    
}
