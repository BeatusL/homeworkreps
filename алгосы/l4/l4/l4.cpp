#include <iostream>
#include <vector>
#include <algorithm>

void bubbleSort(std::vector<std::vector<int>>& arr, int& comparisons, int& swaps) {
    int n = arr.size();
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n - i - 1; ++j) {
            comparisons++;
            if (arr[i][j] > arr[i][j + 1]) {
                swaps++;
                std::swap(arr[i][j], arr[i][j + 1]);
            }
        }
    }
}

void selectionSort(std::vector<std::vector<int>>& arr, int& comparisons, int& swaps) {
    int n = arr.size();
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            int min_idx = j;
            for (int k = j + 1; k < n; ++k) {
                comparisons++;
                if (abs(arr[k][i]) < abs(arr[min_idx][i])) {
                    min_idx = k;
                }
            }
            swaps++;
            std::swap(arr[j][i], arr[min_idx][i]);
        }
    }
}

void printArray(const std::vector<std::vector<int>>& arr) {
    for (const auto& row : arr) {
        for (int val : row) {
            std::cout << val << " ";
        }
        std::cout << std::endl;
    }
    std::cout << std::endl;
}

int main() {
    std::vector<std::vector<int>> arr = { {3, -5, 2, -8},
                                         {9, -4, 7, -1},
                                         {6, 0, -2, 4},
                                         {1, -3, 5, -7} };

    std::cout << "Unsorted Array:" << std::endl;
    printArray(arr);

    int comparisons = 0, swaps = 0;

    // Bubble Sort
    bubbleSort(arr, comparisons, swaps);
    std::cout << "Bubble Sorted Array:" << std::endl;
    printArray(arr);
    std::cout << "Bubble Sort Comparisons: " << comparisons << ", Swaps: " << swaps << std::endl;

    // Selection Sort
    comparisons = 0;
    swaps = 0;
    selectionSort(arr, comparisons, swaps);
    std::cout << "Selection Sorted Array:" << std::endl;
    printArray(arr);
    std::cout << "Selection Sort Comparisons: " << comparisons << ", Swaps: " << swaps << std::endl;

    return 0;
}
