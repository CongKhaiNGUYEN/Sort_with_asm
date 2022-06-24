.386
.model flat
.data
	tab DWORD 33, 45, 10, 99, 43, 65, 71, 59, 9, 8
	; tab DWORD 1, 3, 2, 4
	sizeTab DWORD ?
	permutation DWORD ?
	sens DWORD ?
	encours DWORD ?
	debut DWORD ?
	fin DWORD ?
	deux DWORD 2
	four DWORD 4

.code



triShaker proc

	; permutation = 1
	mov ebx, 1
	mov permutation, ebx

	;sens = 1
	mov eax, 1
	mov sens, eax

	mov eax, 0

	;encours = 0, debut = 0
	mov encours, eax
	mov debut, eax
	mov esi, eax			;esi = 0

	;fin = taille - 2
	mov eax, ecx
	sub eax, deux
	mov fin, eax

	lbl_while:
		;if permutation != 1 end while
		mov	ebx, permutation 
		cmp ebx, 1
		jne fin_while

		;permutation = 0
		mov ebx, 0
		mov permutation, ebx

		boucle_while:



;---------------------------------------------conditions for while boucle ---------------------------------------

;------------------------------------------encours < fin and sens == 1-------------------------------------------

			mov ebx, encours
			mov edx, fin

			;encours > fin then jump to next condition
			cmp ebx, edx
			jae next_if

			;sens != 1 then jump to next condition
			mov ebx, sens
			cmp ebx, 1
			jne next_if

			;if conditions is true then jump to while boucle 
			jmp in_while

;------------------------------------------encours > debut and sens == -1------------------------------------------------
			next_if:

				;if encours > debut not true then end loop
				mov ebx, encours
				mov edx, debut
				cmp ebx, edx

				jbe end_boucle_while

				;if sens != -1 then end loop
				mov ebx, sens
				mov edx, 1
				neg edx
				cmp ebx, edx

				jne end_boucle_while


;---------------------------------------------end conditions for while boucle ---------------------------------------

			in_while:
				
				;if
				mov esi, encours
				mov eax, esi
				mul four
				mov edx, [tab + eax]
				cmp edx, [tab + eax + 4]			; esi + 4 for next DWORD element in tab
				jbe end_condition

					;permutation = 1
					mov ebx, 1
					mov permutation, ebx

					mov esi, encours
					mov eax, esi
					mul four

					mov edx, [tab + eax]
					xchg edx, [tab + eax + 4]
					mov [tab+eax], edx

				;end_if
				end_condition:
				mov eax, encours
				add eax, sens
				mov encours, eax



				jmp boucle_while

		end_boucle_while:
		; if sens != 1 then exec else
		mov ebx, sens
		cmp ebx, 1
		jne con_else
		mov eax, fin
		dec eax
		mov fin, eax
		jmp end_if

		;else 
		con_else:
			mov eax, debut
			dec eax
			mov debut, eax
		end_if:

		;sens = -sens
		mov eax, sens
		neg eax
		mov sens, eax

	jmp lbl_while
	fin_while:
ret
triShaker endp




main proc

mov ecx, LENGTHOF tab		;deplacer la taille de tab dans registeur ecx
mov sizeTab, ecx			;utiliser un variable pour contenir la taille
lea esi, tab
call triShaker

nop
main endp
end

# run with visualstudio