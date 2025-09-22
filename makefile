# ------------------------# Compiler and flags
CC = gcc
CFLAGS = -Iinclude -fPIC
AR = ar rcs

# Files
OBJ = obj/main.o obj/mystrfunctions.o obj/myfilefunctions.o
UTIL_OBJ = obj/mystrfunctions.o obj/myfilefunctions.o

BIN_STATIC = bin/client_static
BIN_DYNAMIC = bin/client_dynamic
LIB_STATIC = lib/libmyutils.a
LIB_DYNAMIC = lib/libmyutils.so

# Default target
all: $(BIN_STATIC) $(BIN_DYNAMIC)

# ------------------------
# Build Static executable
$(BIN_STATIC): obj/main.o $(LIB_STATIC)
	$(CC) -o $@ obj/main.o -Llib -lmyutils

# Build Dynamic executable
$(BIN_DYNAMIC): obj/main.o $(LIB_DYNAMIC)
	$(CC) -o $@ obj/main.o -Llib -lmyutils -Wl,-rpath=lib

# Build Static library
$(LIB_STATIC): $(UTIL_OBJ)
	$(AR) $@ $^

# Build Dynamic library
$(LIB_DYNAMIC): $(UTIL_OBJ)
	$(CC) -shared -o $@ $^

# ------------------------
# Object files
obj/main.o: src/main.c include/mystrfunctions.h include/myfilefunctions.h
	$(CC) $(CFLAGS) -c $< -o $@

obj/mystrfunctions.o: src/mystrfunctions.c include/mystrfunctions.h
	$(CC) $(CFLAGS) -c $< -o $@

obj/myfilefunctions.o: src/myfilefunctions.c include/myfilefunctions.h
	$(CC) $(CFLAGS) -c $< -o $@

# ------------------------
# Clean
clean:
	rm -f obj/*.o bin/* lib/*.a lib/*.so

# ------------------------
# Install
install: all
	sudo cp $(BIN_STATIC) /usr/local/bin/client
	sudo mkdir -p /usr/local/share/man/man3
	sudo cp man/man3/client.1 /usr/local/share/man/man3/
	sudo mandb


