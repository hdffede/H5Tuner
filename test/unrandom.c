/******************************************************/
/*
Filename: unrandom.c
Simply return the same number.

Compile: gcc -shared -fPIC unrandom.c -o unrandom.so

Demonstrate the use of LD_PRELOAD
after compiling set/unset LD_PRELOAD with 
export LD_PRELOAD=$PWD/unrandom.so and export LD_PRELOAD=""
*/
/******************************************************/
int rand(){
    return 42; //return always the same number
}
