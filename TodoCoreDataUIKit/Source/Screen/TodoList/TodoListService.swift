//
//  TodoListService.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 18/07/25.
//

import CoreData
class TodoListService: TodoListServiceProtocol {
    
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
                newTodo.id = UUID()
                
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
                todoItem.id == task.id
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
