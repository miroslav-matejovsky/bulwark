# Reachability Policy

## Purpose

Owns the definition of declared and effective reachability.

This bounded context manages what workloads intend to reach and produces the effective communication scope enforced by Bulwark.

## Responsibilities

- Reachability declarations
- Domain declarations
- Address declarations
- Protocol declarations
- Scope normalization
- Effective scope generation
- Scope revision history

## Produces

- Effective Reachability Scope
- Scope Revisions
- Declaration History

## Does Not Own

- Traffic enforcement
- Process execution
- Evidence generation

## Key Concepts

- Reachability Declaration
- Effective Reachability
- Domain
- Address
- Protocol
- Scope Revision
