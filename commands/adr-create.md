---
name: adr-create
description: Create a new Architecture Decision Record (ADR) document with interactive prompts
---

# ADR Create Command

This command helps you create a new Architecture Decision Record (ADR) document with proper formatting and numbering.

## What it does

1. Creates the `docs/ADR/` directory if it doesn't exist
2. Automatically determines the next sequential ADR number
3. Prompts you for the ADR title
4. Generates a properly formatted ADR file with:
   - Correct numbering (ADR-001, ADR-002, etc.)
   - URL-friendly filename based on title
   - Template with all standard sections
   - Today's date pre-filled

## Usage

Simply run this command and follow the prompts:

```bash
/adr-create
```

You'll be asked to provide:
- **ADR title**: A clear, descriptive title for your decision

## Output

A new ADR file will be created at: `docs/ADR/ADR-{number}-{slug}.md`

Example: `docs/ADR/ADR-001-choose-react-framework.md`

## Next Steps

After creating the ADR file:

1. **Fill in the content**: Edit the file and add your decision details
2. **Update status**: Change from "Proposed" to "Accepted" when decided
3. **Document alternatives**: List all options you considered
4. **Explain rationale**: Clearly explain why you chose this option
5. **Note consequences**: Document positive and negative impacts
6. **Commit to version control**: ADRs should be tracked in git

## ADR Template Structure

The generated file includes:

- **Status**: Proposed, Accepted, Deprecated, or Superseded
- **Date**: Auto-filled with today's date
- **Context**: Background and problem statement
- **Decision**: What you're going to do
- **Alternatives**: Other options you considered
- **Rationale**: Why this is the best choice
- **Consequences**: Positive, negative, risks, implementation
- **Validation**: How to verify it was the right choice
- **References**: Links to relevant resources

## Best Practices

1. **Be specific**: Use clear, descriptive titles
2. **Document early**: Create ADRs when you start considering options
3. **Update regularly**: Keep ADRs current as decisions evolve
4. **Link related ADRs**: Reference decisions that affect each other
5. **Review periodically**: Check if past decisions are still valid

## Example

```bash
/adr-create
# Enter ADR title: Choose between Redux and Context API for state management
# ADR created: docs/ADR/ADR-001-choose-redux-or-context-api.md
```

---

**Tip**: Use the ADR Generator skill for help thinking through decisions. This command just creates the file structure - the skill helps with the actual decision-making process.
