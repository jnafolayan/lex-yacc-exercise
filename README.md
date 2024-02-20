# Dependencies
- Lex or Flex
- Yacc or Bison

# Installation
## Mac users
If you are on a Mac, you might already have lex and yacc installed along with xcode. To verify, run either command in your terminal. 

If you don't have either, you can install from Homebrew
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
