---
mode: 'agent'
tools: ['githubRepo', 'codebase']
description: 'Move modules from this repository to the specified GitHub repository.'
---

Your task is to move ${input:module_name} from this repository to #githubRepo https://github.com/0GiS0/terraform-modules.
You have to check if the module already exists in the target repository. If it does, you should not create a new one, but rather use the existing module.
If the module does not exist you should open a pull request to the target repository with the new module.
