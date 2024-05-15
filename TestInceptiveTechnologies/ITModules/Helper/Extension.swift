//
//  Extension.swift
//  TestInceptiveTechnologies
//
//  Created by Akshay Chaudhari on 15/05/24.
//

import Foundation
import UIKit

extension UIView
{
    func setEmptyMessage(_ message: String,
                         isCenter: Bool = false,
                         color: UIColor = UIColor.black,
                         font: UIFont = UIFont.systemFont(ofSize: 18)) {
        let bgView = UIView()
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = color
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = font
        messageLabel.sizeToFit()
        bgView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = messageLabel.centerXAnchor.constraint(equalTo: bgView.centerXAnchor)
        let leadimgContraint = messageLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16)

        var verticalConstraint: NSLayoutConstraint?
        if isCenter{
            verticalConstraint = messageLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor)
        }else{
            verticalConstraint = messageLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 60)
        }
        bgView.addConstraints([horizontalConstraint, leadimgContraint, verticalConstraint!])
        
        if let tblView = self as? UITableView{
            tblView.backgroundView = bgView;
            tblView.separatorStyle = .none;
        }else if let clvView = self as? UICollectionView{
            clvView.backgroundView = bgView;
        }
    }
   
    func restore(separatorStyle: UITableViewCell.SeparatorStyle = .none) {
        
        if let tblView = self as? UITableView{
            tblView.backgroundView = nil;
            tblView.separatorStyle = separatorStyle;
        }else if let clvView = self as? UICollectionView{
            clvView.backgroundView = nil;
        }
    }
}

public extension UITableView {
    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: identifier ?? type.identifier)
    }
}

func getViewController(storyboard:String, identifier:String? = nil, creator: ((NSCoder) -> UIViewController?)? = nil) -> UIViewController?{
    let storyboard = UIStoryboard(name: storyboard, bundle: nil)
    guard let identifier = identifier else{
        return storyboard.instantiateInitialViewController(creator: creator)
    }
    return storyboard.instantiateViewController(identifier: identifier, creator: creator)
}

extension UIViewController{
    static var identifier: String {
        return String(describing: self)
    }
}
