[![use-action][useActionWorkflowBadge]][useActionWorkflow]

`setup-tekton-cli`
------------------

GitHub Action to rollout [Tekton CLI (`tkn`)][githubTektonCLI].

# Usage

```yaml
---
jobs:
  setup-tekton-cli:
    steps:
      - uses: otaviof/setup-tekton-cli@main
          cli_version: latest
```

By default the action is set to install `latest` release, to install a specific version use the input `cli_version`.

[githubTektonCLI]: https://github.com/tektoncd/cli
[useActionWorkflowBadge]: https://github.com/otaviof/setup-tekton-cli/actions/workflows/use-action.yaml/badge.svg
[useActionWorkflow]: https://github.com/otaviof/setup-tekton-cli/actions/workflows/use-action.yaml
