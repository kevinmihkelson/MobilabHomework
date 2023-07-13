//
//  TaskParent.swift
//  TestAssignment
//
//  Created by Kevin Mihkelson on 13.07.2023.
//

import Foundation

struct TaskParent: Encodable, Decodable {
    var name: String
    var task: Task
}
