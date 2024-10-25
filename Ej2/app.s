.globl app
app:
	//---------------- Inicialización GPIO --------------------

	mov w20, PERIPHERAL_BASE + GPIO_BASE     // Dirección de los GPIO.		
	
	// Configurar GPIO 17 como input:
	mov X21,#0
	str w21,[x20,GPIO_GPFSEL1] 		// Coloco 0 en Function Select 1 (base + 4)   	

    // Configurar GPIO 2 y 3 como output:
	mov X26,#0x240
	str w26,[x20, 0] 
	
	//---------------- Pintar fondo --------------------
	// X0 contiene la dirección base del framebuffer (NO MODIFICAR)
	
	mov w3, 0xd653    	// marroncito, color del fondo
	mov w6, 0x84e9		// 0x3325 = verde, color de las paredes
	add x10, x0, 0		// X10 contiene la dirección base del framebuffer
loop2:
	mov x2,512         	// Tamaño en Y
loop1:
	mov x1,512         	// Tamaño en X

//-------------- Prendido y apagado inicial de leds ---------
    mov w26, 0x4
	bl outputOff
	mov w26, 0x8
	bl outputOn

//---------------- Cuadrados/Paredes --------------------
loop0:
// primer cuadrado
	mov x15, 500// esquina en x rect
	mov x16, 500 // esquina en y rect
	mov x17, 500 // ancho
	mov x18, 500// alto
	mov w22, w6  // pared
	BL rectangulo

	mov x15, 480// esquina en x rect
	mov x16, 480 // esquina en y rect
	mov x17, 460 // ancho
	mov x18, 460// alto
	mov w22, 0xd653
	BL rectangulo

//segundo cuadrado
	mov x15, 440// esquina en x rect
	mov x16, 440 // esquina en y rect
	mov x17, 380 // ancho
	mov x18, 380// alto
	mov w22, w6  // pared
	BL rectangulo

	mov x15, 420// esquina en x rect
	mov x16, 420 // esquina en y rect
	mov x17, 340 // ancho
	mov x18, 340// alto
	mov w22, 0xd653
	BL rectangulo

//tercer cuadrado
	mov x15, 380// esquina en x rect
	mov x16, 380 // esquina en y rect
	mov x17, 260 // ancho
	mov x18, 260// alto
	mov w22, w6  // pared
	BL rectangulo

	mov x15, 360// esquina en x rect
	mov x16, 360// esquina en y rect
	mov x17, 220 // ancho
	mov x18, 220// alto
	mov w22, 0xd653
	BL rectangulo
// cuarto cuadrado
	mov x15, 320// esquina en x rect
	mov x16, 320 // esquina en y rect
	mov x17, 140 // ancho
	mov x18, 140// alto
	mov w22, w6  // pared
	BL rectangulo

	mov x15, 300// esquina en x rect
	mov x16, 300// esquina en y rect
	mov x17, 100 // ancho
	mov x18, 100// alto
	mov w22, 0xd653
	BL rectangulo
//quinto cuadrado
	mov x15, 260// esquina en x rect
	mov x16, 260 // esquina en y rect
	mov x17, 20 // ancho
	mov x18, 20// alto
	mov w22, w6  // pared
	BL rectangulo

// Primera pared
	mov x15, 381// esquina en x rect
	mov x16, 203 // esquina en y rect
	mov x17, 110 // ancho
	mov x18, 30// alto
	mov w22, 0x84e9
	BL rectangulo

// Segunda pared
	mov x15, 77// esquina en x rect
	mov x16, 374 // esquina en y rect
	mov x17, 110// ancho
	mov x18, 30// alto
	mov w22, 0x84e9
	BL rectangulo

// Tercera pared
	mov x15, 20// esquina en x rect
	mov x16, 269 // esquina en y rect
	mov x17, 110// ancho
	mov x18, 30// alto
	mov w22, 0x84e9
	BL rectangulo
//---------------- Fin paredes ---------------------------

//---------------- Borrado de paredes --------------------
//Primer cuadrado
	mov x15, 21// esquina en x rect
	mov x16, 275 // esquina en y rect
	mov x17, 60 // ancho
	mov x18, 60// alto
	mov w22, 0xd653
	BL rectangulo

	mov x15, 503// esquina en x rect
	mov x16, 275 // esquina en y rect
	mov x17, 60 // ancho
	mov x18, 60// alto
	mov w22, 0xd653
	BL rectangulo

//Segundo cuadrado
	mov x15, 441// esquina en x rect
	mov x16, 350 // esquina en y rect
	mov x17, 60 // ancho
	mov x18, 60// alto
	mov w22, 0xd653
	BL rectangulo

	mov x15, 441// esquina en x rect
	mov x16, 200 // esquina en y rect
	mov x17, 60 // ancho
	mov x18, 60// alto
	mov w22,0xd653
	BL rectangulo

	mov x15, 81// esquina en x rect
	mov x16, 200 // esquina en y rect
	mov x17, 60 // ancho
	mov x18, 60// alto
	mov w22, 0xd653
	BL rectangulo


//Tercer cuadrado
	mov x15, 280// esquina en x rect
	mov x16, 140 // esquina en y rect
	mov x17, 60 // ancho
	mov x18, 60// alto
	mov w22, 0xd653
	BL rectangulo

	mov x15, 280// esquina en x rect
	mov x16, 383 // esquina en y rect
	mov x17, 60 // ancho
	mov x18, 60// alto
	mov w22, 0xd653
	BL rectangulo

//Cuarto cuadrado
	mov x15, 200// esquina en x rect
	mov x16, 280 // esquina en y rect
	mov x17, 60 // ancho
	mov x18, 60// alto
	mov w22, 0xd653
	BL rectangulo
