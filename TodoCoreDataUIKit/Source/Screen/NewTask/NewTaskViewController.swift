//
//  NewTaskViewController.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 07/07/25.
//

import UIKit

enum TaskMode {
    case add
    case update(TodoItemDomain)
}

class NewTaskViewController: UIViewController {
    
    weak var flow: FlowController?
    weak var interactor: TodoListInteractor?
    private var mode: TaskMode
    
    init(flow: FlowController? = nil, interactor: TodoListInteractor? = nil, mode: TaskMode) {
        self.flow = flow
        self.interactor = interactor
        self.mode = mode
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    private let titleField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let detailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Details"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
        
        return button
    }()
    
    lazy var formStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleField, detailField])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(formStack)
        view.addSubview(actionButton)
        view.backgroundColor = .gray
        configureMode()
        setupConstraints()
    }
    
    private func configureMode() {
        switch self.mode {
        case .add:
            actionButton.setTitle("Add Task", for: .normal)
            actionButton.backgroundColor = .systemGreen
            
        case .update(let todo):
            actionButton.setTitle("Update", for: .normal)
            actionButton.backgroundColor = .systemBlue
            populateFields(with: todo)
        }
    }
    
    private func populateFields(with todo: TodoItemDomain){
        self.titleField.text = todo.title
        self.detailField.text = todo.detail
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            formStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            formStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            formStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            actionButton.topAnchor.constraint(equalTo: formStack.bottomAnchor, constant: 24),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
            
    }
    
    @objc
    func handleAction() {
        guard let title = titleField.text, !title.isEmpty else {
            print("Title cannot be empty")
            return
        }
        switch self.mode {
        case .add:
            createAction()
        case .update(let todoItemDomain):
            dump(todoItemDomain)
            updateAction(at: todoItemDomain)
        }
    }
    
    private func createAction(){
        let todo = TodoItemDomain(id: nil, title: titleField.text ?? "", detail: detailField.text ?? "", createdAt: "")
        
        interactor?.addTask(task: todo)
        flow?.back()
    }
    
    private func updateAction(at todo: TodoItemDomain){
        var todoToUpdate = todo
        todoToUpdate.title = titleField.text ?? ""
        todoToUpdate.detail = detailField.text ?? ""
        interactor?.updateTask(task: todoToUpdate)
        flow?.back()
    }
}
