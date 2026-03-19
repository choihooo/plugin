---
name: adr-list
description: List all Architecture Decision Records (ADRs) in the project
---

# ADR List Command

This command lists all Architecture Decision Records (ADRs) in your project with their status and key information.

## What it does

Scans the `docs/ADR/` directory and displays:
- ADR number and title
- Current status (Proposed, Accepted, Deprecated, Superseded)
- Creation date
- Brief summary if available

## Usage

```bash
/adr-list
```

## Output Format

```
Architecture Decision Records
==============================

ADR-001: Choose React Framework
Status: Accepted | Date: 2025-01-15
Summary: Decision to use Next.js with TypeScript...

ADR-002: Implement State Management
Status: Proposed | Date: 2025-01-20
Summary: Currently evaluating options...

Total: 2 ADRs (1 Accepted, 1 Proposed)
```

## Filtering

You can filter by status:

```bash
/adr-list --status=Accepted    # Show only accepted ADRs
/adr-list --status=Proposed    # Show only proposed ADRs
/adr-list --status=Deprecated  # Show only deprecated ADRs
```

## Use Cases

- **Project onboarding**: Help new team members understand key decisions
- **Review meetings**: Quick overview of all architectural decisions
- **Impact analysis**: See what decisions might be affected by changes
- **Decision tracking**: Monitor proposed vs accepted decisions

## Best Practices

1. **Keep ADRs up to date**: Update status as decisions progress
2. **Review regularly**: Check if past decisions need revisiting
3. **Link dependencies**: Note which ADRs depend on others
4. **Archive old decisions**: Mark deprecated ADRs but don't delete them

---

**Note**: If no ADRs exist yet, use `/adr-create` to create your first one.
