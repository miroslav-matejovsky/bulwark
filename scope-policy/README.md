# Scope Policy

## Purpose

Defines what is authorized.

This bounded context owns the language and rules of authorization, including engagement scope, target definitions, exclusions, allowed protocols, and policy compilation.

## Responsibilities

- Define engagement scope
- Define allowed targets and exclusions
- Define domain and CIDR rules
- Define protocol permissions
- Produce immutable compiled policies
- Produce policy identifiers and hashes

## Does Not Own

- Network enforcement
- Process execution
- Traffic capture
- Evidence collection

## Key Concepts

- Engagement
- Policy
- Target
- Exclusion
- Domain Rule
- CIDR Rule
- Protocol Rule
- Compiled Policy
