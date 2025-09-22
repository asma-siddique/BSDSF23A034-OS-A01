# Makefile for OS Assignment - Static & Dynamic Builds

CC = gcc
CFLAGS = -Iinclude -Wall
AR = ar
ARFLAGS = rcs

SRC = src/main.c src/mystrfunctions.c src/myfilefunctions.c
OBJ = obj/main.o obj/mystrfunctions.o obj/myfilefunctions.o

BIN_DIR = bin
OBJ_DIR = obj
LIB_DIR = lib

STATIC_LIB = $(LIB_DIR)/libmyutils.a
DYNAMIC_LIB = $(LIB_DIR)/libmyutils.so

STATIC_CLIENT = $(BIN_DIR)/client_static
DYNAMIC_CLIENT = $(BIN_DIR)/client_dynamic

# Default target
all: static dynamic

# =========================
# Static Build
# =========================
static: $(STATIC_CLIENT)

$(STATIC_CLIENT): obj/main.o $(STATIC_LIB)
	$(CC) -o $@ obj/main.o -L$(LIB_DIR) -lmyutils

$(STATIC_LIB): obj/mystrfunctions.o obj/myfilefunctions.o
	$(AR) $(ARFLAGS) $@ $^

# =========================
# Dynamic Build
# =========================
dynamic: $(DYNAMIC_CLIENT)

$(DYNAMIC_CLIENT): obj/main.o $(DYNAMIC_LIB)
	$(CC) -o $@ obj/main.o -L$(LIB_DIR) -lmyutils

$(DYNAMIC_LIB): obj/mystrfunctions.o obj/myfilefunctions.o
	$(CC) -fPIC -shared -o $@ $^

# =========================
# Object files
# =========================
obj/main.o: src/main.c include/mystrfunctions.h include/myfilefunctions.h
	$(CC) $(CFLAGS) -c src/main.c -o $@

obj/mystrfunctions.o: src/mystrfunctions.c include/mystrfunctions.h
	$(CC) $(CFLAGS) -fPIC -c src/mystrfunctions.c -o $@

obj/myfilefunctions.o: src/myfilefunctions.c include/myfilefunctions.h
	$(CC) $(CFLAGS) -fPIC -c src/myfilefunctions.c -o $@

# =========================
# Clean
# =========================
clean:
	rm -f $(OBJ_DIR)/*.o $(BIN_DIR)/* $(LIB_DIR)/*
# Macros
CC = gcc
CFLAGS = -Iinclude -Wall -g
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
TARGET = $(BIN_DIR)/client

SRCS = $(SRC_DIR)/main.c $(SRC_DIR)/mystrfunctions.c $(SRC_DIR)/myfilefunctions.c
OBJS = $(OBJ_DIR)/main.o $(OBJ_DIR)/mystrfunctions.o $(OBJ_DIR)/myfilefunctions.o

# Default target
all: $(TARGET)

# Linking rule
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

# Compilation rule
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean rule
clean:
	rm -f $(OBJ_DIR)/*.o $(TARGET)

# Run rule
run: $(TARGET)
	./$(TARGET)
install: all
	sudo cp $(BIN_STATIC) /usr/local/bin/client
	sudo cp man/man3/client.1 /usr/local/share/man/man3/
	sudo mandb
