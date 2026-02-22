# Curriculum Verification Checklist

Run through this checklist whenever curriculum content is added or modified. Each section catches a different category of issues.

## 1. Content Completeness

### Lessons
- [ ] Every lesson has: Learning Objectives, Prerequisites, content, For Python Developers table, Common Mistakes, Self-Check questions, Exercises link
- [ ] Lesson numbering is sequential with no gaps (01, 02, 03...)

### Exercises
- [ ] Every exercise has all 4 files: `prompt.md`, `starter.zig`, `solution.zig`, `tests.zig`
- [ ] Exercise numbering matches lesson numbering (exercise 01 corresponds to lesson 01)
- [ ] Every `prompt.md` has: Objective, Requirements, Syntax Reference, Concepts Tested, Verification section

### Instructor Guidance
- [ ] Every lesson has a matching `instructor/NN_guidance.md` file
- [ ] Guidance file numbers match lesson numbers (01_guidance.md for lesson 01)

### Module-Level Files
- [ ] Module has a `README.md` with: Overview, Learning Objectives, Prerequisites, Lessons table, Exercises summary, Key Python → Zig Concepts, What's Next
- [ ] Module has a `syntax_inventory.md`
- [ ] Module has a `student_workspace/` directory with `.gitkeep`

## 2. Syntax Inventory Accuracy

- [ ] Every piece of syntax used in exercises is listed in the inventory (either as "Introduced" in this module or as a prerequisite from a prior module)
- [ ] "Also needed for exercise" sections list all syntax each exercise requires
- [ ] No exercise requires syntax that hasn't been taught yet (check lesson order)
- [ ] Previous module's inventory is still accurate and complete
- [ ] "NOT YET TAUGHT" section lists common syntax students might try that isn't covered yet

## 3. Exercise Verification

### Tests pass with solutions
For each exercise, verify the solution works:
```bash
# In a temporary directory or the student_workspace:
cp solution.zig starter.zig
zig test tests.zig
```
- [ ] All exercise tests pass when `solution.zig` is copied as `starter.zig`

### Starter files compile
- [ ] Every `starter.zig` compiles without errors (unused variable warnings are acceptable for TODO placeholders)

### Prompt-test alignment
- [ ] Every requirement in `prompt.md` is tested by `tests.zig`
- [ ] `tests.zig` doesn't test requirements not listed in `prompt.md`
- [ ] Syntax Reference section in `prompt.md` matches what the solution actually uses

### Test quality
- [ ] Tests have descriptive names (`test "average of empty slice returns 0"` not `test "test1"`)
- [ ] Tests cover edge cases where appropriate
- [ ] Tests import from `starter.zig` (not `solution.zig`)

## 4. Instructor Guidance Consistency

### Required sections present
- [ ] Every guidance file has the 4-item Before Teaching checklist:
  1. Read `modules/INSTRUCTOR_GUIDELINES.md`
  2. Read `modules/PEDAGOGICAL_FRAMEWORK.md`
  3. Read the lesson content
  4. Read `syntax_inventory.md`
- [ ] Every guidance file has the CRITICAL preamble ("NEVER write code for the student")

### Hint quality
- [ ] Progressive hints in Exercise Facilitation never give away the answer
- [ ] Hints progress from conceptual (Level 1) to syntactic (Level 2) to almost-there (Level 3)
- [ ] No hint contains a complete line of solution code

### Debugging support
- [ ] Debugging Support table covers errors the student is likely to hit
- [ ] Guidance column uses questions, not answers ("What type are you passing?" not "Change it to i32")

## 5. Cross-References

- [ ] `CURRICULUM.md` lists the new/updated module and all its lessons
- [ ] `TODO.md` is updated (completed items checked off)
- [ ] `CLAUDE.md` reading list is still correct (no stale references)
- [ ] Previous module's "What's Next" section links to the new module
- [ ] New module's Prerequisites section references the correct prior modules
- [ ] Lesson cross-references (e.g., "see Lesson 1.5") point to files that exist
- [ ] Exercise Syntax Reference sections reference lessons that exist

## 6. No Regressions

### Test all exercises in the modified module
```bash
# Run from each exercise directory:
cp solution.zig starter.zig && zig test tests.zig
```
- [ ] All exercise tests in the modified module pass with solutions

### Content alignment
- [ ] If lesson content changed, exercise prompts still align with what was taught
- [ ] If syntax_inventory changed, exercises don't require unlisted syntax
- [ ] If exercise tests changed, prompt requirements still match

### Cross-module consistency
- [ ] If this module's prerequisites changed, the previous module still teaches everything listed
- [ ] If syntax was moved between lessons, the inventory reflects the new order
