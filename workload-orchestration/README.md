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
