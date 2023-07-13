//
//  TaskService.swift
//  TestAssignment
//
//  Created by Kevin Mihkelson on 13.07.2023.
//

import Foundation

protocol TaskServiceDelegate {
    func getTaskLists(completion: @escaping(Result<[TaskList], NetworkError>) -> Void)
    func deleteTaskList(taskListId: String, completion: @escaping(Result<String, NetworkError>) -> Void)
    func addTaskList(taskList: TaskList, completion: @escaping(Result<String, NetworkError>) -> Void)
    func deleteTask(taskParentName: String, taskListId: String, completion: @escaping(Result<String, NetworkError>) -> Void)
    func patchTaskCompletion(taskCompletion: Bool, taskId: String, taskListId: String, completion: @escaping(Result<String, NetworkError>) -> Void)
    func addTaskToTaskList(task: Task, taskListId: String, completion: @escaping(Result<TaskParent, NetworkError>) -> Void)
}

class TaskService: TaskServiceDelegate {
     
    func getTaskLists(completion: @escaping (Result<[TaskList], NetworkError>) -> Void) {
        RestAPIClient.getTaskLists(completion: completion)
    }
    
    func deleteTaskList(taskListId: String, completion: @escaping(Result<String, NetworkError>) -> Void) {
        RestAPIClient.deleteTaskList(taskListId: taskListId, completion: completion)
    }
    
    func addTaskList(taskList: TaskList, completion: @escaping (Result<String, NetworkError>) -> Void) {
        RestAPIClient.addTaskList(taskList: taskList, completion: completion)
    }
    
    func deleteTask(taskParentName: String, taskListId: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        RestAPIClient.deleteTask(taskParentName: taskParentName, taskListId: taskListId, completion: completion)
    }
    
    func patchTaskCompletion(taskCompletion: Bool, taskId: String, taskListId: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        RestAPIClient.patchTaskCompletion(taskCompletion: taskCompletion, taskId: taskId, taskListId: taskListId, completion: completion)
    }
    
    func addTaskToTaskList(task: Task, taskListId: String, completion: @escaping (Result<TaskParent, NetworkError>) -> Void) {
        RestAPIClient.addTaskToTaskList(task: task, taskListId: taskListId, completion: completion)
    }
}
