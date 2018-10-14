//
//  SecondViewController.swift
//  SocialChatApp
//
//  Created by Teja PV on 9/5/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    var groupsArray = [Group]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllGroups { (returnedGroups) in
                self.groupsArray = returnedGroups
                self.tableView.reloadData()
            }
        }
        
    }
}

extension GroupsVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell else { return UITableViewCell()
        }
        let group = groupsArray[indexPath.row]
        cell.configureCell(title: group.groupTitle, description: group.groupDescription, memberCount: group.groupCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC else{ return }
        groupFeedVC.initData(forGroup: groupsArray[indexPath.row])
        //present(groupFeedVC, animated: true, completion: nil)
        presentDetail(groupFeedVC)
    }
}

