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
