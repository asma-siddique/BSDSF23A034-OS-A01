#include <stdio.h>
#include <stdlib.h>
#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

int main() {
    printf("--- Testing String Functions ---\n");
    char str1[100] = "Hello";
    char str2[100] = "World";

    printf("Length of str1: %d\n", mystrlen(str1));
    mystrcpy(str2, str1);
    printf("Copy str1 into str2: %s\n", str2);
    mystrcat(str1, " Students");
    printf("Concatenation result: %s\n", str1);

    printf("\n--- Testing File Functions ---\n");
    FILE* fp = fopen("test.txt", "r");
    if (fp) {
        int lines, words, chars;
        if (wordCount(fp, &lines, &words, &chars) == 0) {
            printf("Lines: %d, Words: %d, Characters: %d\n", lines, words, chars);
        }

        char** matches;
        int count = mygrep(fp, "test", &matches);
        if (count > 0) {
            printf("Lines matching 'test':\n");
            for (int i = 0; i < count; i++) {
                printf("%s", matches[i]);
                free(matches[i]);
            }
            free(matches);
        }
        fclose(fp);
    } else {
        printf("Failed to open test.txt\n");
    }

    return 0;
}
