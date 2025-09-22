#include "../include/myfilefunctions.h"
#include <stdlib.h>
#include <string.h>

int wordCount(FILE* file, int* lines, int* words, int* chars) {
    if (!file) return -1;

    *lines = *words = *chars = 0;
    char c, prev = ' ';
    while ((c = fgetc(file)) != EOF) {
        (*chars)++;
        if (c == '\n') (*lines)++;
        if ((c == ' ' || c == '\n' || c == '\t') && (prev != ' ' && prev != '\n' && prev != '\t')) {
            (*words)++;
        }
        prev = c;
    }
    rewind(file);
    return 0;
}

int mygrep(FILE* fp, const char* search_str, char*** matches) {
    if (!fp || !search_str) return -1;

    size_t size = 0, capacity = 10;
    *matches = malloc(capacity * sizeof(char*));
    if (!*matches) return -1;

    char buffer[512];
    while (fgets(buffer, sizeof(buffer), fp)) {
        if (strstr(buffer, search_str)) {
            if (size == capacity) {
                capacity *= 2;
                *matches = realloc(*matches, capacity * sizeof(char*));
            }
            (*matches)[size] = strdup(buffer);
            size++;
        }
    }
    rewind(fp);
    return (int)size;
}
