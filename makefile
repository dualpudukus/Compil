prefixe=projet

all: y.tab.o lex.yy.o
	gcc y.tab.o lex.yy.o -ly -lfl -o $(prefixe)

y.tab.o: $(prefixe).y
	yacc -d $(prefixe).y
	gcc -c y.tab.c

lex.yy.o: $(prefixe).l y.tab.h
	lex $(prefixe).l
	gcc -c lex.yy.c

clean:
	rm -f *.o ytab.c y.tab.h lexx.yy.c a.out $(prefixe)
