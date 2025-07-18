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
