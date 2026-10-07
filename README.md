# Bulwark

> Controlled execution boundaries for network-capable workloads.

Bulwark allows workloads to declare the destinations they intend to reach while independently enforcing communication boundaries and producing verifiable evidence of actual network activity.

## Principles

- Boundary-Governed Control
- Evidence Over Assertion
- Fail Closed
- Explicit Reachability
- Least Privilege and Separation of Responsibility

## Core Model

```text
Declared Reachability
        ↓
Effective Reachability
        ↓
Observed Reachability
```

The workload declares what it intends to reach.

Bulwark determines and enforces what may be reached.

The evidence system records what was actually reached.

## Architecture

```text
reachability-policy
        │
        ▼
execution-boundary
        │
        ▼
evidence-collection

workload-orchestration
        │
        ▼
execution-boundary
```

## Primary Questions

For any network communication, Bulwark must be able to answer:

```text
Was this destination declared?

Was it permitted?

Was it reached?

Where is the evidence?
```

## Status

Early architectural design and prototyping.