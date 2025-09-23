
# Compiler and flags
CC = gcc
CFLAGS = -Iinclude -fPIC
AR = ar rcs

# Paths
SRC = src/main.c src/mystrfunctions.c src/myfilefunctions.c
OBJ = obj/main.o obj/mystrfunctions.o obj/myfilefunctions.o
UTIL_OBJ = obj/mystrfunctions.o obj/myfilefunctions.o

STATIC_LIB = lib/libmyutils.a
DYNAMIC_LIB = lib/libmyutils.so

TARGET_STATIC = bin/client_static
TARGET_DYNAMIC = bin/client_dynamic

# Default: build both executables
all: $(TARGET_STATIC) $(TARGET_DYNAMIC)

# Pattern rule: compile any .c to .o
obj/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Build static library
$(STATIC_LIB): $(UTIL_OBJ)
	$(AR) $(STATIC_LIB) $(UTIL_OBJ)

# Build dynamic library
$(DYNAMIC_LIB): $(UTIL_OBJ)
	$(CC) -shared -o $@ $(UTIL_OBJ)

# Link static executable
$(TARGET_STATIC): obj/main.o $(STATIC_LIB)
	$(CC) -o $@ obj/main.o -Llib -lmyutils

# Link dynamic executable
$(TARGET_DYNAMIC): obj/main.o $(DYNAMIC_LIB)
	$(CC) -o $@ obj/main.o -Llib -lmyutils

# Clean all build files
clean:
	rm -f obj/*.o bin/* lib/*.a lib/*.so

.PHONY: all clean
