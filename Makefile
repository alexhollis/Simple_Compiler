all:
	bison -d --verbose compiler.y
	flex compiler.l
	g++ -std=c++0x *.c *.cpp -o compiler

clean:
	rm compiler