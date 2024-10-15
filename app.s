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

.globl fondo

// X0 contiene la dirección base del framebuffer

fondo:
    // ---------------- Pintar la mitad superior ----------------
    mov x15, #0            // Inicializar contador de píxeles (X15)
    mov w27, 0x4FDF        // Color de la mitad superior (RGB(139, 239, 251))
    mov x7, #65536         // Total de píxeles para la mitad superior (512 * 256)

pintar_arriba:
    cmp x15, x7            // Comparar si ya pintamos toda la mitad superior
    beq def_abajo            // Si hemos llegado al límite, pasar a la mitad inferior

    sturh w27, [x10]       // Pintar el píxel actual con el color de la mitad superior
    add x10, x10, #2       // Avanzar al siguiente píxel (2 bytes por píxel)
    add x15, x15, #1       // Incrementar el contador de píxeles
    b pintar_arriba              // Repetir para el siguiente píxel

    // ---------------- Pintar la mitad inferior ----------------
def_abajo:
    mov x15, #0            // Reiniciar contador de píxeles (X15)
    mov w27, 0x2CBA        // Color de la mitad inferior (RGB(112, 202, 248))
    mov x7, #65536         // Total de píxeles para la mitad inferior

pintar_abajo:
    cmp x15, x7            // Comparar si ya pintamos toda la mitad inferior
    beq fin                // Si hemos llegado al límite, terminar

    sturh w27, [x10]       // Pintar el píxel actual con el color de la mitad inferior
    add x10, x10, #2       // Avanzar al siguiente píxel (2 bytes por píxel)
    add x15, x15, #1       // Incrementar el contador de píxeles
    b pintar_abajo         // Repetir para el siguiente píxel

fin:
    ret                    // Finalizar función

// X0 contiene la dirección base del framebuffer (NO MODIFICAR)
// X1 contiene la coordenada X1 (columna del punto 1)
// X2 contiene la coordenada Y1 (fila del punto 1)
// X3 contiene la coordenada X2 (columna del punto 2)
// X4 contiene la coordenada Y2 (fila del punto 2)
// X5 contiene la coordenada X3 (columna del punto 3)
// X6 contiene la coordenada Y3 (fila del punto 3)
// X7 contiene la coordenada X4 (columna del punto 4)
// X8 contiene la coordenada Y4 (fila del punto 4)
// W9 contiene el color de 16 bits 

//cabeza
MOV X1, 126         
MOV X2, 82         
MOV X3, 348         
MOV X4, 106
MOV X5, 114
MOV X6, 242
MOV X7, 322
MOV X8, 264         
MOV W5, 0x1B2B     


draw_filled_quadrilateral:

    // Inicializar las coordenadas de las líneas izquierda y derecha
    MOV X11, X1           // Columna inicial de la primera línea (punto 1)
    MOV X12, X3           // Columna inicial de la segunda línea (punto 2)
    
    MOV X13, X2           // Fila inicial
    MOV X14, X6           // Fila final

    // Calcular el incremento de las columnas para cada fila (interpolación)
    // Diferencia entre las columnas de los puntos 1 y 3
    SUB X15, X5, X1       // Diferencia en X entre los puntos 3 y 1
    SUB X16, X8, X2       // Diferencia en Y entre los puntos 3 y 1 (para interpolar en X)

    // Guardar la pendiente en X17 (cuánto se incrementa X en cada fila)
    SDIV X17, X15, X16    // División entera (diferencia en X dividido por diferencia en Y)

    // Diferencia entre las columnas de los puntos 2 y 4
    SUB X18, X7, X3       // Diferencia en X entre los puntos 4 y 2
    SUB X19, X8, X4       // Diferencia en Y entre los puntos 4 y 2 (para interpolar en X)

    // Guardar la pendiente en X20
    SDIV X20, X18, X19

row_loop:
    CMP X13, X14          // Comparar la fila actual con la fila final
    B.GE done             // Si Y >= Y4, termina

    // Calcular la dirección de la fila actual en el framebuffer
    MOV X21, X13          // Copiar Y actual en X21
    LSL X21, X21, #10     // Multiplicar Y por 512 (tamaño de la pantalla en ancho)
    ADD X21, X21, X21     // Multiplicar por 2 (2 bytes por píxel)
    ADD X10, X0, X21      // Dirección base de la fila actual

    // Inicializar las columnas para la fila actual
    MOV X22, X11          // Columna izquierda
    MOV X23, X12          // Columna derecha

col_loop:
    CMP X22, X23          // Comparar la columna izquierda con la derecha
    B.GE next_row         // Si la columna izquierda >= derecha, pasa a la siguiente fila

    // Calcular la dirección del píxel actual
    MOV X24, X22          // Copiar la columna izquierda en X24
    ADD X24, X24, X24     // Multiplicar por 2 (2 bytes por píxel)
    ADD X24, X10, X24     // Dirección del píxel en el framebuffer

    // Escribir el color en la posición actual del framebuffer
    STURH W9, [X24]       // Escribir el color en 16 bits

    // Avanzar a la siguiente columna
    ADD X22, X22, #1      // Incrementar la columna izquierda
    B col_loop            // Repetir para la siguiente columna

next_row:
    // Incrementar las filas y calcular las nuevas posiciones de las columnas
    ADD X13, X13, #1      // Incrementar la fila
    ADD X11, X11, X17     // Incrementar la columna izquierda (con la pendiente)
    ADD X12, X12, X20     // Incrementar la columna derecha (con la pendiente)

    B row_loop            // Repetir para la siguiente fila

done:
    RET                   // Finaliza la función


	// --- Infinite Loop ---	
InfLoop: 
	b InfLoop
