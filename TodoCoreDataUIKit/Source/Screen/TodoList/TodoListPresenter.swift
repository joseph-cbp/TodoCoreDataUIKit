//
//  TodoListPresenter.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 18/07/25.
//

class TodoListPresenter: TodoListPresentationLogic {
    
    weak var viewController: TodoListDisplayLogic!
    
    func presentTasks(tasks: [TodoItem]) {
        let data: [TodoItemDomain] = tasks.map{ task in
            let formatDate = task.createdAt?.formatted(date: .abbreviated, time: .complete)
            return TodoItemDomain(id: task.id, title: task.title ?? "Unknown", detail: task.detail ?? "Unknown", createdAt: formatDate ?? "")
        }
        
        viewController.displayTasks(tasks: data)
    }
    
    func presentError(_ message: String) {
        viewController.displayError(message)
    }
}
