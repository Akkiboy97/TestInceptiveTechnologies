//
//  Member.swift
//  TestInceptiveTechnologies
//
//  Created by Akshay Chaudhari on 15/05/24.
//

import Foundation

struct MemberData:Hashable, Codable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    var uuid = UUID()
    var networkProfileID: Int?
    var memberName:String?
    var memberCompany:String?
    var title: String?
    var profileImage: String?

    enum CodingKeys: String, CodingKey {
        case networkProfileID = "NetworkProfileID"
        case memberName = "MemberName"
        case memberCompany = "MemberCompany"
        case title = "Title"
        case profileImage = "ProfileImage"
    }
    
    var title_companyName_str: String {
        var str = ""
        if  let _title = self.title {
            str = _title
        }
        
        if let _memberCompany = self.memberCompany {
            str = str + ", " + _memberCompany
        }
        
        return str
    }
}

