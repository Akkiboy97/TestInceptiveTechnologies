//
//  ViewController.swift
//  TestInceptiveTechnologies
//
//  Created by Akshay Chaudhari on 15/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerCell(type: ViewMoreButtonTVCCell.self)
            tableView.registerCell(type: MemberListTVCell.self)
        }
    }
    
    var arr_member = [MemberData](){
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var maxCellView: Int = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Members"
        MemberDataManager.getMemberData() { members in
            self.arr_member = members
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.arr_member.count > 0 else {
            tableView.setEmptyMessage("Member data not available", isCenter: true, color: .black)
            return 0
        }
        tableView.restore()
        return (self.arr_member.count > 3) ? self.maxCellView : self.arr_member.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberListTVCell.identifier, for: indexPath) as! MemberListTVCell
        let member = self.arr_member[indexPath.row]
        cell.setMemberData(member: member, delegate: self, tag: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if self.arr_member.count > 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ViewMoreButtonTVCCell.identifier) as! ViewMoreButtonTVCCell
            cell.btn_viewMore.configuration?.title = (self.maxCellView > 3) ? "Hide More" : "View More"
            cell.delegate = self
            return cell
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (self.maxCellView > 2) ? 50 : 0
    }
    
}

extension ViewController: ViewMoreButtonTVCCellDelegate {
    func btn_viewMore_pressed(index: Int) {
        if self.maxCellView == 3 {
            self.maxCellView = self.arr_member.count
        } else {
            self.maxCellView = 3
        }
        self.tableView.reloadData()
    }
}

extension ViewController: MemberListTVCellDelegate {
    func btn_delete_pressed(index: Int) {
        let member = self.arr_member[index]
        let messageVC = MessageVC.initVC(title: "Remove member", message: "Are you sure! want to remove \(member.memberName ?? "") from members list.", buttonTitles: ["Yes", "No"]) { btnIndex in
            if btnIndex == 0 {
                self.arr_member.remove(at: index)
                if self.maxCellView > 3 {
                    self.maxCellView = self.arr_member.count
                }
                self.tableView.reloadData()
            }
        }
        messageVC.modalPresentationStyle = .overCurrentContext
        messageVC.modalTransitionStyle = .crossDissolve
        messageVC.definesPresentationContext = true
        messageVC.providesPresentationContextTransitionStyle = true
        self.present(messageVC, animated: true)
    }
    
    func btn_view_pressed(index: Int) {
        let member = self.arr_member[index]
        let vc = getViewController(storyboard: "Main", identifier: MemberDetailsPopVC.identifier) as! MemberDetailsPopVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.definesPresentationContext = true
        vc.providesPresentationContextTransitionStyle = true
        vc.member = member
        self.present(vc, animated: true)
    }
}
