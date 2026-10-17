---
applyTo: '**'
description: 'Security instructions for all software development, guided by the OWASP Top 10.'
---

# Secure Development Guidelines

## Objective

Apply security practices appropriate to the software being designed, generated, reviewed, tested, configured, or refactored. Use the OWASP Top 10 as the primary risk checklist without assuming a specific language, framework, platform, deployment model, or user interface.

## Core Rules

- Treat all data crossing a trust boundary as untrusted, regardless of whether it comes from a user, file, database, network, device, dependency, environment variable, IPC channel, or another internal service.
- Identify the assets, actors, entry points, trust boundaries, privileges, and realistic failure modes affected by the change.
- Apply controls in proportion to the risk and context. Do not add web-specific controls to software that has no corresponding web attack surface.
- Prefer secure defaults, least privilege, explicit authorization, minimal exposure, defense in depth, and fail-safe behavior.
- Minimize the collection, storage, transmission, logging, and lifetime of sensitive data.
- Use established platform security APIs and well-maintained security libraries. Do not invent cryptographic algorithms, authentication protocols, parsers, or escaping schemes.
- Preserve existing security controls unless the requested change explicitly and safely replaces them.
- When a security-relevant choice cannot be inferred safely, state the assumption or ask for the missing threat, data-sensitivity, deployment, or trust-boundary information.
- When identifying a vulnerability, explain the concrete risk, affected boundary, remediation, and any residual limitation. Avoid generic security commentary when no relevant risk exists.

## OWASP Top 10 Security Checklist

Use every category as a review prompt. Implement a mitigation only when the category applies to the system or change.

### A01: Broken Access Control

- Deny access by default and grant only the permissions required for the operation and resource.
- Enforce authorization at the trusted boundary for every privileged action; never rely solely on a client, UI, caller, route name, or hidden control.
- Prevent privilege escalation, insecure direct object references, path traversal, and unauthorized access across users, tenants, processes, files, devices, or services.
- Validate outbound destinations and restrict protocols, hosts, ports, paths, redirects, and address ranges when untrusted data can influence a network request.

### A02: Security Misconfiguration

- Ship production-safe defaults and disable debug features, sample accounts, unnecessary services, permissive policies, and verbose error details outside controlled environments.
- Minimize exposed interfaces and permissions across applications, operating systems, containers, cloud resources, devices, APIs, and build pipelines.
- Apply platform-specific protections when relevant, including transport security, browser security headers, sandboxing, secure file permissions, and network restrictions.
- Keep security-relevant configuration explicit, reviewable, and consistent across environments.

### A03: Software Supply Chain Failures

- Minimize dependencies and prefer native or already trusted capabilities when they meet the need.
- Evaluate dependencies, tools, images, actions, plugins, and generated artifacts for provenance, maintenance, known vulnerabilities, licensing, and necessity.
- Pin or lock versions where reproducibility matters, verify integrity when supported, and protect build and release pipelines from unauthorized changes.
- Use the ecosystem's maintained vulnerability and dependency analysis tools, and address findings according to exploitability and impact.

### A04: Cryptographic Failures

- Classify sensitive data and protect it in transit, at rest, in backups, in memory, and in logs according to its risk.
- Use current, standard cryptographic protocols and primitives through trusted libraries with safe parameter choices.
- Store passwords with a dedicated adaptive password-hashing algorithm and a unique salt. Do not use general-purpose fast hashes for password storage.
- Never hardcode secrets. Load them from an appropriate secret-management mechanism, restrict access, support rotation, and prevent accidental logging or source-control exposure.
- Use cryptographically secure randomness for secrets, tokens, identifiers that require unpredictability, and key material.

### A05: Injection

- Keep untrusted data separate from commands, queries, expressions, templates, markup, paths, and configuration.
- Use parameterized APIs, structured arguments, allowlists, and context-aware encoding rather than string concatenation.
- Validate inputs against the expected type, length, range, format, and business rules at the trusted boundary.
- Avoid invoking a command shell when a direct process API is available. If dynamic execution is unavoidable, constrain both the executable and every argument.
- Encode or sanitize untrusted output for its exact destination context, such as HTML, URLs, CSS, JavaScript, SQL, LDAP, logs, or terminal output.

### A06: Insecure Design

- Consider abuse cases, attacker capabilities, trust boundaries, sensitive operations, and recovery paths before implementation.
- Design limits for resource consumption, concurrency, retries, request size, frequency, and costly operations where abuse could affect availability or cost.
- Make security invariants explicit and enforce them centrally where practical.
- Avoid relying on secrecy of implementation, client behavior, or a single control for critical protection.

### A07: Authentication Failures

- Use established identity mechanisms and protocols appropriate to the platform.
- Protect credentials, sessions, tokens, recovery flows, and device identities throughout their lifecycle.
- Apply rate limits, replay protection, expiration, revocation, and stronger authentication when justified by the threat model.
- Do not reveal whether an account, credential, token, or protected resource exists unless the workflow requires it safely.

### A08: Software and Data Integrity Failures

- Verify the authenticity and integrity of code, updates, packages, serialized data, configuration, messages, and artifacts before trusting or executing them.
- Do not deserialize untrusted data into executable or privileged object graphs. Use constrained formats and explicit schemas.
- Protect update, build, deployment, migration, and automation processes with reviewable authorization and integrity checks.
- Treat generated content and external automation output as untrusted until validated for its destination.

### A09: Security Logging and Alerting Failures

- Record security-relevant events with enough context for detection and investigation while excluding secrets and unnecessary personal data.
- Protect logs from injection, tampering, unauthorized access, and uncontrolled retention.
- Make failures observable through appropriate logs, metrics, traces, audit records, or alerts for the operating environment.
- Use stable event identifiers and correlation data when operations cross components or trust boundaries.

### A10: Mishandling of Exceptional Conditions

- Handle errors, timeouts, partial failures, malformed data, exhausted resources, and unavailable dependencies deliberately.
- Fail closed for security decisions and leave data and state consistent after an interrupted operation.
- Return only the error information needed by the caller; keep sensitive diagnostics in protected operational channels.
- Bound retries, recursion, allocations, queues, and cleanup work to prevent denial of service and cascading failure.

## Verification

- Add or update security-focused tests when behavior crosses a trust boundary or fixes a vulnerability. Include misuse, unauthorized access, malformed input, boundary values, and failure paths relevant to the change.
- Use the project's existing static analysis, dependency scanning, secret scanning, tests, and platform-specific security checks when available.
- Reassess the applicable OWASP categories when architecture, permissions, data sensitivity, dependencies, deployment, or external integrations change.

## References
- [OWASP Top 10 - 2025](https://www.owasptopten.org/)
- [OWASP TOP 10 Project](https://owasp.org/www-project-top-ten/)

## Traceability

When security materially affects an implementation or review, identify the applicable OWASP category and briefly record the chosen control and remaining risk.
