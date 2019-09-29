# Trabajo Práctico 1 - Organización de Computadoras

## Conjunto de instrucciones MIPS

### Integrantes del grupo:

* Pablo Inoriza - 94986
* Agustín Palmeira - 90856
* Nicolás Álvarez - 93503

### 1. Objetivos

El objetivo de este trabajo es proveer una versión del programa en la que las funciones new orientation y move forward estén codificadas en assembly MIPS32, y comparar su desempeño con el de esas mismas funciones compiladas con diversos grados de optimización.

### 2. Introducción

Este trabajo práctico toma como precendente el Trabajo Práctico 0, que evaluó el desempeño de dos implementaciones posibles de un problema denominado ”La hormiga artista”. Además se ejercitó la instalación de un ambiente capaz de ejecutar programas para distintas variantes de la arquitectura MIPS.
En la clase del 12/9 se presentó la convención de llamadas a funciones a ser utilizada por la práctica. Partiendo desde este punto, se busca extender el trabajo práctico implementando una parte acotada de la funcionalidad en assembly MIPS32.
Al finalizar el trabajo práctico se deben presentar conclusiones relevantes sobre la implementación realizada incluyendo ventajas y desventajas de la implementación en este lenguaje.

### 3. Implementación

En el trabajo práctico anterior, existian dos versiones de las siguientes funciones, implementadas en C. En este trabajo las mismas deben estar codificadas en assembly MIPS32, respetando el ABI de la cátedra.

**orientation_t new_orientation(orientation_t orientation, rotation_t rule);**

**ant_t* move_forward(ant_t* ant, uint32_t width, uint32_t height);**

