//
//  TodoListServiceProtocol.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 18/07/25.
//

protocol TodoListServiceProtocol {
    func fetchTasks(completion: @escaping (Result<[TodoItem], Error>) -> Void)
    
    func addTask(_ task: TodoItemDomain, completion: @escaping (Result<TodoItem, Error>) -> Void)
    
    func updateData(_ task: TodoItemDomain, completion: @escaping (Result<TodoItem, any Error>) -> Void)
}
