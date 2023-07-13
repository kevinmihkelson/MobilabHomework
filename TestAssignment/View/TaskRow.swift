//
//  TaskRow.swift
//  TestAssignment
//
//  Created by Kevin Mihkelson on 12.07.2023.
//

import SwiftUI

struct TaskRow: View {
    var taskParent: TaskParent
    let taskListId: String
    @ObservedObject var taskViewModel: TaskViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                taskViewModel.patchTaskCompletion(taskCompletion: !taskParent.task.completed, taskId: taskParent.name, taskListId: taskListId)
            } label: {
                Image(systemName: taskParent.task.completed ? "checkmark.circle" : "circle")
            }.foregroundColor(.black)
            Text(taskParent.task.content).strikethrough(taskParent.task.completed)
        }
    }
}
