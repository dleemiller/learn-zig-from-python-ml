# Adding Curriculum Content

Step-by-step guide for creating new modules in this course. Read this before writing any new module content.

## Before You Start

1. Read **`CURRICULUM.md`** — understand where the new module fits in the course sequence
2. Read **`TODO.md`** — check what's planned and what's already done
3. Review **Module 1 (`01_foundations/`)** as a complete reference implementation — it has every required file
4. Read **`INSTRUCTOR_GUIDELINES.md`** and **`PEDAGOGICAL_FRAMEWORK.md`** — internalize the teaching approach before writing content

## Directory Structure

Every module follows this exact layout:

```
modules/NN_module_name/
├── README.md                    # Module overview, objectives, lesson table
├── syntax_inventory.md          # All syntax taught and required
├── lessons/
│   ├── 01_topic_name.md         # One file per lesson
│   ├── 02_topic_name.md
│   └── ...
├── instructor/
│   ├── 01_guidance.md           # One file per lesson (matching number)
│   ├── 02_guidance.md
│   └── ...
├── exercises/
│   ├── 01_topic_name/
│   │   ├── prompt.md            # What the student sees
│   │   ├── starter.zig          # Skeleton code with TODOs
│   │   ├── solution.zig         # Reference solution (never shown to student)
│   │   └── tests.zig            # Verification tests
│   ├── 02_topic_name/
│   │   └── ...
│   └── ...
└── student_workspace/
    └── .gitkeep                 # Students work here; files created during sessions
```

**Naming conventions:**
- Module directories: `NN_snake_case` (e.g., `03_memory_management`)
- Lesson files: `NN_snake_case.md` (e.g., `01_stack_heap.md`)
- Exercise directories: `NN_snake_case` (e.g., `01_stack_heap`)
- Instructor files: `NN_guidance.md` (always `guidance`, number matches the lesson)

## Step by Step: Creating a Module

### 1. Create the directory structure

```bash
mkdir -p modules/NN_name/{lessons,instructor,exercises,student_workspace}
touch modules/NN_name/student_workspace/.gitkeep
```

### 2. Write the module README

Required sections:

```markdown
# Module N: Title

## Overview
One paragraph describing what this module covers and why it matters.

## Learning Objectives
By the end of this module, you will be able to:
- Objective 1
- Objective 2
- ...

## Prerequisites
- What the student must know before starting (reference prior modules)

## Lessons
| Lesson | Topic | Duration |
|--------|-------|----------|
| N.1 | [Topic](lessons/01_topic.md) | ~XX min |
| N.2 | [Topic](lessons/02_topic.md) | ~XX min |

## Exercises
Each lesson has an associated exercise in the `exercises/` directory:
1. **Name** - Brief description
2. **Name** - Brief description

## Key Python → Zig Concepts
| Python | Zig | Key Difference |
|--------|-----|----------------|
| Python concept | Zig equivalent | What's different |

## What's Next
After completing this module, you'll be ready for:
- **Module N+1**: Title
```

### 3. Write lessons

Each lesson file needs these sections:

```markdown
# Lesson N.X: Title

## Learning Objectives
- [ ] Objective 1
- [ ] Objective 2

## Prerequisites
- What the student needs from earlier lessons

## Content
(Main lesson content with code examples, explanations, and Python comparisons)

## For Python Developers
| Python | Zig | Notes |
|--------|-----|-------|
| Python way | Zig way | Why it's different |

## Common Mistakes
1. Mistake and how to avoid it
2. ...

## Self-Check Questions
1. Question that tests understanding
2. ...

## Exercises
Practice these concepts in [Exercise N.X](../exercises/XX_name/prompt.md).
```

### 4. Write instructor guidance

Each lesson gets a matching guidance file. Required sections:

```markdown
# AI Instructor Guidance: Lesson N.X - Title

## Before Teaching
1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/XX_topic.md` for lesson content
4. Read `syntax_inventory.md` to check what syntax the student has seen

## CRITICAL: Learning Through Struggle
**NEVER write code for the student.** [Brief explanation of why self-discovery
matters for this specific topic.]

## Your Role
You are teaching a Python/ML developer who has completed [prior modules].
[Context about where the student is in their journey.]

## Lesson Objectives
By the end, the student should be able to:
- [ ] Objective 1
- [ ] Objective 2

