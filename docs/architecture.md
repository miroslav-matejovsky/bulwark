# High-Level Architecture

## Purpose

The system provides controlled execution of network-capable workloads under an immutable scope policy while producing independently verifiable evidence of all network activity and enforcement decisions.

The architecture is built around five principles:

1. Boundary-Enforced Control
2. Evidence Over Assertion
3. Fail Closed
4. Immutable Execution Policy
5. Least Privilege and Separation of Responsibility

---

# Context Overview

```text
                    ┌────────────────────┐
                    │    Scope Policy    │
                    └─────────┬──────────┘
                              │
                    Compiled Policy
                              │
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
                           │ Invocation
                           │
                 ┌──────────────────────┐
                 │ Workload             │
                 │ Orchestration        │
                 └──────────────────────┘
```

---

# Bounded Contexts

## Scope Policy

### Responsibility

Define what is authorized.

### Owns

- Engagement definitions
- Allowed targets
- Excluded targets
- CIDR rules
- Domain rules
- Protocol rules
- Policy compilation
- Policy versioning

### Produces

```text
Compiled Policy
Policy Identifier
Policy Hash
Policy Manifest
```

### Does Not Own

```text
Execution
Enforcement
Traffic Capture
Evidence Collection
```

---

## Execution Boundary

### Responsibility

Enforce policy for all workload network activity.

### Owns

- Network namespace lifecycle
- Virtual interfaces
- Routing
- Firewall rules
- DNS control
- Protocol gates
- Allow / deny decisions
- Fail-closed execution lifecycle

### Consumes

```text
Compiled Policy
```

### Produces

```text
Connection Decisions
Boundary Events
Enforcement Events
```

### Does Not Own

```text
Policy Authoring
Reporting
Scanning Logic
Evidence Interpretation
```

---

## Evidence Collection

### Responsibility

Produce the authoritative record of execution.

### Owns

- Packet capture
- DNS observations
- Enforcement decisions
- Audit records
- Evidence manifests
- Artifact hashing
- Integrity validation

### Produces

```text
Evidence Package
Evidence Manifest
Integrity Hashes
Audit Timeline
```

### Does Not Own

```text
Authorization
Execution
Policy Decisions
```

---

## Workload Orchestration

### Responsibility

Execute and coordinate workloads.

### Owns

- Tool selection
- Job planning
- Worker lifecycle
- Invocation management
- Target assignment
- Result collection

### Consumes

```text
Compiled Policy
Execution Boundary Service
```

### Produces

```text
Invocations
Execution Requests
Tool Results
```

### Does Not Own

```text
Network Authorization
Firewall Rules
Evidence Generation
```

---

# Execution Flow

```text
1. Define Engagement
        │
        ▼

2. Build Compiled Policy
        │
        ▼

3. Create Execution Boundary
        │
        ▼

4. Start Evidence Collection
        │
        ▼

5. Validate Boundary Health
        │
        ▼

6. Execute Workload
        │
        ▼

7. Enforce Network Decisions
        │
        ▼

8. Record Evidence
        │
        ▼

9. Terminate Workload
        │
        ▼

10. Finalize Evidence Package
```

---

# Core Design Rules

## Rule 1

All network communication must cross the Execution Boundary.

No workload may communicate directly with external networks.

---

## Rule 2

Authorization decisions originate exclusively from Scope Policy.

Execution Boundary enforces policy but does not create policy.

---

## Rule 3

Evidence Collection observes and records but never authorizes.

Evidence must remain independent from workload-generated logs.

---

## Rule 4

Workload Orchestration manages execution but cannot bypass enforcement.

Replacing a workload with an arbitrary executable must not weaken controls.

---

## Rule 5

Failure of policy, enforcement, or evidence systems terminates execution or removes network capability.

The system always fails closed.

---

# Primary Architectural Dependency Chain

```text
Scope Policy
      │
      ▼
Execution Boundary
      │
      ▼
Evidence Collection
```

This chain constitutes the trust boundary of the system.

Workload Orchestration and executed tools are considered replaceable consumers of that trust boundary rather than part of it.