//
//  APIRouter.swift
//  TestAssignment
//
//  Created by Kevin Mihkelson on 13.07.2023.
//

import Foundation
import Alamofire

public enum APIRouter: URLRequestConvertible {
    
case getTaskLists
case deleteTaskList(taskListId: String)
case addTaskList(taskListId: String)
case deleteTask(taskParentName: String, taskListId: String)
case patchTaskCompletion(taskId: String, taskListId: String)
    case addTaskToTaskList(taskListId: String)
    
    var urlPath: String {
        switch self {
        case .getTaskLists:
            return "https://testassignment-b0084-default-rtdb.europe-west1.firebasedatabase.app/taskLists.json"
        case .deleteTaskList(let taskListId):
            return "https://testassignment-b0084-default-rtdb.europe-west1.firebasedatabase.app/taskLists/\(taskListId).json"
        case .addTaskList(let taskListId):
            return "https://testassignment-b0084-default-rtdb.europe-west1.firebasedatabase.app/taskLists/\(taskListId).json"
        case .deleteTask(let taskParentName, let taskListId):
            return "https://testassignment-b0084-default-rtdb.europe-west1.firebasedatabase.app/taskLists/\(taskListId)/tasks/\(taskParentName).json"
        case .patchTaskCompletion(let taskId, let taskListId):
            return "https://testassignment-b0084-default-rtdb.europe-west1.firebasedatabase.app/taskLists/\(taskListId)/tasks/\(taskId).json"
        case .addTaskToTaskList(let taskListId):
            return "https://testassignment-b0084-default-rtdb.europe-west1.firebasedatabase.app/taskLists/\(taskListId)/tasks/.json"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getTaskLists:
            return .get
        case .deleteTaskList:
            return .delete
        case .addTaskList:
            return .put
        case .deleteTask:
            return .delete
        case .patchTaskCompletion:
            return .patch
        case .addTaskToTaskList:
            return .post
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try urlPath.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        return urlRequest
    }
}
