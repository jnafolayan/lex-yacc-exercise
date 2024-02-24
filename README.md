# Dependencies
- Lex or Flex
- Yacc or Bison

# Installation
## Mac users
If you are on a Mac, you might already have lex and yacc installed along with xcode. To verify, run either the `lex` or `yacc` command in your terminal. 

Sometimes xcode might not have them installed or Homebrew might not have its necessary dependencies. If that is the case, run the following
```bash
xcode-select --install
```

If you still don't have either, you can install from Homebrew using
```bash
brew install flex bison
```

# Run
To run the parser for the quadratic formula `x = (-b ± sqrt(b ^ 2 - 4 * a * c)) / (2 * a)`
```bash
make build-quadratic
```

To run the parser for heron's formula `K = sqrt(s * (s - a) * (s - b) * (s - c) * (s - d))`
```bash
make build-heron
```

**Note:** supply any required data in the terminal then proceed to supply the equation.
