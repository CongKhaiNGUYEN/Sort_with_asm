.386

.model flat

.data

trois DWORD 3d
quatre DWORD 4d
somme DWORD ?
tab DWORD 4 dup (?)
N DWORD 3

.code

main proc

mov ecx, 3	; N = 3
mov eax, 1	; U0 = 1
mov somme, eax	; initialisation avec U0
mov tab, eax	; initialisation avec U0

call suite

nop
ret

main endp

suite proc

	dec ecx
	mul trois		; 3*U0
	add eax, 2d		; 3*U0 + 2

	add somme, eax ; 2) somme

	mov ebx, eax ; ebx <- Un
	mov eax, N ; eax <- N
	sub eax, ecx ; eax <- N - ecx
	mul quatre	; on multiplie par 4 car on est sur des DWORD
	mov [tab+eax], ebx ; on stocke le Un dans le tab

	mov eax, ebx

	cmp ecx, 0
	je fin

	call suite ; récursivité
		
	fin:	; fin 
		ret

suite endp

end




; Utilisez la récursivité des procédures pour calculer les N premiers termes
; de la suite arithmético-géométrique suivante :
; U_(n) = 3U_(n-1) + 2  avec U0 = 1 
