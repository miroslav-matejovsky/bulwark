# SDK

## Purpose

Provides the workload-facing integration layer for Bulwark.

The SDK allows cooperative workloads to interact with Bulwark using domain concepts rather than implementation details. Workloads declare intended reachability, query current scope, inspect boundary status, and annotate execution activity.

The SDK does not enforce policy. It is a client of Bulwark services.

## Responsibilities

- Reachability declaration
- Scope discovery
- Boundary status queries
- Execution annotations
- Connection to Bulwark control interfaces
- Protocol compatibility between workloads and Bulwark

## Does Not Own

- Policy decisions
- Network enforcement
- Evidence generation
- Namespace management
- Firewall configuration

## Key Concepts

- Reachability Declaration
- Effective Reachability
- Scope Query
- Boundary Status
- Execution Annotation
- Control Session

## Architectural Role

```text
Workload
    │
    ▼
SDK
    │
    ▼
Bulwark Control Interface
    │
    ▼
Reachability Policy
```

The SDK exists to keep workloads independent from Bulwark internals.

Workloads should operate in terms of:

```text
Domains
Addresses
Networks
Protocols
Reachability
```

and never:

```text
nftables
iptables
routing
network namespaces
packet capture
```

## Typical Usage

### Declare Reachability

```go
bulwark.DeclareDomain("api.example.com")

bulwark.DeclareCIDR("203.0.113.0/24")

bulwark.DeclareEndpoint("203.0.113.10", 443, "tcp")
```

### Query Effective Scope

```go
scope, err := bulwark.Scope()
```

### Query Boundary Status

```go
status, err := bulwark.Status()
```

### Annotate Execution

```go
bulwark.Annotate(
    "host-discovered",
    map[string]string{
        "hostname": "api.example.com",
    },
)
```

## Control Interface

The SDK communicates with Bulwark through a local control interface.

On Linux this is expected to be a Unix domain socket.

Example:

```text
/run/bulwark/control.sock
```

The workload never communicates directly with enforcement components.

All interaction occurs through the SDK and Bulwark control APIs.

## Design Principles

### Domain-Oriented

The SDK exposes reachability concepts rather than operating-system primitives.

### Enforcement-Agnostic

SDK consumers do not need to know how Bulwark performs enforcement.

### Linux Native

Communication uses local operating-system facilities rather than network-accessible APIs whenever possible.

### Optional

Workloads that are unaware of Bulwark may still execute inside Bulwark boundaries.

The SDK exists to support cooperative workloads, not to make enforcement possible.

### Minimal

The SDK should remain a thin client around Bulwark capabilities and should not duplicate policy, enforcement, or evidence logic.

## Success Criteria

A workload using the SDK can:

- Declare intended communication.
- Discover current effective communication scope.
- Understand boundary health and availability.
- Correlate execution activity with evidence.

Without requiring knowledge of Bulwark internals.