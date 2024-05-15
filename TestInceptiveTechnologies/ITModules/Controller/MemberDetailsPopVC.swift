//
//  MemberDetailsPopVC.swift
//  TestInceptiveTechnologies
//
//  Created by Akshay Chaudhari on 15/05/24.
//

import UIKit

class MemberDetailsPopVC: UIViewController {
    
    @IBOutlet weak var bgView:UIView!
    @IBOutlet weak var img_profile:UIImageView!
    @IBOutlet weak var lbl_name:UILabel!
    @IBOutlet weak var lbl_titleCompany:UILabel!
    @IBOutlet weak var btn_dimiss:UIButton!
    
    var member:MemberData?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)

        self.bgView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        self.bgView.layer.cornerRadius = 8
        
        setMemberData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 3, options: UIView.AnimationOptions(), animations: {
            
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            
            self.bgView.transform = CGAffineTransform.identity
            
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func setMemberData() {
        guard let _member = self.member else { return }
        if let imageUrl = _member.profileImage,
           imageUrl != "" {
            self.setImageFromStringrURL(stringUrl: imageUrl)
        } else {
            self.img_profile.image = UIImage(named: "ic_profile")
            self.img_profile.layer.cornerRadius = 25
        }
        
        self.lbl_name.text = _member.memberName
        self.lbl_titleCompany.text = _member.title_companyName_str
    }
    
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
    
    @IBAction func btn_dismiss_pressed(_ sender: UIButton) {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 3, options: UIView.AnimationOptions(), animations: {
            self.bgView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        }, completion: {
            finished in
            self.dismiss(animated: true)
        })
    }
    
}
