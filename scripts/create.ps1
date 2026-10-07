# Replace top-level bounded contexts with the current Bulwark architecture

$contexts = @{
    "reachability-policy" = @"
# Reachability Policy

## Purpose

Owns the definition of declared and effective reachability.

This bounded context manages what workloads intend to reach and produces the effective communication scope enforced by Bulwark.

## Responsibilities

- Reachability declarations
- Domain declarations
- Address declarations
- Protocol declarations
- Scope normalization
- Effective scope generation
- Scope revision history

## Produces

- Effective Reachability Scope
- Scope Revisions
- Declaration History

## Does Not Own

- Traffic enforcement
- Process execution
- Evidence generation

## Key Concepts

- Reachability Declaration
- Effective Reachability
- Domain
- Address
- Protocol
- Scope Revision
"@

    "execution-boundary" = @"
# Execution Boundary

## Purpose

Enforces effective reachability.

This bounded context acts as the authoritative communication boundary for all workloads.

## Responsibilities

- Network namespaces
- Interfaces
- Routing
- Firewall policy
- DNS controls
- Protocol controls
- Connection decisions
- Boundary lifecycle

## Consumes

- Effective Reachability Scope

## Produces

- Allow Decisions
- Deny Decisions
- Boundary Events

## Does Not Own

- Reachability declaration
- Workload logic
- Evidence interpretation

## Key Concepts

- Boundary
- Namespace
- Route
- Connection
- Allow Decision
- Deny Decision
- Enforcement
"@

    "evidence-collection" = @"
# Evidence Collection

## Purpose

Produce the authoritative record of execution.

This bounded context independently records network activity and enforcement outcomes.

## Responsibilities

- Packet capture
- Connection observations
- DNS observations
- Allow and deny records
- Audit timelines
- Artifact hashing
- Evidence manifests
- Integrity verification

## Produces

- Observed Reachability
- Evidence Package
- Execution Audit Trail

## Does Not Own

- Authorization
- Enforcement
- Execution control

## Key Concepts

- Observed Reachability
- Packet Capture
- Evidence Artifact
- Audit Trail
- Manifest
- Verification
"@

    "workload-orchestration" = @"
# Workload Orchestration

## Purpose

Manage workload execution.

This bounded context coordinates tools and workloads that operate within Bulwark boundaries.

## Responsibilities

- Job planning
- Worker lifecycle
- Tool execution
- Invocation management
- Result collection
- Reachability declarations

## Produces

- Workload Invocations
- Execution Requests
- Reachability Declarations

## Does Not Own

- Traffic authorization
- Enforcement decisions
- Evidence generation

## Key Concepts

- Workload
- Tool
- Job
- Invocation
- Worker
- Declaration
"@
}

# Remove old top-level bounded context folders if present
$oldContexts = @(
    "scope-policy"
)

foreach ($folder in $oldContexts) {
    if (Test-Path $folder) {
        Remove-Item $folder -Recurse -Force
    }
}

# Create/update current bounded contexts
foreach ($name in $contexts.Keys) {
    New-Item -ItemType Directory -Path $name -Force | Out-Null
    Set-Content `
        -Path (Join-Path $name "README.md") `
        -Value $contexts[$name] `
        -Encoding UTF8
}

Write-Host ""
Write-Host "Bulwark bounded contexts initialized:"
$contexts.Keys | Sort-Object | ForEach-Object {
    Write-Host " - $_"
}