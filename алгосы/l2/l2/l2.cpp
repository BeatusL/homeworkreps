#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int main()
{
    char name[100];
    char ch;
    FILE *file;
    int count = 0;
    int max_count = 0;

    printf("Type in file name: ");
    scanf_s("%s", name, sizeof(name));

    if (fopen_s(&file, name, "r") != 0) {
        printf("Wrong file name!\n");
        printf("Try adding .txt/.doc\n");
        exit(1);
    }

    while ((ch = fgetc(file)) != EOF) {
        if (isdigit(ch)) {
            count++;
        }
        else {
            if (count > max_count) {
                max_count = count;
            }
            count = 0;
        }
    }

    if (count > max_count) {
        max_count = count;
    }

    fclose(file);
    if (max_count > 0) {
        printf("The longest digit-only substring is %d chars long\n", max_count);
    }
    else {
        printf("There are 0 digits in the file\n");
    }
    return 0;

}
