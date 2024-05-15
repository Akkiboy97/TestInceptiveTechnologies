//
//  MemberDataManager.swift
//  TestInceptiveTechnologies
//
//  Created by Akshay Chaudhari on 15/05/24.
//

import Foundation

class MemberDataManager {
    
    static let shared = MemberDataManager()
    
    var arr_member:[MemberData]?
    
    static func getMemberData(completion: @escaping (([MemberData]) -> Void)) {
        guard let url = Bundle.main.url(forResource: "MembersData", withExtension: "json") else {
            fatalError("Unable to locate data.json file in bundle")
        }
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let members = try JSONDecoder().decode([MemberData].self, from: jsonData)
            MemberDataManager.shared.arr_member = members
            completion(members)
            debugPrint(members)
        } catch {
            debugPrint("Error reading or parsing JSON file: \(error.localizedDescription)")
        }
    }
}
