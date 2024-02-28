#include <iostream>
#include <ctime>
#include <cstdlib>

using namespace std;

void printMatrix(int** matrix, int rows, int cols) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            cout << matrix[i][j] << " ";
        }
        cout << endl;
    }
    cout << endl;
}

void bubbleSort(int* arr, int n) {
    int countCompare = 0, countSwap = 0;
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            countCompare++;
            if (arr[j] > arr[j + 1]) {
                swap(arr[j], arr[j + 1]);
                countSwap++;
            }
        }
    }
    cout << "Bubble Sort: Comparisons = " << countCompare << ", Swaps = " << countSwap << endl;
}

void selectionSort(int* arr, int n) {
    int countCompare = 0, countSwap = 0;
    for (int i = 0; i < n - 1; i++) {
        int minIndex = i;
        for (int j = i + 1; j < n; j++) {
            countCompare++;
            if (arr[j] < arr[minIndex]) {
                minIndex = j;
            }
        }
        if (minIndex != i) {
            swap(arr[minIndex], arr[i]);
            countSwap++;
        }
    }
    cout << "Selection Sort: Comparisons = " << countCompare << ", Swaps = " << countSwap << endl;
}

void insertionSort(int* arr, int n) {
    int countCompare = 0, countSwap = 0;
    for (int i = 1; i < n; i++) {
        int key = arr[i];
        int j = i - 1;
        while (j >= 0 && arr[j] > key) {
            countCompare++;
            arr[j + 1] = arr[j];
            j--;
            countSwap++;
        }
        arr[j + 1] = key;
    }
    cout << "Insertion Sort: Comparisons = " << countCompare << ", Swaps = " << countSwap << endl;
}

void shellSort(int* arr, int n) {
    int countCompare = 0, countSwap = 0;
    for (int gap = n / 2; gap > 0; gap /= 2) {
        for (int i = gap; i < n; i++) {
            int temp = arr[i];
            int j;
            for (j = i; j >= gap && arr[j - gap] > temp; j -= gap) {
                countCompare++;
                arr[j] = arr[j - gap];
                countSwap++;
            }
            arr[j] = temp;
        }
    }
    cout << "Shell Sort: Comparisons = " << countCompare << ", Swaps = " << countSwap << endl;
}

void quickSort(int* arr, int low, int high, int& countCompare, int& countSwap) {
    if (low < high) {
        int pivot = arr[high];
        int i = (low - 1);
        for (int j = low; j <= high - 1; j++) {
            countCompare++;
            if (arr[j] < pivot) {
                i++;
                swap(arr[i], arr[j]);
                countSwap++;
            }
        }
        swap(arr[i + 1], arr[high]);
        countSwap++;
        quickSort(arr, low, i, countCompare, countSwap);
        quickSort(arr, i + 2, high, countCompare, countSwap);
    }
}

void sortMatrix(int** matrix, int rows, int cols) {
    for (int i = 1; i < rows; i += 2) {
        int* row = new int[cols];
        for (int j = 0; j < cols; j++) {
            row[j] = abs(matrix[i][j]);
        }
        bubbleSort(row, cols);
        for (int j = 0; j < cols; j++) {
            matrix[i][j] = (matrix[i][j] < 0 ? -row[j] : row[j]);
        }
        delete[] row;
    }
    for (int j = 0; j < cols; j += 2) {
        int* col = new int[rows];
        for (int i = 0; i < rows; i++) {
            col[i] = matrix[i][j];
        }
        selectionSort(col, rows);
        for (int i = 0; i < rows; i++) {
            matrix[i][j] = col[i];
        }
        delete[] col;
    }
}

int main() {
    srand(time(0));
    int rows = 5, cols = 6;
    int** matrix = new int* [rows];
    for (int i = 0; i < rows; i++) {
        matrix[i] = new int[cols];
        for (int j = 0; j < cols; j++) {
            matrix[i][j] = rand() % 101 - 50;
        }
    }
    cout << "Unsorted matrix:" << endl;
    printMatrix(matrix, rows, cols);

    int** matrixBubble = new int* [rows];
    for (int i = 0; i < rows; i++) {
        matrixBubble[i] = new int[cols];
        copy(matrix[i], matrix[i] + cols, matrixBubble[i]);
    }
    sortMatrix(matrixBubble, rows, cols);
    cout << "Bubble sorted matrix:" << endl;
    printMatrix(matrixBubble, rows, cols);

    int** matrixSelection = new int* [rows];
    for (int i = 0; i < rows; i++) {
        matrixSelection[i] = new int[cols];
        copy(matrix[i], matrix[i] + cols, matrixSelection[i]);
    }
    sortMatrix(matrixSelection, rows, cols);
    cout << "Selection sorted matrix:" << endl;
    printMatrix(matrixSelection, rows, cols);

    int** matrixInsertion = new int* [rows];
    for (int i = 0; i < rows; i++) {
        matrixInsertion[i] = new int[cols];
        copy(matrix[i], matrix[i] + cols, matrixInsertion[i]);
    }
    sortMatrix(matrixInsertion, rows, cols);
    cout << "Insertion sorted matrix:" << endl;
    printMatrix(matrixInsertion, rows, cols);

    int** matrixShell = new int* [rows];
    for (int i = 0; i < rows; i++) {
        matrixShell[i] = new int[cols];
        copy(matrix[i], matrix[i] + cols, matrixShell[i]);
    }
    sortMatrix(matrixShell, rows, cols);
    cout << "Shell sorted matrix:" << endl;
    printMatrix(matrixShell, rows, cols);

    int** matrixQuick = new int* [rows];
    for (int i = 0; i < rows; i++) {
        matrixQuick[i] = new int[cols];
        copy(matrix[i], matrix[i] + cols, matrixQuick[i]);
    }
    sortMatrix(matrixQuick, rows, cols);
    cout << "Quick sorted matrix:" << endl;
    printMatrix(matrixQuick, rows, cols);

    for (int i = 0; i < rows; i++) {
        delete[] matrix[i];
        delete[] matrixBubble[i];
        delete[] matrixSelection[i];
        delete[] matrixInsertion[i];
        delete[] matrixShell[i];
        delete[] matrixQuick[i];
    }
    delete[] matrix;
    delete[] matrixBubble;
    delete[] matrixSelection;
    delete[] matrixInsertion;
    delete[] matrixShell;
    delete[] matrixQuick;

    return 0;
}
