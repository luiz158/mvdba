-- ALTER SESSION SET optimizer_index_cost_adj=1
-- ALTER SESSION SET "_push_join_predicate_" = TRUE

SELECT /*+ choose */ s.status   "Status"
     , s.username               "DB User"
     , si.sid
     , s.serial#                "Serial#"
     , s.module                 "Module"
     , s.event
     , s.state                  "S.State"
--   , w.state                  "W.State"
     , s.wait_class
     , s.seconds_in_wait        "Sec Wait"
     , area.sql_text
     , p.pid                           -- oracle internal pid (v$process)
     , p.spid                          -- server os pid
     , s.process                "CPID" -- client os pid
     , TO_CHAR(pga_v.value/1024/1024, '9G990D00')   "PGA Mega"
     , TO_CHAR(uga_v.value/1024/1024, '9G990D00')   "UGA Mega"
     , si.physical_reads        "phr"
     , si.consistent_gets       "cgets"
     , si.block_gets            "bgets"
     , si.block_changes         "bchanges"
     , si.consistent_changes    "cchanges"
     , TO_CHAR(s.logon_time, 'yyyy-mm-dd hh24:mi:ss')             "Logon Time"
--   , interval(sysdate - s.logon_time)   "Connect Time"
     , s.action
     , s.osuser                 "Client User"
     , s.sql_address            "Address"
     , s.sql_hash_value         "Sql Hash"
     , lockwait                 "Lock Wait"
     , s.audsid
     , s.machine                "Machine"
     , s.program                "Client Program"
     , p.program                "Server Program"
--   , s.terminal               "Terminal"
--   , s.client_info            "Client Info"
  FROM v$session        s
     , v$process        p
     , v$sess_io        si
     , v$sqlarea        area
     , v$session_wait   w
     , v$statname       pga_n
     , v$sesstat        pga_v
     , v$statname       uga_n
     , v$sesstat        uga_v
 WHERE s.paddr   = p.addr(+)
   AND si.sid(+) = s.sid
   AND w.sid     = s.sid
   AND s.sid             = pga_v.sid
   AND pga_v.STATISTIC#  = pga_n.STATISTIC#
   AND pga_n.NAME        = 'session pga memory'
   AND s.sid             = uga_v.sid
   AND uga_v.STATISTIC#  = uga_n.STATISTIC#
   AND uga_n.NAME        = 'session uga memory'
   AND (s.sql_address    = area.address AND
        s.sql_hash_value = area.hash_value)
-- AND s.status = 'ACTIVE'
   AND s.audsid <> USERENV('SESSIONID') -- exclude my monitoring session
-- and (area.sql_text like '%delete%' or area.sql_text like '%DELETE%')
 ORDER BY s.status, s.event,si.physical_reads DESC -- area.sql_TEXT --
