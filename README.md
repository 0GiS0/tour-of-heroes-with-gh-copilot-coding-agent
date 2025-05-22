# Tour of Heroes API

A REST API for managing superheroes, implemented with Node.js and TypeScript. This project provides a simple backend for the "Tour of Heroes" application with endpoints to fetch, create, update, and delete hero data.

## 📁 Project Structure

```
.
├── .devcontainer/   # Dev Container configuration
├── .github/         # GitHub Actions workflows
├── src/
│   ├── config/      # Application configuration
│   ├── controllers/ # Request handlers
│   ├── middlewares/ # Express middlewares
│   ├── models/      # Data models and interfaces
│   ├── routes/      # API route definitions
│   ├── services/    # Business logic
│   ├── utils/       # Utility functions
│   └── index.ts     # Application entry point
├── eslint.config.js # ESLint configuration
├── package.json     # Project dependencies
└── tsconfig.json    # TypeScript configuration
```

## 🚀 Installation and Prerequisites

### Prerequisites

- Node.js (v22+)
- npm (v6+)
- MongoDB (for local development without containers)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/0GiS0/tour-of-heroes-with-gh-copilot-coding-agent.git
cd tour-of-heroes-with-gh-copilot-coding-agent
```

2. Install dependencies:
```bash
npm install
```

## 🛠️ Basic Usage

### Development

To run the application in development mode with hot reloading:
```bash
npm run dev
```

### Building and Running for Production

1. Build the application:
```bash
npm run build
```

2. Run the application:
```bash
npm start
```

### Linting and Formatting

Execute the linter:
```bash
npm run lint
```

Automatically fix linting issues:
```bash
npm run lint:fix
```

Format code with Prettier:
```bash
npm run format
```

## 📦 Technologies Used

- **TypeScript**: Strongly typed programming language that builds on JavaScript
- **Express**: Fast, minimalist web framework for Node.js
- **MongoDB**: NoSQL document database
- **Docker**: Containerization platform
- **ESLint & Prettier**: Code quality and formatting tools
- **GitHub Actions**: Continuous Integration workflows

## 🤖 About GitHub Copilot and Coding Agent

This repository was created with the assistance of GitHub Copilot and its Coding agent. GitHub Copilot served as an AI pair programmer to:

- Generate initial project structure and boilerplate code
- Suggest implementation details for controllers, services, and models
- Help design the API routes and data schemas
- Assist with configuration of Docker, ESLint, and other tooling

The Coding agent facilitated structured AI assistance directly within pull requests, helping to implement features, fix bugs, and improve code quality throughout the development process.

## 👥 Contribution

Contributions to this project are welcome! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Please ensure your code follows the project's coding standards by running linters and formatters before submitting.

## ⚡ Continuous Integration

This project uses GitHub Actions to implement a Continuous Integration (CI) workflow. The workflow runs automatically on each push to the main branch and on pull requests to main.

The CI workflow performs the following operations:
- Repository checkout
- Node.js setup
- Dependency installation
- Linter execution
- Project build
- Tests execution (when implemented)

You can check the status of CI executions in the "Actions" tab of the repository.

## 🐳 Development with Dev Containers

This project is configured to use Dev Containers with Visual Studio Code, allowing development inside a containerized environment with all necessary tools pre-installed.

### Prerequisites for Dev Containers

- [Visual Studio Code](https://code.visualstudio.com/)
- [Remote - Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker Desktop](https://www.docker.com/products/docker-desktop)

### Starting the Dev Container

1. Open the project in Visual Studio Code
2. When the notification "Folder contains a Dev Container configuration file" appears, click "Reopen in Container"
   - Or use the command `Remote-Containers: Reopen in Container` from the command palette (F1)

### Included Features

- 🖥️ Preconfigured Node.js/TypeScript environment (Node.js 22 with Debian Bookworm)
- 🗃️ MongoDB database service (version 8.0)
- 🧩 Recommended development extensions pre-installed:
  - TypeScript and JavaScript (linting, formatting)
  - MongoDB support
  - Docker tools
  - Git enhancements (GitLens)
- ⚙️ Automatic formatting and linting configuration

## 📝 License

This project is licensed under the ISC License - see the `package.json` file for details.
