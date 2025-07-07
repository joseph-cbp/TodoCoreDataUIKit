//
//  TodoListFlowDelegate.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 07/07/25.
//

import Foundation

protocol TodoListFlowDelegate: AnyObject {
    func presentNewTodoItem(interactor: TodoListInteractor)
}
