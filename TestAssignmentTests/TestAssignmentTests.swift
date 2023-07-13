//
//  TestAssignmentTests.swift
//  TestAssignmentTests
//
//  Created by Kevin Mihkelson on 12.07.2023.
//

import XCTest
import Alamofire
import Foundation
@testable import TestAssignment

final class TestAssignmentTests: XCTestCase {
    var viewModel: TaskViewModel!
    
    func testFetchingTasks() {
        // Given
        let mockTaskService = MockTaskService()
        viewModel = TaskViewModel(taskService: mockTaskService)
        
        // When
        viewModel.getTaskLists()
        
        // Then
        XCTAssertNotNil(viewModel.taskLists)
        XCTAssertEqual(viewModel.taskLists.count, mockTaskService.mockedTaskLists.count)
        XCTAssertEqual(viewModel.taskLists[0].id, mockTaskService.mockedTaskLists[0].id)
    }
    
    func testDeletingTaskList() {
        // Given
        let mockTaskService = MockTaskService()
        viewModel = TaskViewModel(taskService: mockTaskService)
        viewModel.getTaskLists()
        
        // When
        viewModel.deleteTaskList(taskListId: "taskList2")
        
        // Then
        XCTAssert(viewModel.taskLists.count == 1)
        XCTAssert(viewModel.taskLists[0].id == "taskList1")
    }
    
    func testAddTaskList() {
        // Given
        let mockTaskService = MockTaskService()
        viewModel = TaskViewModel(taskService: mockTaskService)
        viewModel.getTaskLists()
        
        // When
        let taskList = TaskList(id: "taskList3", title: "title", tasks: [])
        viewModel.addTaskList(taskList: taskList)
        
        // Then
        XCTAssert(viewModel.taskLists.count == 3)
        XCTAssert(viewModel.taskLists.contains(where: { list in
            list.id == "taskList3"
        }))
    }
    
    func testPatchTaskCompletion() {
        // Given
        let mockTaskService = MockTaskService()
        viewModel = TaskViewModel(taskService: mockTaskService)
        viewModel.getTaskLists()
        
        // When
        viewModel.patchTaskCompletion(taskCompletion: true, taskId: "mockparent1", taskListId: "taskList1")
        
        // Then
        let taskList = viewModel.taskLists.first { list in
            list.id == "taskList1"
        }
        let task = taskList?.tasks.first(where: { parent in
            parent.name == "mockparent1"
        })
        XCTAssert(task != nil)
        XCTAssert(task?.task.completed == true)
    }
    
    func testAddTaskToTaskList() {
        // Given
        let mockTaskService = MockTaskService()
        viewModel = TaskViewModel(taskService: mockTaskService)
        viewModel.getTaskLists()
        
        // When
        viewModel.addTaskToTaskList(task: Task(id: "task6", content: "test", completed: false), taskListId: "taskList1")
        
        XCTAssert(viewModel.taskLists.first(where: { list in
            list.id == "taskList1"
        })!.tasks.count == 3)
    }
}
