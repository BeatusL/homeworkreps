#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
int main() {
	int i;
	FILE* f = fopen("test_file.txt", "rt");
	if (fork()) {
		sleep(2);
		char buffer[5];
		fread(buffer, 1, 5, f);
		puts(buffer);
	}
	else {
		char buffer[5];
		fread(buffer, 1, 5, f);
		puts(buffer);
	}
}