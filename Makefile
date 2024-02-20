# Quadratic
compile-quadratic-lexer: quadratic.l quadratic.y
	yacc -d quadratic.y -o quadratic.tab.h
	lex -o quadratic.yy.c quadratic.l
compile-quadratic: compile-quadratic-lexer
	yacc -o quadratic.tab.c quadratic.y

build-quadratic-lexer: compile-quadratic-lexer
	gcc quadratic.yy.c -ll -o quadratic-l.a
build-quadratic: compile-quadratic
	gcc quadratic.yy.c quadratic.tab.c -ll -o quadratic.a

# Heron
compile-heron-lexer: heron.l heron.y
	yacc -d heron.y -o heron.tab.h
	lex -o heron.yy.c heron.l
compile-heron: compile-heron-lexer
	yacc -o heron.tab.c heron.y

build-heron-lexer: compile-heron-lexer
	gcc heron.yy.c -ll -o heron-l.a
build-heron: compile-heron
	gcc heron.yy.c heron.tab.c -ll -o heron.a

# 
build-all: build-quadratic build-heron
clean:
	rm -f *.yy.c
	rm -f *.a
	rm -f *.tab.h
	rm -f *.tab.c
