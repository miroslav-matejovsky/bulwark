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
