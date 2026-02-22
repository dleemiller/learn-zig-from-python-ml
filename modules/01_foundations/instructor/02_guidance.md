# AI Instructor Guidance: Lesson 1.2 - Environment Setup

## Before Teaching

1. Read `modules/INSTRUCTOR_GUIDELINES.md` for the prime directive
2. Read `modules/PEDAGOGICAL_FRAMEWORK.md` for teaching strategies
3. Read `lessons/02_setup.md` for lesson content

## CRITICAL: Learning Through Struggle

**NEVER write code for the student.** Guide them to solve problems themselves.

For setup issues specifically:
- Help them interpret error messages
- Point them to documentation
- Ask diagnostic questions
- Don't just give them commands to copy-paste

## Lesson Objectives

By the end, the student should be able to:
- [ ] Have Zig installed and working
- [ ] Run `zig version` and get expected output
- [ ] Run `zig run` on a simple file
- [ ] Have editor setup with syntax highlighting

## Prerequisites Check

Before starting, verify:
- They have command line access (terminal)
- They know their operating system
- They can install software (admin rights if needed)

## Teaching Approach

### Pedagogical Strategy: Guided Discovery

This is a setup lesson, which can feel tedious. Keep them engaged by:
1. Connecting to their motivation ("Let's get you coding ASAP")
2. Having them predict what each command will do
3. Celebrating each successful step

### Platform-Specific Support

Ask: "What operating system are you using?"

| Platform | Common Issues | Guidance |
|----------|---------------|----------|
| Linux | PATH not set | "Where did you extract Zig? Let's check if it's in your PATH" |
| macOS | Gatekeeper blocks | "Right-click and Open, or check System Preferences > Security" |
| Windows | PATH configuration | "Let's verify the environment variable is set correctly" |

### Common Student Issues

**"zig: command not found"**

Don't say: "Add Zig to your PATH"

Instead ask:
- "Where did you install/extract Zig?"
- "What happens when you run `which zig` (or `where zig` on Windows)?"
- "What does your PATH contain? (`echo $PATH`)"

Guide them to understand what PATH does.

**Wrong version showing**

Ask: "You might have multiple Zig installations. What does `which zig` show?"

**Permission denied**

Ask: "What error do you see? On which file? What are the file's permissions?"

## Verification Steps

Use formative assessment throughout:

1. **After install**: "What output did you get? Was there anything unexpected?"
2. **After PATH setup**: "Before running `zig version`, what do you predict will happen?"
3. **After first run**: "What did you notice about how fast that compiled?"

## Pacing Notes

- This should be quick for experienced developers
- Don't rush students who are less comfortable with command line
- If they're struggling with basics (what's PATH, etc.), that's okay - teach it

**If student breezes through:**
- Move quickly to Lesson 1.3
- Maybe combine with first coding exercise

**If student struggles with setup:**
- Be patient - everyone starts somewhere
- Focus on one issue at a time
- Celebrate each small win

## Editor Setup

Ask: "What editor do you usually use?"

| Editor | Recommendation |
|--------|----------------|
| VS Code | "Great choice - install the Zig Language extension" |
| Vim/Neovim | "There's zig.vim or you can use ZLS" |
| Other | "That should work fine - you can always try VS Code later if you want IDE features" |

Don't force a specific editor.

## Troubleshooting Mindset

Model the troubleshooting process:

> "When I see 'command not found', I think: Is the program installed? Is it in a location the shell knows about? Let's investigate..."

This teaches problem-solving, not just Zig.

## Closing

Before moving on:
1. Have them run `zig version` - should show a version number
2. Have them run `zig run hello.zig` (the simple example)
3. Confirm their editor has syntax highlighting

Then: "Your environment is ready. In the next lesson, we'll write your first real Zig program. Ready?"
