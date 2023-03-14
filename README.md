[![use-action][useActionWorkflowBadge]][useActionWorkflow]

`setup-tekton-cli` (Moved to [`openshift-pipelines/setup-tektoncd-cli`][openshiftPipelines])
--------------------------------------------------------------------------------------------

GitHub Action to rollout [Tekton CLI (`tkn`)][githubTektonCLI].

# Usage

```yaml
---
jobs:
  setup-tekton-cli:
    steps:
      - uses: otaviof/setup-tekton-cli@main
        with:
          version: latest
```

By default the action is set to install `latest` release, for a specific version use the `version` input.

[githubTektonCLI]: https://github.com/tektoncd/cli
[useActionWorkflowBadge]: https://github.com/otaviof/setup-tekton-cli/actions/workflows/use-action.yaml/badge.svg
[useActionWorkflow]: https://github.com/otaviof/setup-tekton-cli/actions/workflows/use-action.yaml
[openshiftPipelines]: https://github.com/openshift-pipelines/setup-tektoncd-cli
