#include <stdio.h>

int fibonacci(int n) {
    if (n <= 1) {
        return n;
    } else {
        return fibonacci(n-1) + fibonacci(n-2);
    }
}

int main() {
    int n = 5;
    int result = fibonacci(n);
    printf("Число Фибоначчи под номером %d равно %d\n", n, result);
}