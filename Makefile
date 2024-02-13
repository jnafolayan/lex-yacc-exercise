compile-quadratic: quadratic.l
	lex -o quadratic.yy.c quadratic.l
build-quadratic: compile-quadratic
	gcc quadratic.yy.c -ll -o quadratic.a

compile-heron: heron.l
	lex -o heron.yy.c heron.l
build-heron: compile-heron
	gcc heron.yy.c -ll -o heron.a
