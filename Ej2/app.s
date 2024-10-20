.globl app
app:
	//---------------- Inicialización GPIO --------------------

	mov w20, PERIPHERAL_BASE + GPIO_BASE     // Dirección de los GPIO.		
	
	// Configurar GPIO 17 como input:
	mov X21,#0
	str w21,[x20,GPIO_GPFSEL1] 		// Coloco 0 en Function Select 1 (base + 4)   	
	
	//---------------- Pintar fondo --------------------
	// X0 contiene la dirección base del framebuffer (NO MODIFICAR)
	
	mov w3, 0xd653    	// marroncito, color del fondo
	mov w6, 0x84e9		// 0x3325 = verde, color de las paredes
	add x10, x0, 0		// X10 contiene la dirección base del framebuffer
loop2:
	mov x2,512         	// Tamaño en Y
loop1:
	mov x1,512         	// Tamaño en X

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

//---------------- Florecitas/Frutitas ---------------------------
// pasillo de afuera
	mov x5, 40 		// centro en y
	mov x12, 40		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xcdde
	BL circuloPista

	mov x5, 40 		// centro en y
	mov x12, 150		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, #0xF800 // rojo
	BL circuloPista

	mov x5, 150 		// centro en y
	mov x12, 40		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22,0xcdde
	BL circuloPista

	mov x5, 250 		// centro en y
	mov x12, 40		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, #0xF800 // rojo
	BL circuloPista

	mov x5, 40 		// centro en y
	mov x12, 250		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xcdde
	BL circuloPista

	mov x5, 350 		// centro en y
	mov x12, 40		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, #0xF800 // rojo
	BL circuloPista

	mov x5, 350 		// centro en y
	mov x12, 40		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xcdde
	BL circuloPista

	mov x5, 460 		// centro en y
	mov x12, 40		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

	mov x5, 40 		// centro en y
	mov x12, 350		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

	mov x5, 460 		// centro en y
	mov x12, 150		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

	mov x5, 460 		// centro en y
	mov x12, 250		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

	mov x5, 460 		// centro en y
	mov x12, 350		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

	mov x5, 40 		// centro en y
	mov x12, 460		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, #0xF800 // rojo
	BL circuloPista

	mov x5, 150 		// centro en y
	mov x12, 460		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, #0xF800 // rojo
	BL circuloPista
	
	mov x5, 250 		// centro en y
	mov x12, 460		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, #0xF800 // rojo
	BL circuloPista

	mov x5, 350 		// centro en y
	mov x12, 460		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, #0xF800 // rojo
	BL circuloPista

// pasillo 2
	mov x5, 100 		// centro en y
	mov x12, 100		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

	mov x5, 100 		// centro en y
	mov x12, 400		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

	mov x5, 400 		// centro en y
	mov x12, 400		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, #0xF800 // rojo
	BL circuloPista

	mov x5, 400 		// centro en y
	mov x12, 100		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xcdde
	BL circuloPista

	mov x5, 100 		// centro en y
	mov x12, 250		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

	mov x5, 250 		// centro en y
	mov x12, 400		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

	mov x5, 400 		// centro en y
	mov x12, 250		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

	mov x5, 250 		// centro en y
	mov x12, 100		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, #0xF800 // rojo
	BL circuloPista

//pasillo 3

	mov x5, 160 		// centro en y
	mov x12, 340		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, #0xF800 // rojo
	BL circuloPista

	mov x5, 160 		// centro en y
	mov x12, 160		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xcdde
	BL circuloPista

	mov x5, 340 		// centro en y
	mov x12, 160		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, #0xF800 // rojo
	BL circuloPista

	mov x5, 340 		// centro en y
	mov x12, 340		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xcdde
	BL circuloPista

//pasillo 4
	mov x5, 220 		// centro en y
	mov x12, 250		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

	mov x5, 250 		// centro en y
	mov x12, 220		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

	mov x5, 250 		// centro en y
	mov x12, 280		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista

	mov x5, 280 		// centro en y
	mov x12, 250		//centro en x 
	mov x26, 60		//radio del circulo al 2
	mov w22, 0xf4b6
	BL circuloPista
//---------------- Fin florecitas/Frutitas ---------------------------


	sturh w3,[x10]	   	// Setear el color del pixel N
	add x10,x10,2	   	// Siguiente pixel
	sub x1,x1,1	   		// Decrementar el contador X
	mov w3, 0xd653
	cbnz x1,loop0	   	// Si no terminó la fila, saltar
	sub x2,x2,1	   		// Decrementar el contador Y	
	cbnz x2,loop1	  	// Si no es la última fila, saltar

// --para que no crashee dice la coti--
delay1: 
	sub x11,x11,#1
	cbnz x11, delay1
	bl inputRead		// Leo el GPIO17 y lo guardo en x21
	add x10, x0, 0		// X10 contiene la dirección base del framebuffer
	mov w3, 0x07E0    	// 0x07E0 = VERDE

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
	sub x7,x1,x12 //x-x_0
	sub x8,x2,x5//(y-y_0)
	mul x7,x7,x7//(x-x_0)^2
	mul x8,x8,x8//(y-y_0)^2
	add x9,x7,x8//(x-x_0)^2 + (y-y_0)^2
		//scvtf d1, x9
		//fsqrt d2,d1
		//fcvtzs x5, d2
	subs xzr, x26, x9
	b.LT volverCircPista 
	mov w3, w22
volverCircPista:
	BR x30
	
	// --- Infinite Loop ---	
InfLoop: 
	b InfLoop
//
	