# Coding Agent Toolkit

Shared instructions and personal Agent Skills for Codex and GitHub Copilot.

The canonical sources are stored in:

- `instructions/` for shared agent instructions;
- `skills/` for toolkit-owned Agent Skills;
- `vendor/` for external skills tracked as a Git submodule.

Initialize the external skill after cloning an existing checkout without
submodules:

```powershell
git submodule update --init --recursive
```

## Installation

### Codex

Run the Codex installer from PowerShell:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ./scripts/install-codex.ps1
```

It installs:

- one link per skill in `~/.agents/skills`;
- a managed instruction block in `~/.codex/AGENTS.md`.

Existing skills with different names and existing content in `AGENTS.md` are
preserved. Codex supports only one global instruction file, so the toolkit
cannot link each source instruction separately. Instead, it updates only the
block delimited by `coding-agent-toolkit:start` and
`coding-agent-toolkit:end`.

### Copilot

Run the GitHub Copilot installer from PowerShell:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ./scripts/install-copilot.ps1
```

It installs:

- one link per skill in `~/.agents/skills`;
- one dedicated instruction link at
  `~/.copilot/instructions/coding-agent-toolkit`.

Other skills, instruction files, and an existing
`~/.copilot/copilot-instructions.md` are preserved.

### Installer options

Both installers expose the same options:

| Option | Default | Description |
| --- | --- | --- |
| `-SkillInstallMode Link` | Yes | Creates one filesystem link for each toolkit skill inside `~/.agents/skills`. |
| `-SkillInstallMode Copy` | No | Copies the skills into `~/.agents/skills` and writes a manifest used to manage them. |
| `-Force` | Disabled | Replaces an unmanaged skill with the same name, or an unmanaged Copilot path named `coding-agent-toolkit`. Unrelated names and existing Codex instruction content remain untouched. |

Options can be combined:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ./scripts/install-copilot.ps1 -SkillInstallMode Copy -Force
```

> [!WARNING]
> The installers manage skills and instructions differently.
>
> **Skills**
>
> - `Link` is the default skill mode. Each toolkit skill is linked individually
>   inside `~/.agents/skills`; the global directory remains a regular directory
>   and can contain skills from other sources;
> - changes in the repository's `skills/` directory are immediately visible to
>   Codex and Copilot;
> - a toolkit skill cannot coexist with another skill having the same directory
>   name; the installer stops on such a collision unless `-Force` is supplied;
> - `-SkillInstallMode Copy` affects only skills. Copied skills are independent
>   snapshots and must be updated by rerunning the installer.
>
> **Copilot instructions**
>
> - instructions are always linked through the dedicated
>   `~/.copilot/instructions/coding-agent-toolkit` directory, regardless of
>   `-SkillInstallMode`;
> - changes in the repository's `instructions/` directory are therefore
>   immediately visible to Copilot;
> - other files and directories in `~/.copilot/instructions` remain independent;
> - an existing unmanaged path named `coding-agent-toolkit` causes the installer
>   to stop unless `-Force` is supplied.
>
> **Codex instructions**
>
> - Codex instructions are not linked. They are merged into the existing
>   `~/.codex/AGENTS.md` inside a managed block;
> - changes in the repository's `instructions/` directory are not applied
>   automatically: rerun `install-codex.ps1` to refresh the managed block;
> - content outside the managed block is preserved, including during uninstall.
>
> Moving or renaming this repository temporarily breaks linked skills and
> Copilot instructions. Rerun the relevant installer from the new location to
> repair them. Uninstalling removes only links and managed content owned by this
> toolkit, never the source files in the repository.

Without `-Force`, an installer safely updates links and content previously
managed by this toolkit, but refuses to overwrite an unmanaged item with the
same name.

## Update

From the repository root, fetch the latest version:

```powershell
git pull --ff-only
git submodule update --init --recursive
```

Dependabot checks the Feature-Sliced Design submodule weekly and opens a pull
request when its upstream commit changes. To check for an update immediately,
run:

```powershell
git submodule update --remote vendor/feature-sliced-skills
```

Review the upstream changes before committing the updated submodule pointer.

Then rerun the installer for each agent that uses the toolkit:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ./scripts/install-codex.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File ./scripts/install-copilot.ps1
```

Use the same installer options as during the initial installation. In
particular, installations created in `Copy` mode must include
`-SkillInstallMode Copy` again:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ./scripts/install-codex.ps1 -SkillInstallMode Copy
```

Rerunning the installers registers newly added skills, removes toolkit-managed
skills that no longer exist, repairs links when needed, and refreshes copied
content. It is also required to apply instruction changes to Codex because its
managed block in `~/.codex/AGENTS.md` is generated rather than linked.

## Uninstall

Run the uninstaller from PowerShell:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ./scripts/uninstall.ps1
```

The uninstaller has no options. It removes only artifacts owned by this
toolkit:

- individual toolkit skill links, or only manifest-listed copies in `Copy`
  mode;
- the managed toolkit block in Codex's `AGENTS.md`;
- the dedicated toolkit instruction link for Copilot.

Unrelated personal skills, instruction files, and configuration files are
preserved.

## License

This project is licensed under the [MIT License](LICENSE).
