//
//  MyProjectEditTeamMembersViewController.swift
//  Partner
//
//  Created by Weslie on 29/01/2018.
//

import UIKit

class MyProjectEditTeamMembersViewController: UIViewController {
    
    @IBAction func popBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var projID: Int?
    var memberID: Int?
    var status: Int?

    @IBOutlet weak var tableView: ProjectEditTeamMemberTableView!

    @IBOutlet weak var addMemberBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.loadMemberdata()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO:- pass proj id to tableview
        tableView.projID = projID
        tableView.status = status
        if status != 0 {
            addMemberBtn.isHidden = true
        }
        
        tableView.passIDClosure = { member in
            weak var weakSelf = self
            weakSelf?.memberID = member
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! MyProjectEditAddTeamMembersViewController
        if segue.identifier == "MPETMPushDetialInfoSegue" {
            dest.isEditMember = true
            dest.memberID = memberID
            dest.projID = projID
        } else if segue.identifier == "MPETMPushAddMemberSegue" {
            dest.isEditMember = false
            dest.projID = projID
        }
    }

}