//---------------- Fin borrado ---------------------------

//------------------ Florecitas ---------------------------
mov x28, 8     // var que guarda la cant de flores que quedan por comer
// pasillo de afuera
	mov x5, 150 		// centro en y
	mov x12, 40		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22,0xcdde
	BL circuloPista

	mov x5, 350 		// centro en y
	mov x12, 40		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xcdde
	BL circuloPista

	mov x5, 460 		// centro en y
	mov x12, 350		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

// pasillo 2
	mov x5, 100 		// centro en y
	mov x12, 100		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

	mov x5, 400 		// centro en y
	mov x12, 250		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

//pasillo 3
	mov x5, 160 		// centro en y
	mov x12, 160		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xcdde
	BL circuloPista

	mov x5, 340 		// centro en y
	mov x12, 340		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xcdde
	BL circuloPista

//pasillo 4
	mov x5, 250 		// centro en y
	mov x12, 280		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

//---------------- Fin florecitas/Frutitas ---------------------------

//---------------- Pintado del laberinto -----------------------------
	sturh w3,[x10]	   	// Setear el color del pixel N
	add x10,x10,2	   	// Siguiente pixel
	sub x1,x1,1	   		// Decrementar el contador X
	mov w3, 0xd653
	cbnz x1,loop0	   	// Si no terminó la fila, saltar
	sub x2,x2,1	   		// Decrementar el contador Y	
	cbnz x2,loop1	  	// Si no es la última fila, saltar
//---------------- Fin pintado -------------------------------------


//---------------- Pintado del personaje ---------------------------
posicion_inicial_personaje: //setea posicion inicial del personaje
	mov x7, 500
	mov x12, 250

check_flores: //verifica si quedan flores por comer, si quedan->no hace nada, si no quedan->prende led verde
	cbnz x28, posicion_nueva_personaje   
	mov w26, 0x4
	bl outputOn    
	mov w26, 0x8
	bl outputOff   

posicion_nueva_personaje:
	mov x1, x7    //posicion x
	mov x2, x12   //posicion y

ladybug: //dibujo el personaje
    // Parámetros de entrada:
    // x1: centro X del círculo
    // x2: centro Y del círculo
    // x3: radio del círculo
	mov x3, 70

    // Caparazón rojo
    mov x3, 35           // Radio del cuerpo rojo
    mov x5, x1           // Centro en Y del caparazón
    mov x6, x2           // Centro en X del caparazón
    mov x26, x3          // Radio del círculo
    mov w22, #0xF800     // Color rojo (RGB 16-bit)
    bl circuloMariquita

    // Puntos negros en la parte superior del caparazón
    mov x3, 7            // Radio de los puntos negros
    mov x26, x3
    mov w22, #0x0000     // Color negro (RGB 16-bit)

    // Primer punto negro
    sub x5, x1, 15       // Desplaza hacia arriba del centro
    sub x6, x2, 10       // Desplaza un poco a la izquierda
    bl circuloMariquita

    // Segundo punto negro
    add x5, x5, 10       // Desplaza un poco hacia abajo
    add x6, x6, 20       // Desplaza a la derecha
    bl circuloMariquita

    // Tercer punto negro
    add x5, x5, 20       // Desplaza más hacia abajo
    sub x6, x6, 15       // Desplaza un poco a la izquierda
    bl circuloMariquita
//------------------------- Fin pintado personaje --------------------

//------------------------- Figuras geometricas -----------------------
rectangulo:
	sub x19, x15, x17 
	sub x23, x16, x18 
	subs xzr, x1, x15
	b.gt volverRect
	subs xzr, x1, x19
	b.lt volverRect
	subs xzr, x2, x16
	b.gt volverRect
	subs xzr, x2, x23
	b.lt volverRect
	mov w3, w22
volverRect:
	BR x30

circuloPista:
	sub x11,x1,x12 //x-x_0
	sub x8,x2,x5//(y-y_0)
	mul x11,x11,x11//(x-x_0)^2
	mul x8,x8,x8//(y-y_0)^2
	add x9,x11,x8//(x-x_0)^2 + (y-y_0)^2
		//scvtf d1, x9
		//fsqrt d2,d1
		//fcvtzs x5, d2
	subs xzr, x26, x9
	b.LT volverCircPista 
	mov w3, w22
volverCircPista:
	BR x30
	
circuloMariquita:
    // Entradas: x1: Y del centro del círculo, x2: X del centro del círculo, x26: Radio al cuadrado del círculo, w22: Color del círculo
    sub x11, x2, x6        // Calcula (x - x_0)
    sub x8, x1, x5         // Calcula (y - y_0)
    mul x11, x11, x11      // (x - x_0)^2
    mul x8, x8, x8         // (y - y_0)^2
    add x9, x11, x8        // (x - x_0)^2 + (y - y_0)^2
    subs xzr, x26, x9      // Comparar con radio^2
    b.LT volverCircMariquita  // Si está fuera del círculo, no dibujar
    
    // Calcula la posición en el framebuffer con origen invertido
    mov x4, #512           // Mover 512 a un registro
    mul x7, x2, x4         // X relativo en framebuffer (multiplica por 512)
    sub x7, x7, x1         // Ajusta la posición Y en framebuffer invertido
    add x7, x7, x7         // Multiplicar x7 por 2 (equivalente a lsl #1)
    add x10, x10, x7       // Sumar base del framebuffer al resultado en x10

    sturh w22, [x10]       // Escribir el color en el framebuffer usando x10

volverCircMariquita: BR x30InfLoop: 
	b InfLoop
//
	