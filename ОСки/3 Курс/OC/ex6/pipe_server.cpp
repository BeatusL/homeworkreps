/* Программа  pipe_server.cpp */
#include"pipe_local.h"
#include <sys/wait.h>

int main(void) {
    int n, done, dummyfifo, privatefifo, publicfifo;
    static char buffer[PIPE_BUF];
    FILE* fin;
    struct message msg;
    /* Созданиеочередитипа public FIFO */
    mknod(PUBLIC, S_IFIFO | 0666, 0);
    /* Открыть public FIFO начтениеизапись */
    if (((publicfifo = open(PUBLIC, O_RDONLY)) == -1) || (dummyfifo = open(PUBLIC, O_WRONLY | O_NDELAY)) == -1) {
        perror(PUBLIC);
        exit(1);
    }
    /* Сообщение можно прочитать из public конвейера */
    while (read(publicfifo, (char*)&msg, sizeof(msg)) > 0) {
        int pid;
        if ((pid = fork() == 0)) {
            printf("pid: %i", getpid());
            n = done = 0; /* Очистка счетчиков | флагов */
            do {/* Попыткаоткрытия private FIFO */
                if ((privatefifo = open(msg.fifo_name, O_WRONLY | O_NDELAY)) == -1)
                    sleep(3);/* Задержка по времени  */
                else {/* Открытие успешно */
                    fin = popen(msg.cmd_line, "r");/* Исполнение shell cmd, полученной отклиента */
                    write(privatefifo, "\n", 1); /* Подготовка очередного вывода */
                    while ((n = read(fileno(fin), buffer, PIPE_BUF)) > 0) {
                        write(privatefifo, buffer, n);/* Выводв private FIFO кклиенту */
                        memset(buffer, 0x0, PIPE_BUF);/* Очистка буфера */
                    }
                    pclose(fin);
                    close(privatefifo);
                    done = 1;/* Запись произведена успешно */
                }
            } while (++n < 5 && !done);
            if (!done) {/* Указание на неудачный исход */
                write(fileno(stderr), "\nNOTE: server doesn't accessed private FIFO\n", 45);
                exit(1);
            }
            exit(0);
        }
        waitpid(pid, NULL, WNOHANG);
    }
    return 0;
}



/* 
#include "pipe_local.h"
char publicfifo_name[B_SIZ];
int publicfifo;

void signal_int(int the_sig) {
    close(publicfifo);
    printf("Public FIFO closed\n");
    unlink(PUBLIC);
    printf("Public FIFO removed\n");
    exit(0);
}

int main(void) {
    int n, done, dummyfifo, privatefifo;
    static char buffer[PIPE_BUF];
    void signal_int(int);
    signal(SIGINT, signal_int);
    FILE *fin;
    struct message msg;

 
    mknod(PUBLIC, S_IFIFO | 0666, 0);


    if ((publicfifo = open(PUBLIC, O_RDONLY)) == -1 ||
        (dummyfifo = open(PUBLIC, O_WRONLY | O_NDELAY)) == -1) {
        perror(PUBLIC);
        exit(1);
    }


    while (read(publicfifo, (char*)&msg, sizeof(msg)) > 0) {
        if (fork() == 0) {
            signal(SIGINT, SIG_DFL);
            n = done = 0; 
            do {
                
                if ((privatefifo = open(msg.fifo_name, O_WRONLY | O_NDELAY)) == -1)
                    sleep(3); 
                else { 
                    fin = fopen(msg.cmd_line, "r"); 
                    write(privatefifo, "\n", 1); 
                    while ((n = read(fileno(fin), buffer, PIPE_BUF)) > 0) {
                        write(privatefifo, buffer, n); 
                        memset(buffer, 0x0, PIPE_BUF);
                    }
                    pclose(fin);
                    close(privatefifo);
                    done = 1; 
                }
            } while (++n < 5 && !done);

            if (!done) 
                write(fileno(stderr), "\nNOTE: SERVER ** NEVER ** accessed private FIFO\n", 48);
        }
    }
}

*/