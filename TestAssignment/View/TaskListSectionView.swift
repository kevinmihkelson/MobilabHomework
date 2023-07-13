//
//  TaskListSectionView.swift
//  TestAssignment
//
//  Created by Kevin Mihkelson on 12.07.2023.
//

import SwiftUI

struct TaskListSectionView: View {
    var taskList: Binding<TaskList> // Use @Binding
    @State private var showAddNewTaskView: Bool = false
    @State private var showAlert: Bool = false
    @State private var showConfirmationDialog: Bool = false
    @ObservedObject var taskViewModel: TaskViewModel
    
    var body: some View {
        Section {
            DisclosureGroup {
                ForEach(taskList.wrappedValue.tasks, id: \.name) { taskParent in
                    TaskRow(taskParent: taskParent, taskListId: taskList.id, taskViewModel: taskViewModel)
                }.onDelete(perform: deleteItem)
                Button {
                    showAddNewTaskView.toggle()
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Task")
                    }.foregroundColor(.gray)
                }.accessibilityIdentifier("AddTask")
            } label: {
                HStack {
                    Text(taskList.wrappedValue.title).bold()
                    Text(taskList.wrappedValue.tasks.count.description).foregroundColor(.gray)
                    Spacer()
                    Button {
                        showConfirmationDialog.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                    }.foregroundColor(.black)
                }
                .padding(.vertical, 10)
            }.buttonStyle(PlainButtonStyle()).accentColor(.clear)
        }.listRowSeparator(.hidden)
            .accessibilityIdentifier("Section")
            .sheet(isPresented: $showAddNewTaskView) {
                NewTaskView(taskList: taskList, showAddNewTaskView: $showAddNewTaskView, taskViewModel: taskViewModel)
            }
            .confirmationDialog("", isPresented: $showConfirmationDialog, actions: {
                VStack {
                    Button("Delete List", role: .destructive) {
                        showAlert.toggle()
                    }
                }
            })
            .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Are you sure you want to delete this?"),
                            message: Text("There is no undo"),
                            primaryButton: .destructive(Text("Delete")) {
                                taskViewModel.deleteTaskList(taskListId: taskList.id)
                            },
                            secondaryButton: .cancel()
                        )
                    }

    }
    
    private func deleteItem(at offsets: IndexSet) -> Void {
        if let firstIndex = offsets.first {
            // Call the appropriate function to update the task list
            let taskParentName = taskList.wrappedValue.tasks[firstIndex].name
            let taskListId = taskList.wrappedValue.id
            taskViewModel.deleteTask(taskParentName: taskParentName, taskListId: taskListId)
            taskList.wrappedValue.tasks.remove(at: firstIndex)
        }
    }
}
