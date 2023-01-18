 #!/bin/bash

rundir=$1
threads=$2

$rundir -m local -j $threads --quiet
