#!/bin/sh

sbcl --noinform --eval "(compile-file \"$1\")" --eval "(quit)" > /dev/null
