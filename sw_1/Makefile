all: main.c
	gcc main.c && ./a.out

debug: main.c
	gcc -DDEBUG main.c && ./a.out

#install: all
#	cp input.txt {VIVADO}

clean: a.out input.txt output.txt
	rm a.out input.txt output.txt
