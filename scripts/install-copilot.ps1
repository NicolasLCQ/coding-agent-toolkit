[CmdletBinding()]
param(
    [ValidateSet('Link', 'Copy')]
    [string]$SkillInstallMode = 'Link',

    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

. (Join-Path $PSScriptRoot 'AgentToolkit.Common.ps1')

$toolkitRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$userProfilePath = [Environment]::GetFolderPath([Environment+SpecialFolder]::UserProfile)
if ([string]::IsNullOrWhiteSpace($userProfilePath)) {
    throw 'Unable to determine the current user profile directory.'
}

$personalSkillPath = Join-Path (Join-Path $userProfilePath '.agents') 'skills'
Install-ToolkitSkills `
    -SkillSourcePath (Join-Path $toolkitRoot 'skills') `
    -AdditionalSkillPaths (Join-Path $toolkitRoot 'vendor/feature-sliced-skills/feature-sliced-design') `
    -DestinationPath $personalSkillPath `
    -InstallMode $SkillInstallMode `
    -Force:$Force

$instructionSourcePath = Join-Path $toolkitRoot 'instructions'
$copilotRoot = Join-Path $userProfilePath '.copilot'
$legacyInstructionPath = Join-Path $copilotRoot 'copilot-instructions.md'
if (Test-ToolkitGeneratedFile -Path $legacyInstructionPath) {
    [IO.File]::Delete($legacyInstructionPath)
}

$copilotInstructionPath = Join-Path $copilotRoot 'instructions'
Install-ToolkitInstructionFiles `
    -InstructionSourcePath $instructionSourcePath `
    -DestinationPath $copilotInstructionPath `
    -Force:$Force

Write-Host "Personal skills installed at: $personalSkillPath"
Write-Host "Global Copilot instruction links installed at: $copilotInstructionPath"
