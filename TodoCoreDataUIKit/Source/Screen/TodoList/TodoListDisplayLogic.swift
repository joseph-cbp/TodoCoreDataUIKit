//
//  TodoListDisplayLogic.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 01/07/25.
//

import Foundation

protocol TodoListDisplayLogic: AnyObject {
    func displayTasks(tasks: [TodoItemDomain])
    func displayError(_ message: String)
}

protocol TodoListBusinessLogic {
    func fetchTasks()
    func addTask(task: TodoItemDomain)
    func updateTask(task: TodoItemDomain)
}

protocol TodoListPresentationLogic {
    func presentTasks(tasks: [TodoItem])
    func presentError(_ message: String)
}

protocol TodoListServiceProtocol {
    func fetchTasks(completion: @escaping (Result<[TodoItem], Error>) -> Void)
    
    func addTask(_ task: TodoItemDomain, completion: @escaping (Result<TodoItem, Error>) -> Void)
    
    func updateData(_ task: TodoItemDomain, completion: @escaping (Result<TodoItem, any Error>) -> Void)
}

import CoreData
class TodoListWorker: TodoListServiceProtocol {
    
    let coreDataProvider: ProviderProtocol
    
    init(coreDataProvider: ProviderProtocol){
        self.coreDataProvider = coreDataProvider
    }
    
    func fetchTasks(completion: @escaping (Result<[TodoItem], Error>) -> Void) {
        let fetchRequest: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        
        DispatchQueue.main.async { [weak self] in
            do {
                let tasks = try self?.coreDataProvider.context.fetch(fetchRequest)
                completion(.success(tasks ?? []))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func addTask(_ task: TodoItemDomain, completion: @escaping (Result<TodoItem, any Error>) -> Void) {
        
        let context = self.coreDataProvider.context
        
        DispatchQueue.main.async {
            do {
                let newTodo = TodoItem(context: context)
                newTodo.title = task.title
                newTodo.detail = task.detail
                newTodo.createdAt = Date()
                
                try context.save()
                completion(.success(newTodo))
            } catch {
                context.rollback()
                completion(.failure(error))
            }
        }
    }
    
    func updateData(_ task: TodoItemDomain, completion: @escaping (Result<TodoItem, any Error>) -> Void) {
        let context = self.coreDataProvider.context
        let fetchRequest: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        
        do {
            let tasks = try context.fetch(fetchRequest)
            guard let toUpdate = tasks.first(where:{ todoItem in
                todoItem.title == task.title
            }) else {
                
                let error = NSError(domain: "Todo error", code: 404, userInfo: [NSLocalizedDescriptionKey : "Could Not Find"])
                completion(.failure(error))
                return
            }
            
            toUpdate.title = task.title
            toUpdate.detail = task.detail
            try context.save()
            
            DispatchQueue.main.async {
                completion(.success(toUpdate))
            }
            
        } catch {
            context.rollback()
            completion(.failure(error))
        }
    }
}

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
