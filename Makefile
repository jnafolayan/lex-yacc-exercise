compile-quadratic: quadratic.l
	lex -o quadratic.yy.c quadratic.l
compile-heron: heron.l
	lex -o heron.yy.c heron.l

build-quadratic: compile-quadratic
	gcc quadratic.yy.c -ll -o quadratic.a
build-heron: compile-heron
	gcc heron.yy.c -ll -o heron.a

build-all: build-quadratic build-heron
clean:
	rm *.yy.c
	rm *.a
