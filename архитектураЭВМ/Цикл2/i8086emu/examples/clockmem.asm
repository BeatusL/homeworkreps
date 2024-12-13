;----------------------------------------
;Bearbeiter: Joerg Mueller-Hipper, Fred Brodmueller
;
;Ausgabe des Speichers bzw. der Zeit auf der 
;7-Segmentanzeige.
;Rechts steht die Adresse, links Inhalt der Adresse.
;Mit [-] wird die Adresse um 1 verringert, mit [+]
;um 1 erh”ht. Mit [Return] kann die Startadresse
;neugesetzt werden.
;Im Adressmode wird mit der Go Taste die Uhr aktiviert.
;Der Uhrmode wird mit einer beliebigen Taste verlasen.
;
; SI = Anzuzeigende Adresse
;----------------------------------------
;.MODEL TINY
;.CODE
;IDEAL
ORG 100H


;PROGRAM:
;----------------------------------------
start:
	;Hauptprogramm
	call readTime	; Uhr stellen
	call startInt	;Interrupt initialisieren
	call readStart	;Startadresse einlesen
run:
	CMP byte [shwTm], 0	; soll Zeit angezeigt werden?
	je mem
	call printTime	;zeit ausgeben
	mov ah, 0
	int 5
	cmp al, 0
 	je run
 	mov byte [shwTm], 0
mem:
	call write	;Adresse und Inhalt ausgeben
	call readKey	;Tastatureingabe lesen
	jmp run


;----readTime-Begin-------------------------------------
readTime:		;Zeit einlesen
	call printTime	;Zeit ausgeben

	;Tastatur einlesen
	; INIT
	MOV AH, 1
	INT 5
	
	CMP AL, 15h	; out->Stunden setzen
	JNE char1
	mov byte [dspPos], 0	; Stunden edit
char1:
	cmp AL, 14h
	JNE char2
	mov byte [dspPos], 1 ; min edit
char2:
	cmp AL, 13h
	JNE char3
	mov byte  [dspPos], 2	; sec edit
char3:
	cmp AL, 16h	; ++
	JNE char4
	CMP  [dspPos],byte 0	; Stunden edit
	JNE edtMin
	INC byte [hour]
	CMP byte [hour], 24
	JNGE readTime
	MOV byte [hour], 0
edtMin:
	cmp AL, 16h	; +
	JNE char4
	CMP byte [dspPos], 1	; Min edit
	JNE edtSec
	INC byte [min]
	CMP byte[min], 60
	JNGE readTime
	MOV byte [min], 0
edtSec:
	cmp AL, 16h	; +
	JNE char4
	INC byte [sec]		; sec edit
	CMP byte [sec], 60
	JNGE readTime
	MOV byte [sec], 0

char4:
	cmp AL, 10h	; Ret prfen -> ja -> Eingbe verlassen
	JNE readTime
	ret
	
;----PrintTime-Begin-------------------------------------		
printTime:
	;sec ausgeben
	mov CL, [sec]
	mov CH, 0
	call printDec

	;min ausgeben
	mov CL, [min]
	mov CH, 3
	call printDec

	;hour ausgeben
	mov CL, [hour]
	mov CH, 6
	call printDec
				
	mov ah, 1	; - ausgeben
	mov al, '-'
	mov dl, 2
	int 6
	mov dl, 5
	int 6
	
	ret
	
;----printDecimal-Begin-------------------------------------
printDec:
	;Ausgabe von Hex in Dez, CL->Zahl, CH->DisplayStelle
	mov ax, 0
	mov al,CL	;CL(Zahl) in div REG schreiben
	div byte [div10]
	mov bx,ax
	mov ah,1	;ascii zeichen ausgabe activate
	mov dl,CH	;rest (einerstelle)
	add bh,48	;Ascii anpassen
	mov al,bh
	int 6		;Ausgabe rest
	inc CH
	mov dl,CH	;quotient ausgabe
	add bl,48	;Ascii anpassen
	mov al,bl
	int 6
	RET
	
;----readStart-Address-Begin-------------------------------------	
readStart:
	; Reset Display
	MOV AH, 0
	INT 6
	
	; Eingabe Init
	MOV AH, 2
	MOV BX, 0000h
	MOV DL, 3
	INT 5
		
	MOV SI, AX ; Speichern der eingegebenen Zahl
	
	; Reset Display
	MOV AH, 0
	INT 6
	
	ret
	
