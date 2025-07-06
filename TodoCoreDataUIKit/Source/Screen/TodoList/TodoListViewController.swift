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
    
    init(/*provider: ProviderProtocol*/) {
//        viewModel = TodoListViewModel(context: provider.context)
        super.init(nibName: nil, bundle: nil)
        setupCycle()
    }
    
    func setupCycle() {
        let worker = TodoListWorker(coreDataProvider: CoreDataProvider.preview)
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
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Task", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createTask), for: .touchUpInside)
        return button
    }()
    
    private let titleField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter title..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        
        return textField
    }()
    
    private var detailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter detail..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        
        return textField
    }()
    
    lazy var formStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleField, detailField])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        viewModel.delegate = self
//        view = listTableView
//        viewModel.fetchTodos()
        interactor?.fetchTasks()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(formStackView)
        view.addSubview(addButton)
        view.addSubview(listTableView)
        
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            formStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            formStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            formStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            addButton.topAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: 16),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            listTableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 16),
            listTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
            
    }
    
    @objc
    func createTask() {
        let todo = TodoItemDomain(title: titleField.text ?? "", detail: detailField.text ?? "", createdAt: "")
        interactor?.addTask(task: todo)
        
    }
}

// MARK: Store (VIP)
extension TodoListViewController: TodoListDisplayLogic {
    func displayTasks(tasks: [TodoItemDomain]) {
        DispatchQueue.main.async {
            self.tasks = tasks
        }
        didUpdateTodoList()
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
//        return viewModel.todoItems.count
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
}



