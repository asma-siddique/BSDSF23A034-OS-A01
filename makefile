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
