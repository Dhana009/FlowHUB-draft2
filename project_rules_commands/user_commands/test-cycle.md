# test-cycle

✅ **USER COMMAND:** `test_cycle`

## Purpose
Validate the current implementation through real or logical tests, interpret failures intelligently, automatically invoke `debugging_session` when needed, and continue testing until stability is reached or user approval is required. This command guarantees closed-loop testing aligned to the SDLC rules.

## ✔ Behavior (Strict, SDLC-Aligned)

### 1. Understand the Testing Context  
Use recent user instructions, the latest implementation, existing diffs, previous failures, and AgenticRag memory to understand what must be tested. Never assume hidden context.

### 2. Determine What Must Be Tested  
Identify the behaviors, modules, or flows that are expected based on the latest task. Align with requirements and previously confirmed expectations.

### 3. Perform the Tests  
If actual test files exist, simulate running them. If not, perform a logical/behavioral simulation. Do not dump full logs or noise. Output clean summaries only.

### 4. If Tests Pass  
Stop immediately and provide a clear pass summary. Suggest the natural next SDLC step (implementation approval, documentation, or next task).

### 5. If Tests Fail  
Automatically transition into `debugging_session` without asking the user. Testing failure is always followed by debugging.

### 6. Debugging Behavior  
Inside debugging_session:
- identify the error type  
- analyze internal logic  
- consult memory for prior issues  
- use Context7 lookup  
- use Brave or Perplexity only when the problem requires deeper external knowledge  
Debugging proposes conceptual fixes only. No coding or diffs are applied automatically.

### 7. When More Data Is Needed  
Debugging may internally activate:
- `research_topic` for external facts  
- `plan_feature` for structural logic breakdown  
- `generate_todo` for task-level fix breakdown  
These are conditional and triggered only when required, not for every failure.

### 8. Prepare the Fix (But Never Apply It)  
The assistant may present:
- corrected logic description  
- conceptual fix  
- pseudo-diff explanation  
- updated behavior flow  
But actual implementation (`implement_change`) is never invoked without explicit approval.

### 9. Re-run Tests After Proposed Fix  
After proposing a fix, return to test_cycle and simulate the new behavior.  
If tests pass → end.  
If tests fail → repeat debugging intelligently.  
The loop continues until stability.

### 10. Ask for Approval Only When Necessary  
The test cycle stops and asks the user only when one of these actions is required:  
- applying a fix  
- writing memory  
- generating documentation  
Otherwise, test_cycle and debugging_session continue autonomously.

## ✔ Alignment With Global User Rules  
- No code generation  
- No file edits  
- No direct implementation  
- No document creation  
- No automatic memory writes  
- Serena is not invoked (debugging only proposes fixes)  
- Research pipeline is used only when necessary  
- Always routes through SDLC phases correctly  
- Never violates approval rules

## ⭐ SDLC Integration  
- If tests pass → proceed to the next logical SDLC step  
- If tests fail → automatically re-enter `debugging_session`  
- If user initiates implementation → route to `generate_todo` then `implement_change`  
- If test expectations are unclear → route to `define_test_expectations`  
- If system logic needs evaluation → may transition to `plan_feature`

## 🧪 Example (Inline, No Break)
Here is an inline example that does not break session flow: tests indicate that the login flow is failing when incorrect credentials are submitted. Debugging shows the validation branch is not returning the proper error state. A conceptual fix is proposed, and the assistant asks whether to apply it. Once approved, the cycle continues with a re-test.

## Availability  
This command is available in chat as `/test-cycle`.
