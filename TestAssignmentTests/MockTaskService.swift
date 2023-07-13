//
//  MockTaskService.swift
//  TestAssignmentTests
//
//  Created by Kevin Mihkelson on 13.07.2023.
//

import Foundation
@testable import TestAssignment

class MockTaskService: TaskServiceDelegate {
    var mockedTaskLists: [TestAssignment.TaskList] = [
        TaskList(id: "taskList1", title: "Mock1", tasks: [TaskParent(name: "mockparent1", task: Task(id: "Task1", content: "mock1", completed: false)), TaskParent(name: "mockparent3", task: Task(id: "Task3", content: "mock2", completed: false))]),
        TaskList(id: "taskList2", title: "Mock2", tasks: [TaskParent(name: "mockparent2", task: Task(id: "Task2", content: "mock2", completed: false))]),
    ]
    
    func getTaskLists(completion: @escaping (Result<[TestAssignment.TaskList], TestAssignment.NetworkError>) -> Void) {
        // Simulate a successful response with mocked task lists
        completion(.success(mockedTaskLists))
    }
    
    func deleteTaskList(taskListId: String, completion: @escaping (Result<String, TestAssignment.NetworkError>) -> Void) {
        // Simulate a successful deletion with mocked success message
        completion(.success("mockedSuccessMessage"))
    }
    
    func addTaskList(taskList: TestAssignment.TaskList, completion: @escaping (Result<String, TestAssignment.NetworkError>) -> Void) {
        // Simulate a successful addition with mocked success message
        completion(.success("mockedSuccessMessage"))
    }
    
    func deleteTask(taskParentName: String, taskListId: String, completion: @escaping (Result<String, TestAssignment.NetworkError>) -> Void) {
        // Simulate a successful deletion with mocked success message
        completion(.success("mockedSuccessMessage"))
    }
    
    func patchTaskCompletion(taskCompletion: Bool, taskId: String, taskListId: String, completion: @escaping (Result<String, TestAssignment.NetworkError>) -> Void) {
        // Simulate a successful patch with mocked success message
        completion(.success("mockedSuccessMessage"))
    }
    
    func addTaskToTaskList(task: TestAssignment.Task, taskListId: String, completion: @escaping (Result<TestAssignment.TaskParent, TestAssignment.NetworkError>) -> Void) {
        // Simulate a successful addition with mocked task parent
        let taskParent = TestAssignment.TaskParent(name: "xdd", task: task)
        completion(.success(taskParent))
    }
}
