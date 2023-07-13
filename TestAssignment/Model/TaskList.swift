//
//  TaskList.swift
//  TestAssignment
//
//  Created by Kevin Mihkelson on 12.07.2023.
//

import Foundation

struct TaskList: Identifiable, Encodable, Decodable {
    var id: String
    var title: String
    var tasks: [TaskParent]
}
