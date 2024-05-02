#include <iostream>
#include "main.h"
#include <cmath>
#include <fstream>
#include <iomanip>

double R;
double R1;
double R2;
double R3;
double E1;
double E2;
double L;
double L1;
double L3;
double C;
double C_result;
double U_exp[11] = {
        -1.000,
        7.777,
        12.017,
        10.701,
        5.407,
        -0.843,
        -5.159,
        -6.015,
        -3.668,
        0.283,
        3.829
};

double abserr = 1e-8;
double relerr = 1e-8;

double quancFun(double x) {
    return (log(1 + x)) / (1 + x * x);
}

double zeroinFun(double x) {
    return exp(x) - 2 * (x - 1) * (x - 1);
}

void rkfFun(double t, double* y, double* dy) {
    dy[0] = (E1 - E2 - y[2] + (y[1] * R2) - (y[0] * (R + R2))) / L1;
    dy[1] = (E2 + y[2] + (y[0] * R2) - (y[1] * (R + R2))) / L3;
    dy[2] = (y[0] - y[1]) / C;
}


void findParams() {

    MATRIX(Q);

    Q[0][0] = 16.0;
    Q[0][1] = -18.0;
    Q[0][2] = 24.0;
    Q[1][0] = -18.0;
    Q[1][1] = 49.0;
    Q[1][2] = -42.0;
    Q[2][0] = 24.0;
    Q[2][1] = -42.0;
    Q[2][2] = 46.0;

    VECTOR(B, 3);
    B[0] = 304.0;
    B[1] = 218.0;
    B[2] = 166;
    INTVECTOR(IPTV, ndim);
    VECTOR(WORK, ndim);
    double cond;
    decomp(ndim, Q, &cond, IPTV, WORK);
    solve(ndim, Q, B, IPTV);
    R = B[0];
    R2 = B[1];
    E2 = B[2];
    R1 = R;
    R3 = R;
    int nofun;
    double errest;
    double flag = 1;
    quanc8(quancFun, 0, 1.0, abserr, relerr, &L, &errest, &nofun, &flag);
    L = L * 0.1469517;
    L1 = L;
    L3 = L;
    double x1 = -1000.0;
    double x2 = 1000.0;
    E1 = Zeroin(zeroinFun, x1, x2, relerr);
    E1 = E1 * 18.75217;

}

double test(double x) {
    return x * x - 3 * x;
}

void printParams() {
    printf("R=%lf\n", R);
    printf("R1=%lf\n", R1);
    printf("R2=%lf\n", R2);
    printf("R3=%lf\n", R3);
    printf("L=%lf\n", L);
    printf("L1=%lf\n", L1);
    printf("L3=%lf\n", L3);
    printf("E1=%lf\n", E1);
    printf("E2=%lf\n", E2);
}

double getDelta(double x) {
    double y[3] = { E1 / R1, 0.0, -1.0 };
    double t_end = 0;
    double work[21];
    int iwork[10];
    int flag = 1;
    double delta = 0.0;
    C = x;
    for (int i = 0; i < 11; ++i) {
        double current_t = i * 0.1 / 1000;
        RKF45(rkfFun, 3, y, &t_end, &current_t, &relerr, &abserr, &flag, work, iwork);
        delta = delta + pow(U_exp[i] - y[2], 2);
    }
    //  std::cout << "Solving a differential equation with C=" << x <<
    //             "  value of the RKF45 flag is " << flag << "\n";
    return sqrt(delta / 11);
}

void calculateC() {
    double count = 0;
    int flag = 0;
    C_result = (fmin(0.5e-6, 2e-6, getDelta, 1e-8, count, flag));
    std::cout << std::fixed << std::setprecision(20) << "C_result = " << " " << C_result << "\n";
}

void writeOutput() {
    std::ofstream outf("output.txt");
    double y[3] = { E1 / R, 0, -1.0 };
    double t_end = 0;
    double work[21];
    int iwork[10];
    int flag = 1;
    printf("calculate with %lf\n", C);
    double current_t = 0.0;
    while (current_t <= 0.00101) {
        RKF45(rkfFun, 3, y, &t_end, &current_t, &relerr, &abserr, &flag, work, iwork);
        std::cout << std::fixed << std::setprecision(14) << current_t << " " << y[2] << "\n";
        current_t += 0.00001;
    }
}



void printResult() {
    std::ofstream outf("output.txt");
    double y[3] = { E1 / R, 0, -1.0 };
    double t_end = 0;
    double work[21];
    int iwork[10];
    int flag = 1;
    std::cout << "__________________________________________\n";
    std::cout << "t(ms)  | OBJECT  |   MODEL    | DIFFERENCE\n";
    std::cout << "__________________________________________\n";
    for (int i = 0; i < 11; ++i) {
        double current_t = i * 0.1 / 1000;
        RKF45(rkfFun, 3, y, &t_end, &current_t, &relerr, &abserr, &flag, work, iwork);

        if (y[2] < 0) {
            std::cout << std::fixed << std::setprecision(4) << current_t << std::setprecision(3) << " |  " << U_exp[i]
                << " | " << std::setprecision(7) << y[2] << " | " << std::abs(y[2] - U_exp[i]) << " " << "\n";
        }
        else {
            if (y[2] > 10.0) {
                std::cout << std::fixed << std::setprecision(4) << current_t << std::setprecision(3) << " |  "
                    << U_exp[i]
                    << " | " << std::setprecision(7) << y[2] << " | " << std::abs(y[2] - U_exp[i]) << " " << "\n";
            }
            else {
                std::cout << std::fixed << std::setprecision(4) << current_t << std::setprecision(3) << " |   "
                    << U_exp[i]
                    << " |  " << std::setprecision(7) << y[2] << " | " << std::abs(y[2] - U_exp[i]) << " "
                    << "\n";
            }

        }

    }
    std::cout << "__________________________________________\n";
}

void writeDeltaOutput() {
    std::ofstream outf("DeltaOutput.txt");
    C = 0.5e-6;
    while (C < 2e-6) {
        outf << std::fixed << std::setprecision(14) << C << " " << getDelta(C) << "\n";
        C += 0.01e-6;
    }
}


int main() {

    findParams();
    printParams();
    calculateC();
    C = C_result;
    printResult();
}
