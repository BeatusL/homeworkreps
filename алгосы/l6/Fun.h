#pragma once

void matrixQuickSort(int** x, int lines, int columns, int& comparison, int& permutation);
void linesQuickSort(int** x, int l, int r, int line, int& comparison, int& permutation);
void columnsQuickSort(int** x, int l, int r, int column, int& comparison, int& permuation);
void initMatrix(int** x, int lines, int columns);
void deleteMatrix(int** x, int lines);
void clearMatrix(int** x, int** duplicate_x, int lines, int columns);
void reset(int& comparison, int& permutation);

