# Quadratic
compile-quadratic-lexer: quadratic.l 
	lex -o quadratic.yy.c quadratic.l
compile-quadratic-parser: quadratic.l quadratic.y
	yacc -o quadratic.tab.c quadratic.y
compile-quadratic: compile-quadratic-lexer compile-quadratic-parser

build-quadratic-lexer: compile-quadratic-lexer
	gcc quadratic.yy.c -ll -o quadratic-l.a
build-quadratic: compile-quadratic
	gcc quadratic.yy.c quadratic.tab.c -ll -o quadratic.a

# Heron
compile-heron-lexer: heron.l heron.y
	lex -o heron.yy.c heron.l
compile-heron-parser: heron.l heron.y
	yacc -o heron.tab.c heron.y
compile-heron: compile-heron-lexer compile-heron-parser

build-heron-lexer: compile-heron-lexer
	gcc heron.yy.c -ll -o heron-l.a
build-heron: compile-heron
	gcc heron.yy.c -ll -o heron.a

# 
build-all: build-quadratic build-heron
clean:
	rm *.yy.c
	rm *.a
