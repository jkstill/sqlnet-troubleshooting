#!/bin/bash


. oraenv <<< c12

export PATH=$PATH:$ORACLE_HOME/jdk/bin
export CLASSPATH=./:$ORACLE_HOME/jdbc/lib/ojdbc6.jar
export CLASSPATH=./:$ORACLE_HOME/jdbc/lib/ojdbc7.jar


#time java -Djava.security.egd=file:/dev/./urandom -Dsecurerandom.source=file:/dev/./urandom  OracleCon
strace -T -tt -f -o jdbc-urandom.trc  java -Djava.security.egd=file:/dev/./urandom -Dsecurerandom.source=file:/dev/./urandom  OracleCon


