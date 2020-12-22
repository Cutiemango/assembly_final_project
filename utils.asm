INCLUDE Irvine32.inc

.data
randNum BYTE 0

.code
InitRandom PROC USES eax
    INVOKE GetTickCount
    mov randNum, al
    ret
InitRandom ENDP

GetRandom PROC
    mov ax, 25173
    mul BYTE PTR randNum
    add ax, 13849
    xor ah, ah
    mov randNum, al
    ret
GetRandom ENDP
END