//
//  TodoListViewController.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 27/06/25.
//

import UIKit

class TodoListViewController: UIViewController {
    
    var viewModel: TodoListViewModel
    
    init(provider: ProviderProtocol) {
        viewModel = TodoListViewModel(context: provider.context)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var listTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        view = listTableView
        viewModel.fetchTodos()
    }
}


extension TodoListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath) as? TodoCell else { return UITableViewCell()}
        
        let todo = viewModel.todoItems[indexPath.row]
        cell.configure(with: todo)
        return cell
    }
}

extension TodoListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}


extension TodoListViewController: TodoListViewModelDelegate{
    func didUpdateTodoList() {
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }
    }
    
    
}
