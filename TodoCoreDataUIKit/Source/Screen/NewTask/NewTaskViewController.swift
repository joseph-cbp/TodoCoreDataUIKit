//
//  NewTaskViewController.swift
//  TodoCoreDataUIKit
//
//  Created by Joseph Pereira on 07/07/25.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    weak var flow: FlowController?
    weak var interactor: TodoListInteractor?
        
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
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Task", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createTask), for: .touchUpInside)
        
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
        view.addSubview(addButton)
        view.backgroundColor = .red
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            formStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            formStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            formStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            addButton.topAnchor.constraint(equalTo: formStack.bottomAnchor, constant: 24),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
            
    }
    
    @objc
    func createTask() {
        let todo = TodoItemDomain(title: titleField.text ?? "", detail: detailField.text ?? "", createdAt: "")
        interactor?.addTask(task: todo)
        flow?.back()
        
        
    }
}
