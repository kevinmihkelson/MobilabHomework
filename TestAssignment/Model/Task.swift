//
//  Task.swift
//  TestAssignment
//
//  Created by Kevin Mihkelson on 12.07.2023.
//

import Foundation

struct Task: Identifiable, Encodable, Decodable {
    var id: String
    var content: String
    var completed: Bool
}
