col debugpid new_value debugpid

select s.username, p.spid debugpid
from v$session s, v$process p
where p.addr = s.paddr
and s.username like 'SCOTT'
/
