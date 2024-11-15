## Ejemplo de concurrencia en Java

### Resumen

- No debemos tener todo el archivo en memoria ya que se considera que el mismo es bastante grande. Se usan BufferReaders para leerlo de manera eficiente.
- Ya que el BufferReader se "mueve" en el archivo en cada lectura, se deben tener varios para evitar que un SHA pierda su línea a causa de la lectura de otro SHA. Se tienen tantos buffers como SHAs.
- El monitor (ReadManager) maneja el acceso al archivo y retorna la línea correspondiente a cada SHA.

### Explicacion

Para el archivo generado por OK se tienen varias líneas que deben ser procesadas por distintos SHAs. Para evitar conflictos entre los threads y las líneas que deben de leer, se generara un BufferReader para cada sha en el monitor. Los sha corren de forma concurrente y le piden al monitor la siguiente línea que deben obtener.

El monitor busca la siguiente línea con el BufferReader del respectivo SHA y si encuentra una línea que le corresponda se la retornara. Si no le retornara el EOF y el SHA terminara su ejecución.

Se creyó una clase para generar los archivos OK, aunque esto no es parte de la asignación. La razón de esto es su utilidad para probar el sistema.

### Classes

- Cmd: funciones útiles para retornar la información de ejecución de la línea de comandos.
- LineProcessor: Usa expresiones regulares para obtener el número de línea y la línea en si.
- RandomString: Usado por el generador de archivos (el generador del archivo OK).
- ReadManager: clase monitor encargado de retornar la línea respectiva de cada SHA. Determina cuando los SHA deben terminar (retornando EOF) y se encarga de las operaciones de lectura sobre el archivo.
- Sha: Clase que corre los hilos encargados de procesar cada línea. Espera mientras la línea es procesada y al terminar pide la siguiente línea al ReadManager. Termina el proceso al encontrar EOF.
- main: Clase que inicia el proceso.
- ok: Clase util para generar el archivo OK.

### Observaciones

- El archivo se lee N veces, siendo N el número de SHAs creados.
- La cantidad de memoria usada durante el proceso para leer el archivo es a lo sumo N \* L, siendo N la cantidad de SHAs y L la cantidad de bytes por línea.
- Se piensa que al remover el "synchronized" de la función de lectura del ReadManager el proceso correrá más rápido. Esto es así, ya que al ser sincronizado cada hilo debe esperar al el pedido actual en el ReadManager. Al quitarle esto, varios hilos accederán al archivo al mismo tiempo y no existe peligro de corrupción porque la operación es de solo lectura y el ReadManager solo envía la línea correcta a cada SHA.

### Como usar el sistema

Se ha creado un Makefile para facilitar la prueba del sistema.

- Generar el OK_File.txt: Para generar un archivo OK y a sí mismo poder modificar sus características (cantidad de líneas, número de ids por línea) se deben modificar las siguientes variables en el Makefile.

  - GENERATOR_LINES: cantidad de lineas generadas, valor actual de 50
  - GENERATOR_N: cantidad de Ids posibles. También configura la cantidad de SHAs generados en el comando de inicialización del sistema de procesamiento.

Ejemplos de como correr el comando de generacion:

```
make generate //genera el archivo con la configuracion actual
```

```
make generate GENERATOR_LINES=10 GENERATOR_N=3//genera el archivo con una nueva configuracion
```

- Procesar el archivo OK_File.txt: Para esto es tan sencillo como correr el comando siguiente:

```
make all
```

Esto limpiará el build anterior (si no existe no importa), compilará el sistema y lo correrá. Debería recibir un output similar al siguiente:

```
rm -rf build
mkdir -p build
javac -d build ./*.java
java -cp build main "./OK_File.txt" 8
Line YofRITbqNJeGgWEH5FWmzwR2i processed by SHA: 1
Line 5xJ0MhPOf5v2Xvnz7n1BGPPXd processed by SHA: 0
Line fINumGli6MatRm50dZ1afV3mX processed by SHA: 2
Line sYpakUs8ACTa5BKnVovfbXYaM processed by SHA: 1
Line jaVGTVaFjLGAU8RAx3pnDsVAv processed by SHA: 2
Line 3V8Zbylqbpe6paVcy745YxXlI processed by SHA: 0
Line jTwsDGUC9A9xDD5iui2TjSINq processed by SHA: 1
Line qfPsYTnrwCX5KRShWr9yQeq3c processed by SHA: 2
Line tkNc5oYy5YXsUSMzRN7mcaJPy processed by SHA: 0
Line glQ0fa4kKJUgytyLDRVIhmvHT processed by SHA: 2
```
