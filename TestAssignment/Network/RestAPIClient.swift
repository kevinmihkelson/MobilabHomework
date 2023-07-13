//
//  RestAPIClient.swift
//  TestAssignment
//
//  Created by Kevin Mihkelson on 13.07.2023.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case BadURL
    case NoData
    case DecodingError
    case APIError(String)
}

class RestAPIClient {
    
    static func getRequest<T: Codable>(type: T.Type,
                                    route: APIRouter,
                                    completion: @escaping(Result<T, NetworkError>) -> Void) {
        AF.request(route).response { response in
            let result = response.result
            switch result {
            case .success(let data):
                guard let data = data else {
                    completion(.failure(.NoData))
                    return
                }
                guard let obj = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(.DecodingError))
                    return
                }
                
                completion(.success(obj))
            case .failure(let error):
                completion(.failure(.APIError(error.localizedDescription)))
            }
        }
    }
    
    static func deleteRequest(
        route: APIRouter,
        completion: @escaping(Result<String, NetworkError>) -> Void) {
            AF.request(route).response { response in
                let result = response.result
                switch result {
                case .success:
                    completion(.success("Successfully deleted object"))
                case .failure(let error):
                    completion(.failure(.APIError(error.localizedDescription)))
                }
            }
        }
    
    static func deleteTaskList(taskListId: String, completion: @escaping(Result<String, NetworkError>) -> Void) {
        return deleteRequest(route: APIRouter.deleteTaskList(taskListId: taskListId), completion: completion)
    }
    
    static func deleteTask(taskParentName: String, taskListId: String, completion: @escaping(Result<String, NetworkError>) -> Void) {
        return deleteRequest(route: APIRouter.deleteTask(taskParentName: taskParentName, taskListId: taskListId), completion: completion)
    }
    
    static func addTaskToTaskList(task: Task, taskListId: String, completion: @escaping(Result<TaskParent, NetworkError>) -> Void) {
        AF.request(APIRouter.addTaskToTaskList(taskListId: taskListId).urlPath, method: .post, parameters: task, encoder: JSONParameterEncoder.default).response { response in
            let result = response.result
            switch result {
            case .success(let data):
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
                        if let taskParentName = jsonResponse?["name"] {
                            let newTaskParent = TaskParent(name: taskParentName, task: task)
                            completion(.success(newTaskParent))
                        }
                    } catch {
                        completion(.failure(.DecodingError))
                    }
                } else {
                    completion(.failure(.NoData))
                }
            case .failure(let error):
                completion(.failure(.APIError(error.localizedDescription)))
            }
        }
    }
    
    static func patchTaskCompletion(taskCompletion: Bool, taskId: String, taskListId: String, completion: @escaping(Result<String, NetworkError>) -> Void) {
        let parameters: [String: Bool] = ["completed": taskCompletion]
        AF.request(APIRouter.patchTaskCompletion(taskId: taskId, taskListId: taskListId).urlPath, method: .patch, parameters: parameters, encoder: JSONParameterEncoder.default).response { response in
            let result = response.result
            switch result {
            case .success:
                completion(.success("Successfully updated task completion"))
            case .failure(let error):
                completion(.failure(.APIError(error.localizedDescription)))
            }
        }
    }
    
    static func addTaskList(taskList: TaskList, completion: @escaping(Result<String, NetworkError>) -> Void) {
        AF.request(APIRouter.addTaskList(taskListId: taskList.id).urlPath, method: .put, parameters: taskList, encoder: JSONParameterEncoder.default).response { response in
            let result = response.result
            switch result {
            case .success:
                completion(.success("Successfully added a tasklist"))
            case .failure(let error):
                completion(.failure(.APIError(error.localizedDescription)))
            }
        }
    }
    
    static func getTaskLists(completion: @escaping(Result<[TaskList], NetworkError>) -> Void) {
        AF.request(APIRouter.getTaskLists).response { response in
            let result = response.result
            switch result {
            case .success(let data):
                do {
                    if let data {
                        let firebaseTaskList = try JSONDecoder().decode([String: FirebaseTaskList].self, from: data)
                        let taskLists = firebaseTaskList.map { firebaseTask in
                            let taskParents = firebaseTask.value.tasks?.map { TaskParent(name: $0.key, task: $0.value) } ?? []
                            return TaskList(id: firebaseTask.key, title: firebaseTask.value.title, tasks: taskParents)
                        }
                        completion(.success(taskLists))
                    }
                } catch {
                    completion(.failure(.DecodingError))
                }
            case .failure(let error):
                completion(.failure(.APIError(error.localizedDescription)))
            }
        }
    }
}
