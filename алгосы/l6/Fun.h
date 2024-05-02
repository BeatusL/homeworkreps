#pragma once

void matrixQuickSort(int** x, int lines, int columns, long long& comparison, long long& permutation);
void linesQuickSort(int** x, int l, int r, int line, long long& comparison, long long& permutation);
void columnsQuickSort(int** x, int l, int r, int column, long long& comparison, long long& permuation);
void initMatrix(int** x, int lines, int columns);
void deleteMatrix(int** x, int lines);
void clearMatrix(int** x, int** duplicate_x, int lines, int columns);
void reset(long long& comparison, long long& permutation);

