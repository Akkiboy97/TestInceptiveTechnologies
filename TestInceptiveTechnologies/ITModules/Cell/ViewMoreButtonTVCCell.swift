//
//  ViewMoreButtonTVCCell.swift
//  TestInceptiveTechnologies
//
//  Created by Akshay Chaudhari on 15/05/24.
//

import UIKit

protocol ViewMoreButtonTVCCellDelegate {
    func btn_viewMore_pressed(index: Int)
}

class ViewMoreButtonTVCCell: UITableViewCell {
    
    @IBOutlet weak var btn_viewMore:UIButton!
    
    var delegate:ViewMoreButtonTVCCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btn_viewMore_pressed(_ sender: UIButton) {
        self.delegate?.btn_viewMore_pressed(index: sender.tag)
    }
    
}
