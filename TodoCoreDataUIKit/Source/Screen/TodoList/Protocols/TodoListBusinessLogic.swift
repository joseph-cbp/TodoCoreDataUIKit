//
//  TodoListBusinessLogic.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 18/07/25.
//

protocol TodoListBusinessLogic {
    func fetchTasks()
    func addTask(task: TodoItemDomain)
    func updateTask(task: TodoItemDomain)
}
