#include <stdio.h>
#include <math.h>

int main() {
    double x; 
    double a; 

    printf("a := ");
    scanf_s("%lf", &a);

    for (x = -5.8; x <= 26.8; x += 3.1) {
        printf("F value at x=%.1lf: %lf\n", x, sqrt(asin(0.7 + a * cos(x))));
    }

    return 0;
}
