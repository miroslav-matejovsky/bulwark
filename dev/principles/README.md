# Architectural Principles

## P1. Boundary-Governed Control

All network restrictions shall be enforced by Bulwark independently of workload implementation.

Workloads may declare intended network destinations, but only Bulwark determines and enforces the effective communication boundary. Replacing a workload with an arbitrary executable must not weaken enforcement.

**Evaluation**
- Is enforcement independent of workload implementation?
- Can a workload bypass or disable network restrictions?
- Would enforcement remain effective if the workload were replaced or compromised?

---

## P2. Evidence Over Assertion

Every security-relevant network action must be verifiable from independently collected evidence.

Workload-generated logs are assertions. The authoritative record of execution shall be produced by Bulwark and its evidence systems.

**Evaluation**
- Can network activity be reconstructed without trusting the workload?
- Are both allowed and denied actions independently recorded?
- Does evidence originate from boundary-controlled sources?

---

## P3. Fail Closed

Any loss of enforcement, observation, or policy validity shall reduce capability rather than reduce security.

When uncertainty exists, execution shall stop, network access shall be restricted, or the run shall be marked invalid rather than continue in an uncontrolled state.

**Evaluation**
- Does failure of a security-critical component prevent uncontrolled communication?
- Can enforcement or observation fail while execution continues unrestricted?
- Is the secure state the default outcome of failure?

---

## P4. Explicit Reachability

Every network communication shall occur within an explicitly declared reachability scope.

Workloads are responsible for declaring the destinations they intend to reach. Bulwark is responsible for ensuring communication is limited to the declared scope and for producing evidence of actual reachability.

The declared scope may evolve during execution as workload knowledge evolves, provided all additions are explicitly declared and become part of the recorded execution history.

**Evaluation**
- Is every observed destination covered by an explicit declaration?
- Can a workload communicate with undeclared destinations?
- Can declared and observed reachability be compared after execution?
- Can the effective communication scope be reconstructed from execution evidence?

---

## P5. Least Privilege and Separation of Responsibility

Components shall possess only the authority required for their responsibility, and no component shall simultaneously define policy, enforce policy, and produce evidence.

Trustworthiness is achieved through clear separation between declaration, enforcement, observation, and workload execution.

**Evaluation**
- Does any component possess privileges beyond its responsibility?
- Can a single component modify policy, enforcement, and evidence?
- Are declaration, enforcement, evidence, and workload responsibilities clearly separated?

---

# Architectural Test

A proposed change is acceptable only if it strengthens or preserves all five principles:

1. Boundary-Governed Control
2. Evidence Over Assertion
3. Fail Closed
4. Explicit Reachability
5. Least Privilege and Separation of Responsibility

If a change violates any principle, it requires an explicit architectural exception and documented justification.
