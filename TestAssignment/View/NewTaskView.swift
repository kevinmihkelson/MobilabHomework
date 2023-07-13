//
//  NewTaskView.swift
//  TestAssignment
//
//  Created by Kevin Mihkelson on 12.07.2023.
//

import SwiftUI

struct NewTaskView: View {
    @State private var taskName: String = ""
    @Binding var taskList: TaskList
    @Binding var showAddNewTaskView: Bool
    @ObservedObject var taskViewModel: TaskViewModel
    
    var body: some View {
        VStack {
            Text("Add a new Task").font(.largeTitle).bold()
            TextField("Task name", text: $taskName)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(.white).padding())
                .accessibilityIdentifier("AddTaskNameTextField")
            Button {
                let newTask = Task(id: UUID().description, content: taskName, completed: false)
                taskViewModel.addTaskToTaskList(task: newTask, taskListId: taskList.id)
                showAddNewTaskView.toggle()
            } label: {
                let taskNameEmpty = taskName.count > 0
                Text("Add task")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 8).fill(!taskNameEmpty ? .gray.opacity(0.3) : .black))
                    .disabled(!taskNameEmpty)
                    .accessibilityIdentifier("FinishAddingTaskButton")
            }.padding()
        }
    }
}
