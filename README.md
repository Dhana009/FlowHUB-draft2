# FlowHUB-draft2

Project repository for FlowHUB with comprehensive SDLC rules, commands, and AgenticRag integration.

## Repository Structure

```
FlowHUB-draft2/
├── docs/                          # Documentation
│   ├── agenticrag/               # AgenticRag documentation and issue analysis
│   ├── test-results/             # Historical test results and reports
│   └── AGENTICRAG_TEST_SUITE.md  # Main test suite (if exists)
├── project_rules_commands/       # Project rules and commands
│   ├── project+rules/           # Project layer rules (.mdc files)
│   ├── project_commands/        # Project-specific commands
│   ├── user_commands/           # User-invokable commands
│   └── user_rules/              # User rules (.mdc files)
└── LinkedIn/                     # LinkedIn-related documentation
```

## Quick Links

- [Documentation](./docs/) - All project documentation
- [Latest Test Results](./docs/test-results/SERVER_RESTART_TEST_RESULTS.md) - Most recent AgenticRag test results
- [AgenticRag Test Suite](./docs/AGENTICRAG_TEST_SUITE.md) - Main test suite (if available)
- [Project Rules](./project_rules_commands/) - All project rules and commands

## Key Documentation

### AgenticRag
- [Test Results](./docs/test-results/) - All test results and reports
- [Issue Analysis](./docs/agenticrag/) - Issues and solutions for AgenticRag, Qdrant, and Graphiti

### Project Rules
- [Rules Reference](./project_rules_commands/RULES_AND_COMMANDS_REFERENCE.md) - Quick reference for all rules
- [Project Rules](./project_rules_commands/project+rules/) - Layer-specific rules
- [User Rules](./project_rules_commands/user_rules/done/) - User rules and constraints

## Status

✅ **AgenticRag Status:** Production Ready
- All routing issues fixed
- 100% validation pass rate
- All tests passing (9.5/10)