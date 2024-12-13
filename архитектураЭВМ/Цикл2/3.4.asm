ORG 100H
mov bx, 0180h
mov word [bx], 0001h
mov bx, 0182h
mov word [bx], 0000h
mov bx, 0184h
mov word [bx], 8FFFH
mov ax, 9FFFH
add ax, [bx]
mov bx, 0200h
mov [bx], ax
mov bx, 180h
add ax, [bx]
mov bx, 0182h
adc ax, [bx]
mov bx, 0202h
mov [bx], ax
end: jmp end