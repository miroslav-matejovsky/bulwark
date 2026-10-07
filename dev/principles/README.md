# Architectural Principles

## P1. Boundary-Enforced Control

All network restrictions shall be enforced by an execution boundary independent of the workload.

The system shall not rely on applications, libraries, plugins, scanners, or subprocesses to enforce network scope. Replacing the workload with an arbitrary executable must not weaken policy enforcement.

**Evaluation**
- Is enforcement independent of workload cooperation?
- Does the boundary remain effective if the workload is modified, replaced, or compromised?
- Can network restrictions be bypassed without compromising the boundary itself?

---

## P2. Evidence Over Assertion

Every security-relevant network action must be verifiable from independently collected evidence.

Workload-generated logs are assertions. The authoritative record of execution shall be produced by the execution boundary and evidence systems.

**Evaluation**
- Can an auditor reconstruct network activity without trusting the workload?
- Are both permitted and denied actions independently recorded?
- Does evidence originate from boundary-controlled sources rather than workload-controlled sources?

---

## P3. Fail Closed

Any loss of enforcement, observation, or policy validity shall reduce capability rather than reduce security.

When uncertainty exists, the system shall stop execution, restrict execution, or deny network access rather than continue in a potentially uncontrolled state.

**Evaluation**
- Does failure of any security-critical component prevent uncontrolled execution?
- Can enforcement, observation, or policy components fail while network access continues?
- Is the secure state the default outcome of failure?

---

## P4. Immutable Execution Policy

Every execution shall operate under a complete, immutable, and attributable policy.

The policy governing an execution must be fully known before execution begins, remain unchanged for its duration, and be attributable after completion.

**Evaluation**
- Can the exact policy that governed a run be identified afterwards?
- Can policy change during execution?
- Is every decision attributable to a specific policy version and rule set?

---

## P5. Least Privilege and Separation of Responsibility

Components shall possess only the authority required for their responsibility, and no component shall simultaneously define policy, enforce policy, and produce evidence.

Trustworthiness is achieved through separation of duties and minimization of privileges.

**Evaluation**
- Does any component possess privileges beyond its responsibility?
- Can a single component modify policy, enforcement, and evidence?
- Are policy, enforcement, evidence, and workload responsibilities clearly separated?

---

# Architectural Test

A proposed change is acceptable only if it strengthens or preserves all five principles:

1. Boundary-Enforced Control
2. Evidence Over Assertion
3. Fail Closed
4. Immutable Execution Policy
5. Least Privilege and Separation of Responsibility

If a change violates any principle, it requires an explicit architectural exception and documented justification.
