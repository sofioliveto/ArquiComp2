.globl app
app:

//---------------- Inicialización GPIO --------------------

    mov w20, PERIPHERAL_BASE + GPIO_BASE     // Dirección de los GPIO.      
    
    // Configurar GPIO 17 como input:
    mov X21,#0
    str w21,[x20,GPIO_GPFSEL1]      // Coloco 0 en Function Select 1 (base + 4)     
    
//---------------- Main code --------------------
// X0 contiene la dirección base del framebuffer (NO MODIFICAR)
    
    mov w3, 0x4e5f      // 0x4e5f = celeste oscuro  
    add x10, x0, 0      // X10 contiene la dirección base del framebuffer

loop2:
    mov x2,512          // Tamaño en Y
loop1:
    mov x1,512          // Tamaño en X
loop0:

// dividir fondo
    subs xzr, x2, 256
    b.LT salto
    mov w3, 0x679f //celeste claro
salto:

// borde frente cabeza 
mov x15, 377 // esquina en x
mov x17, 236 // ancho
mov x18, 166 // alto
mov x16, 397 // esquina en y
mov w22, 0xb366 // marron oscuro
BL rectangulo

// borde cuerpo
mov x15, 346 // esquina en x
mov x17, 174 // ancho
mov x18, 134 // alto
mov x16, 239 // esquina en y
mov w22, 0xb366 // marron oscuro
BL rectangulo

// frente cabeza
mov x15, 370 // esquina en x 
mov x17, 222 // ancho
mov x18, 152 // alto
mov x16, 390 // esquina en y
mov w22, 0xe54e // marron claro
BL rectangulo

// cuerpo
mov x15, 339 // esquina en x
mov x17, 160 // ancho
mov x18, 120 // alto
mov x16, 232 // esquina en y
mov w22, 0xe54e // marron claro
BL rectangulo

// ojo der circulo
mov x5, 344         // centro en y
mov x12, 220        //centro en x 
mov x26, 324            //radio del circulo  
mov w22, 0xffff
BL circulo

// ojo izq circulo
mov x5, 344         // centro en y
mov x12, 325        //centro en x 
mov x26, 324            //radio del circulo  
mov w22, 0xffff
BL circulo

sturh w3,[x10]      // Setear el color del pixel N
add x10,x10,2       // Siguiente pixel
sub x1,x1,1         // Decrementar el contador X
mov w3, 0x4e5f
cbnz x1,loop0       // Si no terminó la fila, saltar
sub x2,x2,1         // Decrementar el contador Y    
cbnz x2,loop1       // Si no es la última fila, saltar

InfLoop:
    b InfLoop

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

circulo:
    sub x7,x1,x12 //x-x_0
    sub x8,x2,x5//(y-y_0)
    mul x7,x7,x7//(x-x_0)^2
    mul x8,x8,x8//(y-y_0)^2
    add x9,x7,x8//(x-x_0)^2 + (y-y_0)^2
    //scvtf d1, x9
    //fsqrt d2,d1
    //fcvtzs x5, d2
    subs xzr, x26, x9
    b.LT volverCirc 
    mov w3, w22
volverCirc:
    BR x30


