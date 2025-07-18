//
//  FlowController.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 07/07/25.
//

import UIKit
import CoreData

class FlowController {
    private var navigation: UINavigationController?
    var provider: ProviderProtocol?
    
    
    func start() -> UIViewController? {
        // TODO: Jogar para uma Factory
        let startViewController = TodoListViewController(flow: self)
        let worker = TodoListService(coreDataProvider: provider ?? CoreDataProvider(inMemory: false))
        let presenter = TodoListPresenter()
        let interactor = TodoListInteractor()
        presenter.viewController = startViewController
        interactor.presenter = presenter
        interactor.worker = worker
        startViewController.interactor = interactor
        
        self.navigation = UINavigationController(rootViewController: startViewController)
        return navigation
    }
    
    func back() {
        navigation?.dismiss(animated: true)
    }
}

extension FlowController: TodoListFlowDelegate {
    func presentNewTodoItem(interactor: TodoListInteractor) {
        let newTask = NewTaskViewController(mode: .add)
        newTask.interactor = interactor
        newTask.flow = self
        self.navigation?.present(newTask, animated: true)
    }
    
    func presentUpdateTodoItem(task: TodoItemDomain, interactor: TodoListInteractor) {
        let viewController = NewTaskViewController(mode: .update(task))
        viewController.interactor = interactor
        viewController.flow = self
        self.navigation?.present(viewController, animated: true)
    }
}
