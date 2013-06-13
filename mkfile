
# where patched ragel-7 lives
ragel7=~/prj/ragel-julia/src/ragel

# where ragel-6 lives
ragel6=~/src/ragel-6.8/ragel/ragel

sample.gtf:
    curl -s ftp://ftp.ensembl.org/pub/release-71/gtf/homo_sapiens/Homo_sapiens.GRCh37.71.gtf.gz | gzip -cd | head -n100000 > $target

gtf-t0.jl: gtf-julia.rl
    $ragel7 -T0 -U -o $target $prereq

gtf-t0.c: gtf-c.rl
    $ragel7 -T0 -C -o $target $prereq

gtf-t0: gtf-t0.c
    gcc -O3 -o $target $prereq

gtf-g2.c: gtf-c.rl
    $ragel7 -G2 -C -o $target $prereq

gtf-g2: gtf-g2.c
    gcc -O3 -o $target $prereq

gtf-t0.rb: gtf-rb.rl
    $ragel6 -T0 -R -o $target $prereq


