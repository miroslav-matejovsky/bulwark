# Bulwark

> Bulwark provides controlled execution of network-capable workloads under an immutable policy while producing independently verifiable evidence of all network activity and enforcement decisions.

## Problem Statement

Network reconnaissance, collection, scanning, and validation tools frequently operate outside their intended scope due to software defects, embedded third-party behaviors, protocol edge cases, or configuration mistakes.

Traditional approaches rely on application-level filtering and workload-generated logs. These mechanisms are insufficient because they depend on the cooperation and correctness of the executed workload.

Bulwark addresses this problem by enforcing network policy outside the workload and generating evidence independently of workload-generated records.

---

# Goals

## Control

Ensure all network activity complies with an explicitly defined execution policy.

## Visibility

Produce a complete and independently verifiable record of network activity and enforcement decisions.

## Containment

Safely execute cooperative and non-cooperative tools within the same architectural model.

## Determinism

Ensure every execution can be explained and reproduced from its policy, evidence, and lifecycle records.

---

# Architectural Principles

## Boundary-Enforced Control

All network restrictions are enforced by an execution boundary independent of the workload.

## Evidence Over Assertion

Every security-relevant network action must be verifiable from independently collected evidence.

## Fail Closed

Loss of enforcement, observation, or policy validity reduces capability rather than security.

## Immutable Execution Policy

Every execution operates under a complete, immutable, and attributable policy.

## Least Privilege and Separation of Responsibility

Components possess only the authority required for their responsibility and no component simultaneously defines policy, enforces policy, and produces evidence.

---

# High-Level Architecture

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

## scope-policy

Defines what is authorized.

Owns engagement scope, target definitions, exclusions, protocol permissions, policy compilation, and policy versioning.

Produces immutable compiled policies consumed by the execution boundary.

---

## execution-boundary

Enforces policy.

Owns network isolation, routing, filtering, protocol enforcement, connection decisions, and fail-closed execution control.

Acts as the sole authority for allow and deny decisions.

---

## evidence-collection

Establishes what happened.

Owns traffic capture, enforcement records, metadata collection, integrity verification, and evidence packaging.

Produces the authoritative record of execution.

---

## workload-orchestration

Coordinates workloads.

Owns workload scheduling, tool execution, worker lifecycle management, target allocation, and result collection.

Consumes boundary services but does not participate in authorization decisions.

---

# Core Design Rules

## Rule 1

All external network communication must traverse an execution boundary.

## Rule 2

Authorization decisions originate exclusively from scope-policy.

## Rule 3

Evidence collection never authorizes traffic.

## Rule 4

Replacing a workload with an arbitrary executable must not weaken enforcement.

## Rule 5

Security-critical failures terminate execution or remove network capability.

## Rule 6

Evidence must remain independently verifiable after workload completion.

---

# Trust Model

The trusted system consists of:

```text
Scope Policy
      │
      ▼
Execution Boundary
      │
      ▼
Evidence Collection
```

Executed workloads are not part of the trust boundary.

Workloads are treated as potentially unreliable, misconfigured, compromised, or unaware of policy.

Security properties are guaranteed by the trusted system rather than the workload.

---

# Execution Lifecycle

```text
1. Define engagement scope

2. Compile immutable policy

3. Create execution boundary

4. Initialize evidence collection

5. Verify boundary health

6. Execute workload

7. Enforce policy decisions

8. Record network evidence

9. Terminate workload

10. Finalize evidence package
```

---

# Evidence Model

Each execution produces an evidence package containing:

```text
manifest.json
policy.compiled.json
lifecycle.ndjson
decisions.ndjson
capture.pcapng
checksums.sha256
```

Evidence must allow an independent reviewer to determine:

- What policy governed the execution
- What traffic occurred
- What traffic was denied
- Why each decision was made
- Whether evidence collection remained healthy throughout execution

---

# Non-Goals

Bulwark is not:

- A scanner
- A discovery engine
- A vulnerability management platform
- An asset inventory system
- A reporting platform
- A firewall management product

Bulwark is an execution-control and evidence-generation platform upon which such systems may safely operate.

---

# Vision

Any network-capable workload can be executed inside Bulwark and produce a deterministic answer to the following questions:

- What was permitted?
- What was denied?
- Why?
- Under which policy?
- Where is the evidence?

Without requiring trust in the workload itself.