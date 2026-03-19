---
name: ADR Generator
description: Use this skill when the user needs to make important architectural, technical, or design decisions that should be documented. Automatically activates when: asking for opinions on implementation approaches, choosing between multiple options, making trade-off decisions, selecting technologies/frameworks, designing system architecture, or discussing significant changes that affect the project structure or direction.
version: 1.0.0
---

# ADR (Architecture Decision Record) Generator

When the user needs to make an important decision that affects the project, help them create a comprehensive ADR document through thoughtful questioning.

## When to Use This Skill

Activate when the user:
- Asks "Which approach should I use?" or "What do you think about X vs Y?"
- Discusses implementation options or alternatives
- Asks for recommendations on technologies, frameworks, or tools
- Considers significant refactoring or architectural changes
- Weighs trade-offs between different approaches
- Asks "How should I structure/design X?"
- Mentions making a decision that "affects the whole project"

## Decision-Making Process

### Phase 1: Identify the Decision Context

Start by understanding what needs to be decided:

```
1. What specific decision are you trying to make?
2. What is the problem or challenge you're trying to solve?
3. What are the constraints or requirements? (technical, business, time, resources)
4. Who are the stakeholders affected by this decision?
5. What is the timeline for making this decision?
```

### Phase 2: Explore Alternatives

Guide the user through identifying and evaluating options:

```
For each alternative, discuss:
- What is this option/approach?
- What are the benefits (pros)?
- What are the drawbacks (cons)?
- What are the risks or concerns?
- What is the implementation complexity?
- What is the long-term maintainability?
- Are there any real-world examples or references?
```

### Phase 3: Deep Analysis

Help the user think critically:

```
- What are the trade-offs between options?
- What happens if we're wrong? (reversibility)
- What assumptions are we making?
- What dependencies does this create?
- How does this align with project goals?
- What are the cost implications (development, operational)?
- What expertise do we need?
```

### Phase 4: Decision & Rationale

Help the user commit to a decision:

```
- Based on the analysis, which option do you choose?
- Why is this the best choice for your situation?
- What are the key factors that tipped the decision?
- What are you compromising on?
```

### Phase 5: Document Consequences

```
- What needs to happen next? (implementation steps)
- What becomes easier or better?
- What becomes harder or worse?
- What technical debt does this create?
- What follow-up decisions might be needed?
- How will we validate this was the right choice?
```

## ADR Document Structure

Create the ADR in this format:

```markdown
# ADR-[number]: [Decision Title]

**Status:** Accepted | Proposed | Deprecated | Superseded
**Date:** YYYY-MM-DD
**Decision Makers:** [Names]
**Related ADRs:** [Links]

## Context

[What is the situation that led to this decision? What problem are we solving?]

## Decision

[State the decision clearly and concisely. What are we going to do?]

## Alternatives Considered

### Option 1: [Name]
- **Pros:** [benefits]
- **Cons:** [drawbacks]
- **Why rejected:** [reason]

### Option 2: [Name]
- **Pros:** [benefits]
- **Cons:** [drawbacks]
- **Why rejected:** [reason]

[Continue for all options considered]

## Rationale

[Why is this the best decision? What criteria led to this choice? What are the key factors?]

## Consequences

### Positive
- [What becomes better/easier]

### Negative
- [What becomes harder/worse]

### Risks
- [What could go wrong]

### Implementation
- [What needs to be done]
- [Estimated effort/timeframe]

## Validation

[How will we verify this was the right decision? What metrics or observations?]

## References

- [Links to relevant docs, discussions, examples]
```

## Implementation Guidelines

### Step 1: Start the Conversation

When a decision-making situation arises, say:

"I notice you're making an important decision about [topic]. This seems like a good candidate for an Architecture Decision Record (ADR).

Let me help you think through this systematically and document it properly. This will help you:
- Clarify your thinking process
- Remember why you made this decision later
- Communicate the decision to others
- Re-evaluate if circumstances change

Shall we start by understanding what decision you're trying to make?"

### Step 2: Ask Thoughtful Questions

Don't just present options—ask deep questions:

- "What problem specifically are you trying to solve?"
- "What would success look like for this decision?"
- "What keeps you up at night about this?"
- "If you choose wrong, how hard would it be to change course?"
- "What are you not saying that might be important?"

### Step 3: Challenge Assumptions

Gently challenge the user's thinking:

- "You mentioned [assumption]. Are you confident that's true?"
- "What if the opposite were true?"
- "Have you considered [unconventional option]?"
- "What would [respected expert] say about this?"

### Step 4: Synthesize and Document

After gathering information:
1. Summarize what you learned
2. Identify the decision criteria
3. Present the analysis clearly
4. Help the user choose
5. Document everything in the ADR format

### Step 5: Create the ADR File

Save the file to: `{PROJECT_ROOT}/docs/ADR/ADR-{number}-{slug}.md`

File naming convention:
- Use sequential numbers: 001, 002, 003...
- Use URL-friendly slugs based on the decision title
- Example: `ADR-001-choose-react-framework.md`

## Best Practices

### Quality over Speed
- Don't rush the process. Good decisions need thorough analysis.
- It's OK to say "Let me think about this" and come back with deeper questions.
- Encourage the user to sleep on important decisions.

### Be Skeptical
- Challenge the user's assumptions respectfully
- Ask "What evidence do we have?" and "How do we know this?"
- Consider second and third-order effects

### Think Long-Term
- Consider not just immediate benefits but long-term maintenance
- Think about how this decision affects future options
- Consider exit strategies and reversibility

### Be Honest
- If you don't know enough about the domain, say so
- Suggest consulting experts or doing research
- Acknowledge uncertainty and risk

### Follow-Up
- Ask "How will we know if this was the right choice?"
- Suggest reviewing the decision after some time
- Encourage updating the ADR if circumstances change

## Example Interaction

**User:** "Should I use Redux or Context API for state management?"

**You:** "That's a great question that deserves careful consideration. Let's think through this systematically and create an ADR to document your decision.

First, help me understand:
1. What's the scale and complexity of your state?
2. How many components need to access this state?
3. How frequently will the state change?
4. What's your team's experience with these tools?
5. Are there any performance concerns?

Based on your answers, we'll evaluate:
- Learning curve and team productivity
- Performance characteristics
- Bundle size impact
- Developer experience
- Long-term maintainability

Let's explore this step by step..."

## Tips for Different Situations

### Technical Decisions
- Focus on implementation details, performance, scalability
- Consider technical debt and maintenance burden
- Look at real-world benchmarks and case studies

### Architecture Decisions
- Think about system boundaries and coupling
- Consider evolution and extensibility
- Evaluate team organizational structure

### Tool/Library Choices
- Consider ecosystem maturity and community support
- Look at update frequency and stability
- Evaluate integration complexity

### Process/Workflow Decisions
- Think about team productivity and communication
- Consider onboarding new team members
- Evaluate tool cost and learning curve

---

Remember: The goal isn't just to make a decision—it's to make a **well-reasoned, documented decision** that you and others can understand and reference in the future. The process of thinking through it systematically is often as valuable as the decision itself.
