# Coding Agent Toolkit

Global Codex instructions and personal skills for Codex, GitHub Copilot, and
other agents that support the Agent Skills standard.

The canonical sources are kept in:

- `instructions/` for general and path-aware instructions;
- `skills/` for reusable Agent Skills.

## Install globally

Run the installer from PowerShell:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ./scripts/install.ps1
```

By default, it:

- links `~/.agents/skills` to this repository's `skills/` directory;
- generates `~/.codex/AGENTS.md` from `instructions/`.

Use a copy instead of a filesystem link when links are unsuitable:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ./scripts/install.ps1 -SkillInstallMode Copy
```

The installer refuses to replace an unrelated `~/.codex/AGENTS.md`. Pass
`-Force` only when replacing that file is intentional.

## Uninstall globally

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ./scripts/uninstall.ps1
```

The uninstaller removes only artifacts owned by this toolkit. It removes the
personal skill link in `Link` mode, or only the manifest-listed skills in
`Copy` mode. Unrelated personal skills and Codex instructions are preserved.
