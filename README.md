# Jekyll Project Template

*A modern GitHub template repository for building Jekyll plugins and sites with best practices.*

This template provides a pre-configured development environment for working on [Jekyll](https://jekyllrb.com) plugins or projects. It includes:

- GitHub Actions for Ruby and Jekyll CI matrix
- DevContainer for reproducible development
- VS Code tasks for common workflows
- Bundler and RSpec setup
- Automated version bump + release script

## 🚀 Getting Started

### Use This Template

Click **"Use this template"** on GitHub to create your own repository based on this setup.

Then:

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO
cd YOUR_REPO
```

### Required Secrets

To enable automated releases, set the following repository secrets:

`PR_TOKEN`: a personal access token with repo and workflow scopes (used to create/update draft PRs)

`RUBYGEMS_API_KEY`: your RubyGems API key (used to publish releases)

---

## Repository setup

Additional repository options:

`General->Pull Requests`

- Always suggest updating pull request branches (optional)
- Allow auto-merge (required)
- Automatically delete head branches (optional)

`Rules->Rulesets`

- Ruleset name: `main`
- Enforcement status: `active`
- Targets: `Include default branch`
  - Require linear history (optional)
  - Require status checks to pass
    - Add Check: Check required tests passed
  - Block force pushes

`Actions->General`

- Allow GitHub Actions to create and approve pull requests (required)

`Pages`

- Deploy from a branch
- Branch: `main` `/root`

## Development Environment

### VS Code + DevContainer

If you use VS Code and have the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers):

1. Open the project in VS Code.
2. You'll be prompted to "Reopen in Container".
3. Everything (Ruby, Bundler, Jekyll) is preinstalled and ready to go.

## Testing

Run tests with:

```bash
bundle exec rspec          # Ruby tests
```

Or use VS Code tasks:

- `Ctrl+Shift+P` → **Tasks: Run Task** → choose:
  - `test`
  - `lint`
  - `format`

CI will matrix test across Ruby and Jekyll versions via GitHub Actions.

## Release Workflow

Use the included `release.sh` script:

```bash
./release.sh --dry-run    # Simulate release
./release.sh              # Build and push gem to RubyGems
```

CI will:

- Bump the version
- Create/update a draft PR (release/draft)
- Tag and publish on merge to main

## Dependency Management

Dependencies are managed with Bundler:

```bash
bundle install
```

Dependabot is configured to automatically update:

- Ruby gems (`Gemfile`)
- GitHub Actions
- DevContainer metadata

## License

MIT
