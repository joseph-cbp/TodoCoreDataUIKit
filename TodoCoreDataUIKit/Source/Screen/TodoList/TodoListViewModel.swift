//
//  TodoListViewModel.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 27/06/25.
//

import Foundation
import CoreData

class TodoListViewModel {
    var context: NSManagedObjectContext
    var delegate: TodoListViewModelDelegate?
    private(set) var todoItems: [TodoItem] = []
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    
    func fetchTodos() {
        let fetchRequest = TodoItem.fetchRequest()
        do{
            let itens: [TodoItem] = try context.fetch(fetchRequest)
            self.todoItems = itens
            delegate?.didUpdateTodoList()
            print("📦 \(todoItems.count) itens carregados do Core Data.")
            dump(todoItems[0].detail)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func saveTodo(title: String, description: String){
        let todo = TodoItem(context: context)
        todo.title = title
        todo.detail = description
        
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
    
}
