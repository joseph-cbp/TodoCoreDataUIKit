//
//  TodoListViewController.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 27/06/25.
//

import UIKit

class TodoListViewController: UIViewController {
    
//    var viewModel: TodoListViewModel
    var tasks: [TodoItemDomain] = []
    var interactor: TodoListInteractor?
    private weak var flow: TodoListFlowDelegate?
    
    init(flow: TodoListFlowDelegate){
        super.init(nibName: nil, bundle: nil)
        self.flow = flow
//        setupCycle()
    }
    
    func setupCycle() {
        let worker = TodoListService(coreDataProvider: CoreDataProvider.preview)
        let presenter = TodoListPresenter()
        let interactor = TodoListInteractor()
        presenter.viewController = self
        interactor.presenter = presenter
        interactor.worker = worker
        self.interactor = interactor
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
    
    private let newTaskButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Task", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentNewTaskView), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor?.fetchTasks()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(newTaskButton)
        view.addSubview(listTableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newTaskButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            newTaskButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            listTableView.topAnchor.constraint(equalTo: newTaskButton.bottomAnchor, constant: 16),
            listTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
            
    }
    
    @objc
    func presentNewTaskView() {
        if let interactor = interactor{
            flow?.presentNewTodoItem(interactor: interactor)
        }
    }
}

// MARK: Store (VIP)
extension TodoListViewController: TodoListDisplayLogic {
    func displayTasks(tasks: [TodoItemDomain]) {
        DispatchQueue.main.async { [weak self] in
            self?.tasks = tasks
            self?.listTableView.reloadData()
        }
    }
    
    func displayError(_ message: String) {
        print(message)
    }
    
    
}

// MARK: ViewModelDelegate

extension TodoListViewController: TodoListViewModelDelegate{
    func didUpdateTodoList() {
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }
    }
    
    
}

// MARK: TableView DataSource
extension TodoListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath) as? TodoCell else { return UITableViewCell()}
        
//        let todo = viewModel.todoItems[indexPath.row]
        let todo = tasks[indexPath.row]
        cell.configure(with: todo)
        return cell
    }
}

// MARK: TableView UI
extension TodoListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let flow = flow, let interactor = interactor else { return nil }
        let updateAction = UIContextualAction(style: .normal, title: "Update") { [weak self] (_, _, completion) in
            guard let self = self else {
                completion(false)
                return
            }
            
            flow.presentUpdateTodoItem(task: self.tasks[indexPath.row], interactor: interactor)
            completion(true)
        }
        updateAction.image = UIImage(systemName: "square.and.arrow.up")
        updateAction.backgroundColor = .systemBlue
        
        let config =  UISwipeActionsConfiguration(actions: [updateAction])
        
        return config
    }
}

