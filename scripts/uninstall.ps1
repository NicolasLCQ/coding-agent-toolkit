[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

. (Join-Path $PSScriptRoot 'AgentToolkit.Common.ps1')

$userProfilePath = [Environment]::GetFolderPath([Environment+SpecialFolder]::UserProfile)
if ([string]::IsNullOrWhiteSpace($userProfilePath)) {
    throw 'Unable to determine the current user profile directory.'
}

$toolkitRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$profileRoot = [IO.Path]::GetFullPath($userProfilePath)
$personalAgentRoot = Join-Path $profileRoot '.agents'
$personalSkillPath = Join-Path $personalAgentRoot 'skills'
$sourceSkillPath = Join-Path $toolkitRoot 'skills'
$skillItem = Get-Item -LiteralPath $personalSkillPath -Force -ErrorAction SilentlyContinue

if ($null -eq $skillItem) {
    Write-Host "No personal skill installation found at: $personalSkillPath"
}
elseif (($skillItem.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
    $pointsToLegacyToolkit = @($skillItem.Target) | Where-Object {
        -not [string]::IsNullOrWhiteSpace($_) -and
        [IO.Path]::GetFullPath($_) -eq $sourceSkillPath
    }
    if ($pointsToLegacyToolkit) {
        [IO.Directory]::Delete($personalSkillPath)
        Write-Host "Removed legacy personal skill link: $personalSkillPath"
    }
    else {
        Write-Warning "Preserved a personal skill root link not owned by this toolkit: $personalSkillPath"
    }
}
elseif (-not $skillItem.PSIsContainer) {
    Write-Warning "Preserved a personal skill path that is not a directory: $personalSkillPath"
}
else {
    $manifestPath = Join-Path $personalSkillPath '.agent-toolkit.manifest.json'
    $manifest = Get-ToolkitManifest -Path $manifestPath
    if ($null -eq $manifest) {
        Write-Host "No toolkit-managed skills found at: $personalSkillPath"
    }
    else {
        Remove-ToolkitSkillEntries `
            -DestinationPath $personalSkillPath `
            -SkillSourcePath $sourceSkillPath `
            -Manifest $manifest
        [IO.File]::Delete($manifestPath)
        if ([IO.Directory]::GetFileSystemEntries($personalSkillPath).Count -eq 0) {
            [IO.Directory]::Delete($personalSkillPath)
        }
        Write-Host "Removed toolkit-managed skills from: $personalSkillPath"
    }
}

if (
    [IO.Directory]::Exists($personalAgentRoot) -and
    [IO.Directory]::GetFileSystemEntries($personalAgentRoot).Count -eq 0
) {
    [IO.Directory]::Delete($personalAgentRoot)
}

$codexRoot = Join-Path $profileRoot '.codex'
$codexAgentPath = Join-Path $codexRoot 'AGENTS.md'
if (Remove-ToolkitManagedBlock -Path $codexAgentPath) {
    Write-Host "Removed the toolkit instruction block from: $codexAgentPath"
}
else {
    Write-Host "No toolkit-managed Codex instructions found at: $codexAgentPath"
}
if (
    [IO.Directory]::Exists($codexRoot) -and
    [IO.Directory]::GetFileSystemEntries($codexRoot).Count -eq 0
) {
    [IO.Directory]::Delete($codexRoot)
}

$copilotRoot = Join-Path $profileRoot '.copilot'
$copilotInstructionRoot = Join-Path $copilotRoot 'instructions'
if (Remove-ToolkitInstructionFiles `
    -InstructionSourcePath (Join-Path $toolkitRoot 'instructions') `
    -DestinationPath $copilotInstructionRoot
) {
    Write-Host "Removed toolkit-managed Copilot instruction links from: $copilotInstructionRoot"
}
else {
    Write-Host "No toolkit-managed Copilot instruction links found at: $copilotInstructionRoot"
}

$legacyCopilotInstructionPath = Join-Path $copilotRoot 'copilot-instructions.md'
if (Test-ToolkitGeneratedFile -Path $legacyCopilotInstructionPath) {
    [IO.File]::Delete($legacyCopilotInstructionPath)
    Write-Host "Removed legacy global Copilot instructions: $legacyCopilotInstructionPath"
}
if (
    [IO.Directory]::Exists($copilotRoot) -and
    [IO.Directory]::GetFileSystemEntries($copilotRoot).Count -eq 0
) {
    [IO.Directory]::Delete($copilotRoot)
}
