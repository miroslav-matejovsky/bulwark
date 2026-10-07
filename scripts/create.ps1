# Create bounded context folders with README.md descriptions

$contexts = @{
    "scope-policy" = @"
# Scope Policy

## Purpose

Defines what is authorized.

This bounded context owns the language and rules of authorization, including engagement scope, target definitions, exclusions, allowed protocols, and policy compilation.

## Responsibilities

- Define engagement scope
- Define allowed targets and exclusions
- Define domain and CIDR rules
- Define protocol permissions
- Produce immutable compiled policies
- Produce policy identifiers and hashes

## Does Not Own

- Network enforcement
- Process execution
- Traffic capture
- Evidence collection

## Key Concepts

- Engagement
- Policy
- Target
- Exclusion
- Domain Rule
- CIDR Rule
- Protocol Rule
- Compiled Policy
"@

    "execution-boundary" = @"
# Execution Boundary

## Purpose

Enforces policy.

This bounded context provides the trusted network boundary through which all workload traffic must pass.

## Responsibilities

- Network namespace lifecycle
- Interface configuration
- Routing
- Firewall enforcement
- DNS enforcement
- Protocol enforcement
- Connection authorization decisions
- Fail-closed execution control

## Does Not Own

- Scope definition
- Policy authoring
- Evidence interpretation
- Scanning logic

## Key Concepts

- Boundary
- Namespace
- Interface
- Route
- Connection
- Enforcement Rule
- Allow Decision
- Deny Decision
- Boundary Lifecycle
"@

    "evidence-collection" = @"
# Evidence Collection

## Purpose

Establishes what happened.

This bounded context creates independently verifiable execution evidence without relying on workload-generated logs.

## Responsibilities

- Packet capture
- DNS event recording
- Enforcement decision recording
- Execution audit trail
- Artifact hashing
- Manifest generation
- Evidence integrity validation

## Does Not Own

- Authorization decisions
- Workload management
- Policy creation

## Key Concepts

- Packet Capture
- Evidence Artifact
- Decision Record
- Audit Trail
- Manifest
- Hash
- Verification
"@

    "workload-orchestration" = @"
# Workload Orchestration

## Purpose

Manages execution of workloads.

This bounded context schedules, launches, monitors, and collects results from tools executing inside execution boundaries.

## Responsibilities

- Workload selection
- Tool execution
- Worker lifecycle
- Target allocation
- Invocation planning
- Result collection

## Does Not Own

- Network authorization
- Firewall enforcement
- Evidence generation
- Policy definition

## Key Concepts

- Workload
- Tool
- Worker
- Invocation
- Job
- Execution Plan
- Result
"@
}

foreach ($name in $contexts.Keys) {
    New-Item -ItemType Directory -Path $name -Force | Out-Null
    Set-Content -Path (Join-Path $name "README.md") -Value $contexts[$name] -Encoding UTF8
}

Write-Host "Created:"
$contexts.Keys | Sort-Object | ForEach-Object { Write-Host " - $_" }