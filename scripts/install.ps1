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

$personalAgentRoot = Join-Path $userProfilePath '.agents'
$personalSkillPath = Join-Path $personalAgentRoot 'skills'
$sourceSkillPath = Join-Path $toolkitRoot 'skills'
[IO.Directory]::CreateDirectory($personalAgentRoot) | Out-Null

if ($SkillInstallMode -eq 'Copy') {
    Copy-ToolkitSkills `
        -SkillSourcePath $sourceSkillPath `
        -DestinationPath $personalSkillPath `
        -Force:$Force
}
elseif (Test-Path -LiteralPath $personalSkillPath) {
    $existingSkillItem = Get-Item -LiteralPath $personalSkillPath -Force
    $existingTargets = @($existingSkillItem.Target)
    $pointsToToolkit = $existingTargets | Where-Object {
        -not [string]::IsNullOrWhiteSpace($_) -and
        [IO.Path]::GetFullPath($_) -eq $sourceSkillPath
    }

    if (-not $pointsToToolkit) {
        throw "The personal skill path already exists and does not link to this toolkit: $personalSkillPath. Move it or use -SkillInstallMode Copy."
    }
}
else {
    $linkType = if ($env:OS -eq 'Windows_NT') { 'Junction' } else { 'SymbolicLink' }
    New-Item -ItemType $linkType -Path $personalSkillPath -Target $sourceSkillPath | Out-Null
}

$codexRoot = Join-Path $userProfilePath '.codex'
$codexAgentPath = Join-Path $codexRoot 'AGENTS.md'
$instructionDocument = Get-ToolkitInstructionDocument `
    -InstructionSourcePath (Join-Path $toolkitRoot 'instructions')

Write-ToolkitGeneratedFile `
    -Path $codexAgentPath `
    -Content $instructionDocument `
    -Force:$Force

Write-Host "Personal skills installed at: $personalSkillPath"
Write-Host "Global Codex instructions installed at: $codexAgentPath"
