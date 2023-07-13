//
//  TaskViewModel.swift
//  TestAssignment
//
//  Created by Kevin Mihkelson on 12.07.2023.
//

import Foundation
import Alamofire

class TaskViewModel: ObservableObject {
    @Published var taskLists: [TaskList] = []
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    
    private let taskService: TaskServiceDelegate
    
    init(taskService: TaskServiceDelegate = TaskService()) {
        self.taskService = taskService
    }
    
    func getTaskLists() {
        taskService.getTaskLists { [self] result in
            switch result {
            case .success(let incomingList):
                taskLists = incomingList
            case .failure(let error):
                errorMessage = error.localizedDescription
                showAlert.toggle()
            }
        }
    }
    
    func deleteTaskList(taskListId: String) {
        taskService.deleteTaskList(taskListId: taskListId) { [self] result in
            switch result {
            case .success:
                if let index = taskLists.firstIndex(where: { $0.id == taskListId }) {
                    taskLists.remove(at: index)
                    print("Task list deleted successfully")
                }
            case .failure:
                errorMessage = "Error deleting task list"
                showAlert.toggle()
            }
        }
    }
    
    func addTaskList(taskList: TaskList) {
        taskService.addTaskList(taskList: taskList) { [self] result in
            switch result {
            case .success:
                taskLists.append(taskList)
            case .failure:
                errorMessage = "Error adding task list"
                showAlert.toggle()
            }
        }
    }
    
    func deleteTask(taskParentName: String, taskListId: String) {
        taskService.deleteTask(taskParentName: taskParentName, taskListId: taskListId) { [self] result in
            switch result {
            case .success:
                print("Successfully deleted task")
            case .failure:
                errorMessage = "Error deleting task"
                showAlert.toggle()
            }
        }
    }
    
    func patchTaskCompletion(taskCompletion: Bool, taskId: String, taskListId: String) {
        taskService.patchTaskCompletion(taskCompletion: taskCompletion, taskId: taskId, taskListId: taskListId) { [self] result in
            switch result {
            case .success:
                // Update the task completion locally
                if let index = taskLists.firstIndex(where: { $0.id == taskListId }) {
                    if let taskParentIndex = taskLists[index].tasks.firstIndex(where: { parent in
                        parent.name == taskId
                    }) {
                        taskLists[index].tasks[taskParentIndex].task.completed = taskCompletion
                    }
                }
            case .failure:
                errorMessage = "Error updating task completion"
                showAlert.toggle()
            }
        }
    }
    
    func addTaskToTaskList(task: Task, taskListId: String) {
        taskService.addTaskToTaskList(task: task, taskListId: taskListId) { [self] result in
            switch result {
            case .success(let newTaskParent):
                
                if let index = self.taskLists.firstIndex(where: { $0.id == taskListId }) {
                    // Create a mutable copy of the taskList
                    var updatedTaskList = self.taskLists[index]
                    // Append the new TaskParent to the tasks array of the updatedTaskList
                    updatedTaskList.tasks.append(newTaskParent)
                    // Update the taskList in the taskLists array
                    self.taskLists[index] = updatedTaskList
                }
            case .failure:
                errorMessage = "Error fetching task lists"
                showAlert.toggle()
            }
        }
        
    }
}
