
#include <stdlib.h>
#include <stdio.h>

%%{
    machine gtf;

    seqname = [^\t]*;
    source  = [^\t]*;
    feature = [^\t]*;
    start   = digit+;
    end     = digit+;
    score   = '.' |
              [+\-]?
              (
                ' '* digit+ ('.' digit*)? |
                '.' digit+
              )
              ([eE] [+\-]? digit+)?;
    strand  = [+\-.];
    frame   = [012.];

    attribute_tag   = alpha [A-Za-z0-9_]*;
    attribute_value = '"' '"' | '"' [^"\n\r\t]* [^\\] '"' | [^"space]*;
    attribute       = ' '* attribute_tag ' '+ attribute_value;
    attributes      = (attribute ' '* ';')* attribute?;

    gtfline = seqname    '\t'
              source     '\t'
              feature    '\t'
              start      '\t'
              end        '\t'
              score      '\t'
              strand     '\t'
              frame      '\t'
              attributes '\n';

    main := gtfline*;

    write data;
}%%


int main(int argc, char* argv[])
{
    int cs;

    %% write init;

    FILE* in = fopen("sample.gtf", "r");
    if (!in) {
        fprintf(stderr, "Can't open sample.gtf\n");
        return 1;
    }
    const char* p;
    const char* pe;
    const char* eof;
    char buf[1024];
    size_t n;
    while ((n = fread(buf, 1, sizeof(buf), in)) > 0) {
        p   = buf;
        pe  = buf + n;
        eof = n < sizeof(buf) ? pe : 0;
        %% write exec;
        if (cs == gtf_error) break;
    }

    fclose(in);

    if (cs == gtf_error) {
        printf("ERROR\n");
    }
    else if (cs >= gtf_first_final) {
        printf("PASS\n");
    }
    else {
        printf("INCOMPLETE\n");
    }
}


