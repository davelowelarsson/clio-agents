Extending
Agents
Clio is composed of multiple internal agents. There are several built-in agents that provide functionality for interacting with Kubernetes, AWS, GCP, GitHub, etc., but you can easily add your own agents to extend the functionality of Clio. The built-in agents are located in the agents directory, with each file being a separate agent. To create a custom agent, you must write a new GPTScript and place it in the $XDG_CONFIG_HOME/clio/agents directory.

Operating System	Custom Agent Path
macOS	~/Library/Application Support/clio/agents
Linux	~/.config/clio/agents

Custom Agent
A custom agent is any GPTScript with the requirement that it minimally must contain the following lines

chat: true
context: github.com/gptscript-ai/clio/context
You can refer to the GPTScript documentation for all the capabilities of GPTScripts, but for now the below example is typically all you need to know.

Example Custom Agent - GoReleaser
For this example, we will add a custom agent that is specialized for GoReleaser 2. We will create a file called goreleaser.gpt. The finished example is available in the examples directory.

The GPTScript starts with a metadata block that defines the name of the agent, a description, and the required context and chat fields. It is then followed by the prompt that will tell Clio how to behave when this agent is invoked.

Name: GoReleaser
Description: Agent for GoReleaser 2 using the goreleaser CLI
Chat: true
Context: github.com/gptscript-ai/clio/context

You are an expert at goreleaser. You can run the goreleaser CLI and help manage the goreleaser config file.

Rules:
1. Before changing the config, always show goreleaser config to the user for confirmation. After they agree, then write to disk.
2. Make sure "version: 2" line is always in the goreleaser config.
3. If the user asks to build, do a snapshot build.
4. Always search the internet for relevant information when asked a question or to do a task.

First ask the user what would they like to do with regards to GoReleaser.
To test this agent out you can run clio goreleaser.gpt. After testing the agent, you can modify the text if you don't like the exhibited behavior. There is no defined format for the prompt. The fact that the example has the structure with "Rules" in it is just a convention but not technically required.

To make the agent even more useful, you can extend the agent to have dynamic contextual information. To do this, we are going to add an additional "context tool" to the agent. Context tools add capabilities to the agent by prepending the output of the tool to the prompt.

In the below example, we add a new line for context: additional-environment to the metadata block. We then define the additional-environment context tool. This tool will show the user the current goreleaser version, the JSONSchema for the goreleaser config file, and the help output for the goreleaser CLI and the build subcommand. It will also show the user the current goreleaser config file if it exists.

Name: GoReleaser
Description: Agent for GoReleaser 2 using the goreleaser CLI
Chat: true
Context: github.com/gptscript-ai/clio/context
Context: additional-environment

You are an expert at goreleaser. You can run the goreleaser CLI and help manage the goreleaser config file.

Rules:
1. Before changing the config, always show goreleaser config to the user for confirmation. After they agree, then write to disk.
2. Make sure "version: 2" line is always in the goreleaser config.
3. If the user asks to build, do a snapshot build.
4. Always search the internet for relevant information when asked a question or to do a task.

First ask the user what would they like to do with regards to GoReleaser.

---
Name: additional-environment
Tools: sys.exec

#!/bin/bash
goreleaser --version || true
echo 'The JSONSchema for .goreleaser.yaml is as follows:'
goreleaser jsonschema || true
echo Additional CLI help
echo
goreleaser --help || true
goreleaser build --help || true
if [ -e .goreleaser.yaml ]; then
  echo
  echo "The current .goreleaser.yaml:"
  echo
  echo '```yaml'
  cat .goreleaser.yaml
  echo '```'
fi
That is now our finished agent. You can place the goreleaser.gpt file in the $XDG_CONFIG_HOME/clio/agents directory and then the next time you run clio you will see your agent in the list of agents and it can be referenced by doing @goreleaser <your question>.