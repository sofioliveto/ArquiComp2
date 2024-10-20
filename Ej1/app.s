.globl app
app:

//---------------- Inicialización GPIO --------------------

	mov w20, PERIPHERAL_BASE + GPIO_BASE     // Dirección de los GPIO.		
	
	// Configurar GPIO 17 como input:
	mov X21,#0
	str w21,[x20,GPIO_GPFSEL1] 		// Coloco 0 en Function Select 1 (base + 4)   	
	
//---------------- Main code --------------------
// X0 contiene la dirección base del framebuffer (NO MODIFICAR)
	
	mov w3, 0xF800    	// 0xF800 = ROJO	
	add x10, x0, 0		// X10 contiene la dirección base del framebuffer

// X0 contiene la dirección base del framebuffer

fondo:
    // ---------------- Pintar la mitad superior ----------------
    mov x15, #0            // Inicializar contador de píxeles (X15)
    mov w27, 0x4FDF        // Color de la mitad superior (RGB(139, 239, 251))
    mov x7, #131072        // Total de píxeles para la mitad superior (512 * 256)

pintar_arriba:
    cmp x15, x7            // Comparar si ya pintamos toda la mitad superior
    beq def_abajo          // Si hemos llegado al límite, pasar a la mitad inferior

    sturh w27, [x10]       // Pintar el píxel actual con el color de la mitad superior
    add x10, x10, #2       // Avanzar al siguiente píxel (2 bytes por píxel)
    add x15, x15, #1       // Incrementar el contador de píxeles
    b pintar_arriba        // Repetir para el siguiente píxel

    // ---------------- Pintar la mitad inferior ----------------
def_abajo:
    mov x15, #0            // Reiniciar contador de píxeles (X15)
    mov w27, 0x2CBA        // Color de la mitad inferior (RGB(112, 202, 248))
    mov x7, #131072        // Total de píxeles para la mitad inferior

pintar_abajo:
    cmp x15, x7            // Comparar si ya pintamos toda la mitad inferior
    beq fin                // Si hemos llegado al límite, terminar

    sturh w27, [x10]       // Pintar el píxel actual con el color de la mitad inferior
    add x10, x10, #2       // Avanzar al siguiente píxel (2 bytes por píxel)
    add x15, x15, #1       // Incrementar el contador de píxeles
    b pintar_abajo         // Repetir para el siguiente píxel

fin:
    ret                    // Finalizar función


// Framebuffer base address en X10, con las coordenadas en (X1, Y1), (X2, Y2), (X3, Y3), (X4, Y4)
// Y el color en W3 (formato 16-bit RGB)

// draw_filled_rectangle - Entrada: 
// X20 = x1, X1 = y1 (esquina superior izquierda)
// X2 = x2, X3 = y2 (esquina inferior derecha)
// w1 = color de 16 bits
// X10 = dirección base del framebuffer (matriz de píxeles 512x512)

draw_filled_rectangle:
    // Si las coordenadas están invertidas (x2 < x1 o y2 < y1), intercambiarlas
    CMP X20, X2           // Comparar x1 con x2
    B.GT swap_x          // Si x1 > x2, intercambiarlos
    CMP X1, X3           // Comparar y1 con y2
    B.GT swap_y          // Si y1 > y2, intercambiarlos
    B skip_swap          // Saltar el intercambio si no es necesario

swap_x:
    MOV X6, X20           // X6 = x1 (temporal)
    MOV X20, X2           // X0 = x2
    MOV X2, X6           // X2 = x1 (intercambiado)
    
swap_y:
    MOV X6, X1           // X6 = y1 (temporal)
    MOV X1, X3           // X1 = y2
    MOV X3, X6           // X3 = y1 (intercambiado)

skip_swap:
    // Empezar a dibujar el rectángulo
    MOV X7, X1           // Y actual = y1

outer_loop:
    CMP X7, X3           // Comparar Y actual con y2
    B.GT end             // Si Y actual > y2, salir del bucle

    MOV X8, X20           // X actual = x1

inner_loop:
    CMP X8, X2           // Comparar X actual con x2
    B.GT next_row        // Si X actual > x2, ir a la siguiente fila

    // Calcular la dirección del píxel: framebuffer_base + (Y * ancho_pantalla + X) * 2
    MOV X9, X7           // X9 = Y actual
    MUL X9, X9, #512     // Multiplicar Y por el ancho de la pantalla (512 píxeles)
    ADD X9, X9, X8       // Sumar X actual
    LSL X9, X9, #1       // Multiplicar por 2 (cada píxel ocupa 2 bytes)
    ADD X9, X9, X10      // Sumar dirección base del framebuffer

    // Escribir el color en la memoria
    STURH w1, [X9]        // Guardar el color de 16 bits en la dirección calculada

    ADD X8, X8, #1       // X actual += 1
    B inner_loop         // Repetir el bucle interno

next_row:
    ADD X7, X7, #1       // Y actual += 1
    B outer_loop         // Repetir el bucle externo

end:
    RET                  // Retornar

MOV X20, 10         
MOV X1, 10         
MOV X2, 50
MOV X3, 50       
MOV w1, 0xF800
BL draw_filled_rectangle

//cabeza
MOV X20, 136         // Columna de Punto 1 (superior izquierda)
MOV X1, 88          // Fila de Punto 1
MOV X2, 370         // Columna de Punto 3 (inferior derecha)
MOV X3, 277         // Fila de Punto 3       
MOV w1, 0x1B2B     

	// --- Infinite Loop ---	
InfLoop: 
	b InfLoop
//
