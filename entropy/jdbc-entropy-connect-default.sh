#!/bin/bash


. oraenv <<< c12

export PATH=$PATH:$ORACLE_HOME/jdk/bin
#export CLASSPATH=./:$ORACLE_HOME/jdbc/lib/ojdbc6.jar
export CLASSPATH=./:$ORACLE_HOME/jdbc/lib/ojdbc7.jar


#time java  OracleCon
strace -tt -T -f -o jdbc-default.trc  java  OracleCon

