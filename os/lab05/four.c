
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <regex.h>

int match(const char *string, char *pattern) {
    int    status;
    regex_t    re;

    if (regcomp(&re, pattern, REG_EXTENDED|REG_NOSUB) != 0) {
        return 0;
    }
    status = regexec(&re, string, (size_t) 0, NULL, 0);
    regfree(&re);
    if (status != 0) {
        return 0;
    }
    return 1;
}

void replace_all_occurrences(const char *text, const char *pattern, const 
char *replacement) {
    regex_t regex;
    regmatch_t match;
    size_t new_text_size = strlen(text) + 1;
    char *new_text = (char *)malloc(new_text_size);
    new_text[0] = '\0';
    
    regcomp(&regex, pattern, REG_EXTENDED);

    const char *current = text;
    while (regexec(&regex, current, 1, &match, 0) == 0) {
        size_t match_start = match.rm_so;
        size_t match_end = match.rm_eo;

        new_text_size += match_start + strlen(replacement) - (match_end - 
match_start);
        new_text = (char *)realloc(new_text, new_text_size);
        strncat(new_text, current, match_start);
        strcat(new_text, replacement);
        current += match_end;
    }
    strcat(new_text, current);
    printf("%s\n", new_text);
    
    regfree(&regex);
    free(new_text);
}

int main(int argc, char *argv[]) {
    const char *regex = argv[1];
    const char *text = argv[2];
    const char *replacement = argv[3];

    replace_all_occurrences(text, regex, replacement);

    return 0;
}

