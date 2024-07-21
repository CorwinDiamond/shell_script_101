#!/bin/bash
echo "foo=\"bar\""
foo="bar"
echo "cmd=\"echo \\\$foo | sed -e 's/a/4/g' -e 's/e/3/g'\""
cmd="echo \$foo | sed -e 's/a/4/g' -e 's/e/3/g'"
echo "echo \$cmd"
echo $cmd
echo "eval \$cmd"
eval $cmd
echo 'foo="Hello World!"'
foo="Hello World!"
eval $cmd