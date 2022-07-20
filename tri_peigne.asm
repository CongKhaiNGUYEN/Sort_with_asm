.386

.model flat

.data

tab DWORD 5d, 1d, 3d, 10d, 4d, 25d, 2d
taille DWORD 7d
intervalle DWORD 7d
echange DWORD 1d ; 1 = True / 0 = False
quatre DWORD 4d


.code


tri_peigne proc

	lbl_while:

		; 1ere condition du while
		mov eax, intervalle
		cmp eax, 1d
		ja inside_while

		; 2eme condition du while
		mov eax, echange
		cmp eax, 1d
		jne fin


		inside_while:

		; intervalle = intervalle / 2
		mov edx, 0d ; pour éviter les erreurs integer overflow
		mov eax, intervalle
		mov ecx, 2d
		div ecx
		mov intervalle, eax

		cmp eax, 1d
		jae lbl_endif

		; 1er if
		mov intervalle, 1d

		; fin du if
		lbl_endif:
		mov echange, 0d

		; init for pour le loopz
		mov ecx, taille
		sub ecx, intervalle ; ecx = taille - intervalle

		cmp ecx, 0d
		je fin

		lbl_for:
			; code du for

			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

			; condition du if
			mov ebx, taille
			sub ebx, intervalle
			sub ebx, ecx		; ebx = i

			; array[i]
			mov eax, ebx
			mul quatre ; car on est sur des dword
			mov ebx, eax		; ebx = i * 4

			; array[i + intervalle]
			mov eax, intervalle
			mul quatre ; car on est sur des dword
			add eax, ebx		; eax = (i + intervalle) * 4

			; comparaison
			mov ebx, [tab + ebx]	; ebx = tab[i]
			mov eax, [tab + eax]	; eax = tab[i + intervalle]
			cmp ebx, eax
			jbe lbl_fin_for

			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

			mov ebx, taille
			sub ebx, intervalle
			sub ebx, ecx		; ebx = i

			; array[i]
			mov eax, ebx
			mul quatre ; car on est sur des dword
			mov ebx, eax		; ebx = i * 4

			; array[i + intervalle]
			mov eax, intervalle
			mul quatre ; car on est sur des dword
			add eax, ebx		; eax = (i + intervalle) * 4

			mov ebp, [tab + ebx]		; ebp = temp = tab[i]
			mov edx, [tab + eax]		; edx = array[i + intervalle]
			mov [tab + ebx], edx		; array[i] <- array[i + intervalle]
			mov [tab + eax], ebp	; array[i + intervalle] <- array[i]
			mov echange, 1d		; echange = True

			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

			; condition du fin du for
			lbl_fin_for:
				loop lbl_for


		jmp lbl_while

	fin:
		ret
		

tri_peigne endp

main proc
lea eax, tab

call tri_peigne

nop

main endp

end
