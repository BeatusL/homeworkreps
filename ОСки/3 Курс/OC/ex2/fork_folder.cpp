#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
int main() {
	int i;
	if (fork()) {
		printf("parent folder before: ");
		puts(get_current_dir_name());
		sleep(2);
		printf("parent folder after: ");
		puts(get_current_dir_name());
	}
	else {
		sleep(1);
		printf("child folder before : ");
		puts(get_current_dir_name());
		chdir("..");
		printf("child folder after : ");
		puts(get_current_dir_name());
	}
}