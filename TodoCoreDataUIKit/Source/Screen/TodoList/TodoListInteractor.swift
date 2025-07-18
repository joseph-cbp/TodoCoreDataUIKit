//
//  TodoListInteractor.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 18/07/25.
//

class TodoListInteractor: TodoListBusinessLogic {
    var presenter: TodoListPresentationLogic?
    var worker: TodoListServiceProtocol?
    
    func fetchTasks() {
        worker?.fetchTasks { result in
            switch result {
            case .success(let tasks):
                self.presenter?.presentTasks(tasks: tasks)
            case .failure(let error):
                self.presenter?.presentError(error.localizedDescription)
            }
        }
    }
    func addTask(task: TodoItemDomain) {
        worker?.addTask(task) { result in
            switch result {
            case .success:
                self.fetchTasks()
            case .failure(let error):
                self.presenter?.presentError(error.localizedDescription)
            }
        }
    }
    
    func updateTask(task: TodoItemDomain) {
        worker?.updateData(task) { result in
            switch result {
            case .success:
                self.fetchTasks()
            case .failure(let error):
                self.presenter?.presentError(error.localizedDescription)
            }
        }
    }
    
}
