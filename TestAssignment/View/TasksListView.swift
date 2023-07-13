//
//  TasksListView.swift
//  TestAssignment
//
//  Created by Kevin Mihkelson on 12.07.2023.
//

import SwiftUI

struct TasksListView: View {
    @ObservedObject var taskViewModel: TaskViewModel
    
    var body: some View {
        List {
            ForEach(taskViewModel.taskLists.indices, id: \.self) { index in
                TaskListSectionView(taskList: $taskViewModel.taskLists[index], taskViewModel: taskViewModel).accessibilityIdentifier("SingleTaskList")
            }
        }.scrollContentBackground(.hidden)
            .accessibilityIdentifier("TaskList")
    }
}

