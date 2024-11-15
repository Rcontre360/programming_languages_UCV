# Makefile for Java application

# Variables
JAVAC = javac
JAVA = java
SRC = .
BUILD = build
MAINCLASS = main
GENERATOR_CLASS = ok
GENERATOR_LINES = 19
GENERATOR_N = 5

# Compile Java files into the build directory
build: $(SRC)/*.java
	mkdir -p $(BUILD)
	$(JAVAC) -d $(BUILD) $(SRC)/*.java

# Run the application
run: build
	$(JAVA) -cp $(BUILD) $(MAINCLASS) "./OK_File.txt" $(GENERATOR_N)

# Clean, build and run the app
all: clean build run

# Clean the build directory
clean:
	rm -rf $(BUILD)

generate: build
	$(JAVA) -cp $(BUILD) $(GENERATOR_CLASS) $(GENERATOR_LINES) $(GENERATOR_N)

.PHONY: build run clean all

