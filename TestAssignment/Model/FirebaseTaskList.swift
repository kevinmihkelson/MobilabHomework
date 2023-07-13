//
//  FirebaseTaskList.swift
//  TestAssignment
//
//  Created by Kevin Mihkelson on 13.07.2023.
//

import Foundation

struct FirebaseTaskList: Decodable {
    var id: String
    var tasks: [String : Task]?
    var title: String
}
