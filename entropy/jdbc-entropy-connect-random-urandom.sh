#!/bin/bash


. oraenv <<< c12

export PATH=$PATH:$ORACLE_HOME/jdk/bin
export CLASSPATH=./:$ORACLE_HOME/jdbc/lib/ojdbc6.jar


cat <<-EOF

=====================================

First try connecting 5 times forcing
the use of /dev/random for entropy

=====================================

EOF

for i in $(seq 1 5) 
do
	date
	time java -Djava.security.egd=file:/dev/./random -Dsecurerandom.source=file:/dev/random  OracleCon
done

cat <<-EOF

=====================================

Now try connecting 5 times forcing
the use of /dev/urandom for entropy

=====================================

EOF

for i in $(seq 1 5) 
do
	date
	time java -Djava.security.egd=file:/dev/./urandom -Dsecurerandom.source=file:/dev/urandom  OracleCon
done

