#!/bin/bash

time strace -tt -T -o random-entropy.trc dd if=/dev/./random bs=16 iflag=fullblock count=16 of=/dev/null

time strace -tt -T -o urandom-entropy.trc dd if=/dev/./urandom bs=16 iflag=fullblock count=16 of=/dev/null

