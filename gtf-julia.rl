
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
}%%


%% write data;


function isgtf(data)
    %% write init;

    %% write exec;

    return cs >= gtf_first_final
end

@time isgtf(readall(open("sample.gtf")))

