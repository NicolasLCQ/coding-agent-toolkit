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

$codexRoot = Join-Path $userProfilePath '.codex'
$codexAgentPath = Join-Path $codexRoot 'AGENTS.md'
$instructionDocument = Get-ToolkitInstructionDocument `
    -InstructionSourcePath (Join-Path $toolkitRoot 'instructions') `
    -InstallScriptName 'install-codex.ps1'

Set-ToolkitManagedBlock `
    -Path $codexAgentPath `
    -Content $instructionDocument

Write-Host "Personal skills installed at: $personalSkillPath"
Write-Host "Global Codex instruction block installed at: $codexAgentPath"
