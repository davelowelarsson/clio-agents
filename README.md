# Clio Agents Repository

This repository contains a collection of GPTScript agents designed to extend the functionality of Clio, a versatile tool for interacting with various services like Kubernetes, AWS, GCP, GitHub, and more. Each agent in this repository is tailored for a specific task, such as managing Argo Rollouts, ArgoCD configurations, or integrating with GoReleaser.

## Overview

Clio is built with extensibility in mind, allowing users to add custom agents to enhance its capabilities.
Read more about Clio here - [Clio repository](https://github.com/gptscript-ai/clio?tab=readme-ov-file#example-custom-agent---goreleaser)

This repository hosts agents for:

- **Argo Rollouts**: Automates the management of Argo Rollouts using the Argo Rollouts CLI. ([`argo-rollouts.gpt`](argo-rollouts.gpt))
- **ArgoCD**: Facilitates the management of ArgoCD applications using the ArgoCD CLI. ([`argocd.gpt`](argocd.gpt))

## Getting Started

To use these agents with Clio, follow these steps:

1. Clone this repository to your local machine.
2. Copy the desired `.gpt` files to your Clio agents directory (optionaly using the script). The path varies by operating system:
   - **macOS**: `~/Library/Application Support/clio/agents`
   - **Linux**: `~/.config/clio/agents`
3. Run Clio and reference the agent by its name to start using its functionality.