## Prerequisites Check
Before starting, verify the student understands:
- Prerequisite concept 1
- Prerequisite concept 2

## Teaching Approach

### Key Concepts to Emphasize
1. **Concept** — Why it matters, how to frame it

### Python Bridge Points
| Python Concept | Zig Equivalent | Key Difference |
|----------------|----------------|----------------|
| ... | ... | ... |

### Common Student Questions
**Q: "Question?"**
A: Answer with context.

## Misconception Alerts
- **Misconception**: "Wrong belief"
  **Correction**: Actual truth
  **How to explain**: Approach

## Exercise Facilitation

### Exercise N.X: Name
- **Goal**: What the exercise practices
- **Progressive hints** (if student struggles):
  1. Conceptual nudge (no syntax)
  2. Point toward the right syntax area
  3. Almost-there hint (still no complete answer)
- **Common mistakes to watch for**:
  - Mistake 1
  - Mistake 2

## Debugging Support
| Error/Symptom | Likely Cause | How to Guide Them |
|---------------|--------------|-------------------|
| Error message | What's wrong | Question to ask |

## Pacing Notes
- If breezing through: suggest extension activity
- If struggling: where to slow down
```

**Important rules for guidance files:**
- The Before Teaching checklist and CRITICAL preamble are mandatory in every file
- Progressive hints must never give away the answer — guide, don't tell
- Frame debugging support as questions to ask, not answers to give

### 5. Write exercises

Each exercise has four files:

**`prompt.md`** — What the student sees:
```markdown
# Exercise N.X: Name

## Objective
One sentence describing the goal.

## Requirements
1. Requirement 1
2. Requirement 2

## Expected Output
(Example output if applicable)

## Syntax Reference
These built-ins/concepts are needed. If unfamiliar, review the referenced lesson.
- `syntax` — what it does (where it was taught)

## Concepts Tested
- Concept 1
- Concept 2

## Verification
zig test tests.zig
```

**`starter.zig`** — Skeleton code:
- Include the necessary imports
- Define function signatures with `// TODO:` comments in the body
- Must compile (possibly with unused variable warnings, but no errors)
- Never include solution logic

**`solution.zig`** — Reference implementation:
- Complete, working solution
- Must pass all tests in tests.zig
- Use idiomatic Zig style

**`tests.zig`** — Verification tests:
- Import the student's code: `const exercises = @import("starter.zig");`
- Test every requirement listed in prompt.md
- Use descriptive test names
- Include edge cases where appropriate

### 6. Create syntax_inventory.md

Track all syntax the module teaches and requires:

```markdown
# Module N: Title — Syntax Inventory

## Prerequisites from Module N-1
(List all syntax from prior modules that this module assumes)

## Lesson N.1: Topic
### Introduced (student should be able to produce)
- `syntax` — what it does

### Shown in examples (student should recognize)
- `syntax` — what it does

### Also needed for Exercise N.1
- `syntax` — from which lesson

## Lesson N.2: Topic
...

## NOT YET TAUGHT (common things students might try)
- `syntax` — when it will be taught
```

**Rules:**
- Every piece of syntax used in exercises must appear here (either introduced or as a prerequisite)
- The "Also needed for exercise" section must list everything the exercise requires
- The "NOT YET TAUGHT" section prevents students from jumping ahead

## Connecting to the Course

After creating a module:

1. **Update `TODO.md`** — check off completed items
2. **Verify the previous module's syntax_inventory.md** — it serves as the prerequisite baseline for your new module; make sure it's complete and accurate
3. **Update the previous module's "What's Next" section** — link to the new module
4. **Run the verification checklist** in `modules/CURRICULUM_VERIFICATION.md`

## Style and Conventions

- **One concept per lesson** — manage cognitive load (see PEDAGOGICAL_FRAMEWORK.md)
- **Every lesson needs a "For Python Developers" table** — the student is a Python developer; bridge constantly
- **Never put solutions in prompts or instructor guidance** — hints only, never complete code
- **Use `zig fmt` style** in all code examples — the student should learn idiomatic formatting from the start
- **Test names should describe behavior** — `test "average of empty slice returns 0"` not `test "test3"`
- **Exercises build within a module** — later exercises can reference concepts from earlier exercises in the same module
- **Keep lessons under ~30 minutes** — split longer topics into multiple lessons
