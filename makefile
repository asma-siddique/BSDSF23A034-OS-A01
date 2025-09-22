CC = gcc
CFLAGS = -Iinclude -fPIC
SRC = src/main.c src/mystrfunctions.c src/myfilefunctions.c
OBJ = obj/main.o obj/mystrfunctions.o obj/myfilefunctions.o
STATIC_LIB = lib/libmyutils.a
DYNAMIC_LIB = lib/libmyutils.so
TARGET_STATIC = bin/client_static
TARGET_DYNAMIC = bin/client_dynamic

all: $(TARGET_DYNAMIC)

obj/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(DYNAMIC_LIB): obj/mystrfunctions.o obj/myfilefunctions.o
	$(CC) -shared -o $@ $^

$(TARGET_DYNAMIC): obj/main.o $(DYNAMIC_LIB)
	$(CC) -o $@ obj/main.o -Llib -lmyutils

clean:
	rm -f obj/*.o bin/* lib/*.a lib/*.so
CC = gcc
CFLAGS = -Iinclude
AR = ar rcs
TARGET = bin/client_static
LIB = lib/libmyutils.a
OBJECTS = obj/main.o
UTIL_OBJECTS = obj/mystrfunctions.o obj/myfilefunctions.o

all: $(TARGET)

# Build executable by linking main.o with static library
$(TARGET): $(OBJECTS) $(LIB)
	$(CC) -o $(TARGET) $(OBJECTS) -Llib -lmyutils

# Build static library
$(LIB): $(UTIL_OBJECTS)
	$(AR) $(LIB) $(UTIL_OBJECTS)

obj/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f obj/*.o bin/* lib/*.a
