# High-Level Architecture

## Purpose

Bulwark provides controlled execution of network-capable workloads while ensuring that all network communication remains within explicitly declared reachability and that independently verifiable evidence is produced for every execution.

The architecture is built around five principles:

1. Boundary-Governed Control
2. Evidence Over Assertion
3. Fail Closed
4. Explicit Reachability
5. Least Privilege and Separation of Responsibility

---

# Context Overview

```text
                 ┌─────────────────────┐
                 │    Reachability     │
                 │      Policy         │
                 └─────────┬───────────┘
                           │
                           │ Effective Scope
                           ▼
                 ┌─────────────────────┐
                 │ Execution Boundary  │
                 └───────┬───────┬─────┘
                         │       │
                  Events │       │ Traffic
                         │       │
                         ▼       ▼
               ┌──────────────────────┐
               │ Evidence Collection  │
               └──────────────────────┘
                         ▲
                         │
                         │ Reachability
                         │ Declarations
                         │
               ┌──────────────────────┐
               │ Workload             │
               │ Orchestration        │
               └──────────────────────┘
```

---

# Core Domain Model

Bulwark operates on three fundamental concepts:

```text
Declared Reachability
        ↓
Enforced Reachability
        ↓
Observed Reachability
```

The workload declares where it intends to communicate.

Bulwark enforces those declarations.

The evidence system records what actually occurred.

The system's primary responsibility is maintaining the relationship between these three views.

---

# Bounded Contexts

## reachability-policy

### Responsibility

Own the definition of declared and effective reachability.

### Owns

- Reachability declarations
- Scope definitions
- Domain declarations
- Address declarations
- Protocol declarations
- Scope normalization
- Effective scope generation
- Scope revision history

### Produces

```text
Effective Reachability Scope
Scope Revisions
Declaration History
```

### Does Not Own

```text
Traffic Enforcement
Process Execution
Evidence Generation
```

---

## execution-boundary

### Responsibility

Enforce effective reachability.

### Owns

- Network namespaces
- Interfaces
- Routing
- Firewall policy
- DNS controls
- Protocol controls
- Connection decisions
- Boundary lifecycle

### Consumes

```text
Effective Reachability Scope
```

### Produces

```text
Allow Decisions
Deny Decisions
Boundary Events
```

### Does Not Own

```text
Reachability Declaration
Workload Logic
Evidence Interpretation
```

---

## evidence-collection

### Responsibility

Produce the authoritative record of execution.

### Owns

- Packet capture
- DNS observations
- Connection observations
- Allow / deny records
- Evidence manifests
- Artifact hashing
- Audit timelines
- Integrity verification

### Produces

```text
Observed Reachability
Evidence Package
Execution Audit Trail
```

### Does Not Own

```text
Authorization
Enforcement
Execution Control
```

---

## workload-orchestration

### Responsibility

Manage workload execution.

### Owns

- Job planning
- Worker lifecycle
- Tool execution
- Invocation management
- Result collection
- Reachability declarations

### Produces

```text
Workload Invocations
Reachability Declarations
Execution Requests
```

### Does Not Own

```text
Enforcement Decisions
Traffic Authorization
Evidence Generation
```

---

# Execution Flow

```text
1. Workload starts

2. Workload declares intended reachability

3. Reachability Policy updates effective scope

4. Execution Boundary applies effective scope

5. Workload communicates

6. Execution Boundary enforces scope

7. Evidence Collection records activity

8. Workload may declare additional reachability

9. Effective scope is updated

10. Execution continues

11. Evidence package is finalized
```

---

# Communication Model

## Declaration Channel

Used by workloads to declare intended communication.

```text
Workload
    →
Reachability Policy
```

Examples:

```text
github.com
api.github.com
203.0.113.10
TCP/443
UDP/53
```

A declaration does not authorize communication by itself.

It only defines intended reachability.

---

## Enforcement Channel

Used by Bulwark to constrain actual communication.

```text
Reachability Policy
        →
Execution Boundary
```

Only destinations within the effective scope may be reached.

All undeclared communication is denied.

---

## Evidence Channel

Used to produce independently verifiable records.

```text
Execution Boundary
        →
Evidence Collection
```

Evidence must allow reconstruction of:

- Declared reachability
- Effective reachability
- Observed reachability
- Enforcement decisions
- Boundary lifecycle events

---

# Core Design Rules

## Rule 1

All external communication must traverse the execution boundary.

---

## Rule 2

The workload may declare reachability but cannot bypass enforcement.

---

## Rule 3

Every observed destination must either:

- match declared reachability, or
- be denied and recorded.

---

## Rule 4

Evidence must be generated independently from workload logs.

---

## Rule 5

Security-critical failures terminate execution or remove communication capability.

---

## Rule 6

Declared, effective, and observed reachability must remain reconstructable after execution.

---

# Trust Model

The trusted system consists of:

```text
Reachability Policy
        │
        ▼
Execution Boundary
        │
        ▼
Evidence Collection
```

Workloads are trusted to declare intended communication.

However, workloads are not trusted to enforce, validate, or prove compliance with those declarations.

Bulwark remains the authority for enforcement and evidence generation.

---

# Primary Architectural Question

For any network communication, the system must be able to answer:

```text
Was this destination declared?

Was it permitted?

Was it reached?

Where is the evidence?
```

The architecture exists to provide deterministic answers to those four questions.

---

# Core Relationship

```text
Declared Reachability
        ↓
Effective Reachability
        ↓
Observed Reachability
```

The workload declares what it intends to reach.

Bulwark determines and enforces the effective communication boundary.

The evidence system records what was actually reached.

All architectural decisions should preserve the relationship between declared, effective, and observed reachability.

---

# Trust Boundaries

## Workload

Trusted to:

- perform its intended task
- declare intended reachability
- adapt declarations as new targets are discovered

Not trusted to:

- enforce restrictions
- validate compliance
- produce authoritative evidence

---

## Bulwark

Trusted to:

- maintain effective reachability
- enforce communication boundaries
- deny undeclared communication
- record enforcement decisions
- fail closed when uncertainty exists

Bulwark is the authority for network control.

---

## Evidence Collection

Trusted to:

- observe execution
- record network activity
- record enforcement outcomes
- preserve execution history
- support independent verification

Evidence Collection is the authority for what happened.

---

# Architectural Invariants

The following statements must remain true regardless of implementation details.

### Invariant 1

All external communication traverses the Execution Boundary.

### Invariant 2

No workload can communicate outside the effective reachability enforced by Bulwark.

### Invariant 3

Every observed communication is either:

- explicitly declared and permitted, or
- denied and recorded.

### Invariant 4

Evidence is generated independently of workload-controlled logging.

### Invariant 5

Loss of enforcement or observation never results in uncontrolled communication.

### Invariant 6

Declared, effective, and observed reachability remain reconstructable after execution.

---

# System Responsibilities

```text
Workload
    →
Declare Reachability

Reachability Policy
    →
Maintain Effective Scope

Execution Boundary
    →
Enforce Effective Scope

Evidence Collection
    →
Record What Happened
```

Each responsibility belongs to a single bounded context.

No component should simultaneously:

- declare reachability,
- enforce reachability,
- and authoritatively record reachability.

---

# Architectural Test

A proposed change is acceptable only if it preserves the ability to determine:

```text
What did the workload intend to reach?

What was it allowed to reach?

What did it actually reach?

How do we prove it?
```

If any architectural change weakens the ability to answer these questions, the change should be rejected or require an explicit exception.
