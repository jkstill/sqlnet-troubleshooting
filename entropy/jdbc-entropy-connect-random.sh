#!/bin/bash


. oraenv <<< c12

export PATH=$PATH:$ORACLE_HOME/jdk/bin
export CLASSPATH=./:$ORACLE_HOME/jdbc/lib/ojdbc6.jar


time java -Djava.security.egd=file:/dev/./random -Dsecurerandom.source=file:/dev/./random  OracleCon