;----write-Begin-------------------------------------
write:
	;Ausgabe Adresse
	MOV AH, 3
	MOV BX, SI
	MOV DL, 7
	INT 6	
	
	;Ausgabe Inhalt
	MOV AH, 4
	MOV Bl, [SI]
	MOV DL, 1
	INT 6	

	mov ah, 1
	mov al, ' '
	mov dl, 2
	int 6
	mov dl, 3
	int 6
		
	ret
	
;----readKey-Begin-------------------------------------
readKey:
	;Tastatur einlesen
	; INIT
	MOV AH, 1
	INT 5
	
	CMP AL, 16h	; +
	JNE readKeyMinus
	INC SI
	JMP readKeyRet
	
readKeyMinus:
	CMP AL, 17h	; -
	JNE readKeyE
	DEC SI
	JMP readKeyRet
	
readKeyE:
	CMP AL, 10h	; Return
	JNE readKeyGo
	call readStart
	
readKeyGo:
	CMP AL, 11h
	JNE readKeyRet
	MOV byte [shwTm], 1
waitKey:
	mov ah, 0
	int 5
	cmp al, 0
	jne waitKey
	jmp readKeyRet
			
readKeyRet:
	ret
;----readKey-End----------------------------------------

;----Time-----------------------------------------------

;  PROGRAMM EINER INTERRUPTGESTEUERTEN UHR
;  ---------------------------------------
;
startInt:   
	cli              ;Initialisierung
        call IVTABinit   ;  der Vektortabelle

	prePICinit:
	 mov al,00010011b
        out 0c0h,al             ;icw1
        jmp short $+2           ;I/O-Delay
        mov al,00001000b
        out 0c2h,al             ;icw2
;        jmp short $+2           ;I/O-Delay
        mov al,00000001b
        out 0c2h,al             ;icw4 (EOI-Modus)
;        jmp short $+2           ;I/O-Delay
	SetMask: mov al,11111111b
        out 0c2h,al             ;ocw1 (alle Int's gesperrt)
;        jmp short $+2           ;I/O-Delay



        call PICinit     ;  des Interruptcontrollers
        call PITinit     ;  des Zeitgeberschaltkreises
        sti
        ;jmp short hintergrund
        ret
;
;----------------------------------------------------------
;
;Interruptcontroller initialisieren
;----------------------------------
PICinit:
         in al,0c2h       ;Lesen des Int.-Maskenregisters des PIC
         and al,11111110b
         out 0c2h,al      ;
         ret
;
;Zeitgeber initialisieren
;  Interrupt alle 10 ms
;------------------------
zk equ 18432         ;Zeitkonstante fuer 10-ms-Interrupt
PITinit:
         mov al,01110110b
         out 0a6h,al      ;Zaehler 1 im Mode 3
         mov al,zk&0000000011111111b
         out 0a2h,al      ;Low-Teil der Zeitkonstante laden
         mov al,zk>>8
         out 0a2h,al      ;Hi-Teil der Zeitkonstante laden
         ret
;
;----------------------------------------------------------
;
;Vektortabelle initialisieren (Interrupt 8)
;------------------------------------------
IVTABinit:
     
;***** PROGRAMM
; Adresse der ISR (Offset und Segment) in der
; Interrupt-Vektor-Tabelle auf Vektor 8 eintragen
	mov ax,  isr8
	mov [0020h], ax
	mov word [0022h], 0
        ret

;Interruptserviceroutine
;-----------------------
isr8:
	push ax; ev. weitere Register retten
	
	;msec erhoehen
incTime:
	inc byte [msec]
	cmp byte [msec], 100
	jnge isrret
	
	;sec erhoehen
	inc byte [sec]
	mov byte [msec], 0
	cmp byte [sec], 60

	jnge isrret	
	
	;min erhoehen
	inc byte [min]
	mov byte [sec], 0
	cmp byte [min], 60
	jnge isrret
	
	;hour erhoehen
	inc byte [hour]
	mov byte [min], 0
	cmp byte [hour], 24
	jnge isrret

	;24->0h
	mov byte [hour], 0
		
isrret: mov al,20h
        out 0c0h,al      ;PIC wieder freigeben
; ev. gerettete Register zurueckholen
        pop ax
        iret


;----------------------------------------

;-Var.-deklaration-----------------------

msec db 0;
sec db 13;
min db 14;
hour db 15;
div10 db 10;
dspPos db 0;
shwTm db 0;

;END PROGRAM
