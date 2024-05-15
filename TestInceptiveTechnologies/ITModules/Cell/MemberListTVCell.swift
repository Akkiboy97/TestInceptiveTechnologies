//
//  MemberListTVCell.swift
//  TestInceptiveTechnologies
//
//  Created by Akshay Chaudhari on 15/05/24.
//

import UIKit

protocol MemberListTVCellDelegate {
    func btn_delete_pressed(index: Int)
    func btn_view_pressed(index: Int)
}

class MemberListTVCell: UITableViewCell {
    
    @IBOutlet weak var img_profile:UIImageView!
    @IBOutlet weak var lbl_name:UILabel!
    @IBOutlet weak var lbl_titleCompany:UILabel!
    @IBOutlet weak var btn_delete:UIButton!
    @IBOutlet weak var btn_view:UIButton!
    
    var delegate:MemberListTVCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMemberData(member: MemberData, delegate: MemberListTVCellDelegate, tag: Int) {
        self.delegate = delegate
        if let imageUrl = member.profileImage,
           imageUrl != "" {
            self.setImageFromStringrURL(stringUrl: imageUrl)
        } else {
            self.img_profile.image = UIImage(named: "ic_profile")
            self.img_profile.layer.cornerRadius = 25
        }
        
        self.lbl_name.text = member.memberName
        self.lbl_titleCompany.text = member.title_companyName_str
        self.btn_view.tag = tag
        self.btn_delete.tag = tag
    }
    
    //Temp func for load profile image
    func setImageFromStringrURL(stringUrl: String) {
        if let url = URL(string: stringUrl) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          guard let imageData = data else { return }
          DispatchQueue.main.async {
              let image = UIImage(data: imageData)?.resizeImage(to: self.img_profile.frame.size)
              self.img_profile.image = image
          }
        }.resume()
      }
    }
    
    @IBAction func btn_delete_pressed(_ sender: UIButton) {
        self.delegate?.btn_delete_pressed(index: sender.tag)
    }
    
    @IBAction func btn_view_pressed(_ sender: UIButton) {
        self.delegate?.btn_view_pressed(index: sender.tag)
    }
    
}

extension UIImage {
    func resizeImage(to size: CGSize) -> UIImage {
       return UIGraphicsImageRenderer(size: size).image { _ in
           draw(in: CGRect(origin: .zero, size: size))
    }
}}

public extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
