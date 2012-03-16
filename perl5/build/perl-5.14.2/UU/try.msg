I've tried to compile and run the following simple program:

#include <stdio.h>
int main() { printf("Ok\n"); return(0); }

I used the command:

	cc -o try -O2 -fno-strict-aliasing -pipe -fstack-protector -I/usr/local/include -fstack-protector -L/usr/local/lib try.c -lnsl -lgdbm -ldb -ldl -lm -lcrypt -lutil -lc -lgdbm_compat
	 ./try

and I got the following output:

Ok
