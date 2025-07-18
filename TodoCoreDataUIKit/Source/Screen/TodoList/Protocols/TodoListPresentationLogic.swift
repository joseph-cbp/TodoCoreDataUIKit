//
//  TodoListPresentationLogic.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 18/07/25.
//

protocol TodoListPresentationLogic {
    func presentTasks(tasks: [TodoItem])
    func presentError(_ message: String)
}
