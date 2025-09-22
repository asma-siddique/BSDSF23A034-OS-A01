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
