

# Todo List App
## English

### Project Description

This project is a **Proof of Concept (PoC)** for a Todo List application developed to learn and apply concepts of **CoreData** and the **VIP Architecture** (View-Interactor-Presenter) using **UIKit**. The app allows users to create, view, update, and delete tasks through a simple and functional TableView-based interface.

The main focus of the project was to explore the integration and configuration of CoreData for persistent data management, implement the VIP architecture for code organization, and experiment with advanced features such as data migrations and swipe actions in a TableView.

### Technologies Used

- **Language**: Swift
- **Framework**: UIKit
- **Data Persistence**: CoreData
- **Architecture**: VIP (View-Interactor-Presenter)
- **Platform**: iOS

### Features

- Create, read, update, and delete tasks (CRUD operations).
- User interface based on TableView with support for **Swipe Actions** for quick interactions.
- Data persistence using CoreData.
- Support for data migrations to handle changes in the CoreData model.

### Learnings

During the development of this project, the following skills were acquired:

- Initial setup of **CoreData** for use in an iOS project.
- Creation and management of a data model for CoreData.
- Implementation of **CRUD** operations (Create, Read, Update, Delete) with CoreData.
- Project organization using the **VIP Architecture**, promoting separation of concerns.
- Creation of **data migrations** to handle changes in the CoreData model.
- Mapping changes to ensure compatibility during migrations.
- Configuration of **Swipe Actions** in a TableView for dynamic user interactions.

### How to Run the Project

1. **Prerequisites**:
   - Xcode (version 12.0 or higher).
   - Compatible iOS device or simulator.

2. **Steps**:
   - Clone this repository: `git clone https://github.com/joseph-cbp/TodoCoreDataUIKit.git`.
   - Open the `.xcodeproj` file in Xcode.
   - Build and run the project on a simulator or iOS device.

### Project Structure

- **`CoreData`**: Contains the CoreData stack configuration and data model.
- **`VIP`**: Organized in layers (View, Interactor, Presenter) for separation of concerns.
- **`Views`**: User interface implementation with UIKit, including the TableView with Swipe Actions.
- **`Migrations`**: Configurations and mappings for CoreData migrations.

### Contributions

This is a learning project, but suggestions and improvements are welcome! Feel free to open issues or submit pull requests.


---
## Português

### Descrição do Projeto

Este projeto é uma **Proof of Concept (PoC)** de um aplicativo de lista de tarefas (Todo List) desenvolvido com o objetivo de aprender e aplicar conceitos de **CoreData** e a **Arquitetura VIP** (View-Interactor-Presenter) utilizando **UIKit**. O aplicativo permite criar, visualizar, atualizar e excluir tarefas, com uma interface simples e funcional baseada em uma TableView.

O foco principal do projeto foi explorar a integração e configuração do CoreData para gerenciamento de dados persistentes, implementar a Arquitetura VIP para organização do código e experimentar funcionalidades avançadas, como migrações de dados e ações de swipe em uma TableView.

### Tecnologias Utilizadas

- **Linguagem**: Swift
- **Framework**: UIKit
- **Persistência de Dados**: CoreData
- **Arquitetura**: VIP (View-Interactor-Presenter)
- **Plataforma**: iOS

### Funcionalidades

- Criação, leitura, atualização e exclusão de tarefas (operações CRUD).
- Interface de usuário baseada em TableView com suporte a **Swipe Actions** para ações rápidas.
- Persistência de dados utilizando CoreData.
- Suporte a migrações de dados para alterações no modelo do CoreData.

### Aprendizados

Durante o desenvolvimento deste projeto, foram adquiridos os seguintes conhecimentos:

- Configuração inicial do **CoreData** para uso em um projeto iOS.
- Criação e gerenciamento de um modelo de dados para o CoreData.
- Implementação de operações **CRUD** (Create, Read, Update, Delete) com CoreData.
- Organização do projeto utilizando a **Arquitetura VIP**, promovendo separação de responsabilidades.
- Criação de **migrações de dados** para lidar com alterações no modelo do CoreData.
- Mapeamento de mudanças para garantir a compatibilidade durante as migrações.
- Configuração de **Swipe Actions** em uma TableView para interações dinâmicas com o usuário.

### Como Executar o Projeto

1. **Pré-requisitos**:
   - Xcode (versão 12.0 ou superior).
   - Dispositivo iOS ou simulador compatível.

2. **Passos**:
   - Clone este repositório: `git clone https://github.com/joseph-cbp/TodoCoreDataUIKit.git`.
   - Abra o arquivo `.xcodeproj` no Xcode.
   - Compile e execute o projeto no simulador ou dispositivo iOS.

### Estrutura do Projeto

- **`CoreData`**: Contém a configuração do stack do CoreData e o modelo de dados.
- **`VIP`**: Organização em camadas (View, Interactor, Presenter) para separação de responsabilidades.
- **`Views`**: Implementação da interface de usuário com UIKit, incluindo a TableView com Swipe Actions.
- **`Migrations`**: Configurações e mapeamentos para migrações do CoreData.

### Contribuições

Este é um projeto de aprendizado, mas sugestões e melhorias são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.
