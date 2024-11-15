

pascal:
	mkdir pascal
	fpc -opascal/ main.pas
	./pascal/main
	rm -r pascal

# Compile Java files into the build directory
build: ./*.java
	mkdir -p build
	javac -d build ./*.java

# Run the application
run: build
	java -cp build main 

# Clean, build and run the app
java: clean build run

# Clean the build directory
clean:
	rm -rf build


prolog:
	@swipl -s main.pl

