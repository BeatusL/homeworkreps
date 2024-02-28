#include <iostream>
#include <vector>

int main() {
    int N, M;
    std::cout << "\x1b[33mEnter the number of rows (N): \x1b[0m";
    std::cin >> N;
    std::cout << "\x1b[33mEnter the number of columns (M): \x1b[0m";
    std::cin >> M;

    std::vector<std::vector<int>> A(N, std::vector<int>(M));
    std::vector<int> B(3);

    std::cout << "\x1b[33mEnter the elements of array A:\x1b[0m" << std::endl;
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < M; ++j) {
            std::cin >> A[i][j];
        }
    }

    std::cout << "\x1b[33mEnter the elements of array B:\x1b[0m" << std::endl;
    for (int i = 0; i < 3; ++i) {
        std::cin >> B[i];
    }

    bool found = false;
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j <= M - 3; ++j) {
            if (A[i][j] == B[0] && A[i][j + 1] == B[1] && A[i][j + 2] == B[2]) {
                found = true;
                std::cout << "\x1b[32mRow " << i + 1 << " contains the fragment matching array B.\x1b[0m" << std::endl;
                break;
            }
        }
    }

    if (!found) {
        std::cout << "\x1b[31mNo rows contain the fragment matching array B.\x1b[0m" << std::endl;
    }

    return 0;
}
