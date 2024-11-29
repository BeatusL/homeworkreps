#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>
#include<limits.h>
#include<sys/wait.h>

const int in = 0; //fileno(stdin)
const int out = 1; //fileno(stdout)

int main(int argc, char* argv[]) {

	if (argc < 3) {
		fprintf(stderr, "Usage %s cmd1 cmd2\n", argv[0]);
		exit(1);
	}

	const int pipe_n = argc - 2;
	const int command_n = argc - 1;

	int fds[pipe_n][2];

	for (int i = 0; i < pipe_n; i++) {
		pipe(fds[i]);
	}

	for (int i = 0; i < command_n; i++) {
		if (fork() == 0) {
			if (i < pipe_n) {
				dup2(fds[i][out], out);
			}
			if (i > 0) {
				dup2(fds[i - 1][in], in);
			}
			for (int j = 0; j < pipe_n; j++) {
				if (j != i) close(fds[j][out]);
				if (j != (i - 1)) close(fds[j - 1][in]);
			}
			execlp(argv[i + 1], argv[i + 1], NULL);
		}
	}

	for (int i = 0; i < pipe_n; i++) {
		close(fds[i][in]);
		close(fds[i][out]);
	}

	for (int i = 0; i < command_n; i++) {
		wait(0);
	}
}
