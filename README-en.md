# Tour of Heroes API

*[🇪🇸 Leer en español](./README.md)*

A REST API for managing superheroes, implemented with Node.js and TypeScript. This project provides a simple backend for the "Tour of Heroes" application with endpoints to get, create, update, and delete hero data.

## Example repository from my YouTube video

This repo was created as part of my YouTube video [Assign tasks to GitHub Copilot like one more dev 🧑‍💻 | Copilot Coding Agent](https://youtu.be/UiJj7pjTN_Y):

[![Tour of Heroes API - YouTube Video](docs/images/Cómo%20usar%20el%20nuevo%20Coding%20Agent%20de%20GitHub%20Copilot.png)](https://youtu.be/UiJj7pjTN_Y)

## 📋 Summary

- **Type**: REST API
- **Technologies**: TypeScript, Express, MongoDB
- **Platforms**: Docker, Kubernetes, Azure (AKS)
- **Status**: In development

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/0GiS0/tour-of-heroes-with-gh-copilot-coding-agent.git
cd tour-of-heroes-with-gh-copilot-coding-agent

# Install dependencies
npm install

# Configure MongoDB database
# Make sure you have MongoDB running on localhost:27017 or configure the MONGODB_URI environment variable

# Load initial data into the database
npm run seed

# Start in development mode
npm run dev
```

For advanced startup options (Docker, Kubernetes, etc.), check the [installation documentation](./docs/installation.md).

## 📦 Main Features

- Complete CRUD for managing heroes
- Data validation and error handling
- Integrated API documentation
- Support for multiple development environments
- Complete CI/CD configuration

## 📚 Documentation

The complete project documentation is organized in the [docs folder](./docs/README.md).

### Getting Started Guides

- [Project Structure](./docs/project-structure.md)
- [Installation and Requirements](./docs/installation.md)
- [Basic Usage](./docs/basic-usage.md)

### Development Environments

- [Docker Development](./docs/docker-development.md)
- [Dev Containers Development](./docs/dev-containers.md)
- [Kubernetes Development](./docs/kubernetes-development.md)

### Operations and Deployment

- [Continuous Integration](./docs/ci-cd.md)
- [Terraform for AKS](./terraform/README.md)

### Technology and Contribution

- [Technologies Used](./docs/technologies.md)
- [GitHub Copilot and Coding Agent](./docs/github-copilot.md)
- [Contribution Guide](./docs/contributing.md)
- [License](./docs/license.md)

## 👥 Contributing

Contributions to this project are welcome! Check our [contribution guide](./docs/contributing.md) to get started.

## 📝 License

This project is licensed under the ISC License. Check the [license file](./docs/license.md) for more details.