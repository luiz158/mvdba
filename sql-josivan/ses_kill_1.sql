/*
  SCRIPT:   SES_KILL_1.SQL
  OBJETIVO: MATAR UMA SESSAO NO BANCO
  AUTOR:    JOSIVAN
  DATA:     2000.02.09   
*/

--
-- MATAR UM PROCESSAMENTO NO BANCO
-- PARAMETRO: SID,SERIAL#
-- ONDE SID=10 e SERIAL#=540
--
alter system kill session '10,540'
/

