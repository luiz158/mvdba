-- @F:\migracao_sinacor\rev\rev_pk_2.sql

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  set pagesize 0
set longchunksize 32765
set long 1000
set linesize 1000
set trimspool on
set feedback off
set verify off

BEGIN
    DBMS_METADATA.SET_TRANSFORM_PARAM ( DBMS_METADATA.SESSION_TRANSFORM, 'PRETTY'               , TRUE  );
    DBMS_METADATA.SET_TRANSFORM_PARAM ( DBMS_METADATA.SESSION_TRANSFORM, 'SQLTERMINATOR'        , TRUE  );

    DBMS_METADATA.SET_TRANSFORM_PARAM ( DBMS_METADATA.SESSION_TRANSFORM, 'SEGMENT_ATTRIBUTES'   , TRUE  );
    DBMS_METADATA.SET_TRANSFORM_PARAM ( DBMS_METADATA.SESSION_TRANSFORM, 'STORAGE'              , FALSE );
    DBMS_METADATA.SET_TRANSFORM_PARAM ( DBMS_METADATA.SESSION_TRANSFORM, 'TABLESPACE'           , TRUE  );

    DBMS_METADATA.SET_TRANSFORM_PARAM ( DBMS_METADATA.SESSION_TRANSFORM, 'CONSTRAINTS'          , TRUE  );
    DBMS_METADATA.SET_TRANSFORM_PARAM ( DBMS_METADATA.SESSION_TRANSFORM, 'REF_CONSTRAINTS'      , FALSE  );
    DBMS_METADATA.SET_TRANSFORM_PARAM ( DBMS_METADATA.SESSION_TRANSFORM, 'CONSTRAINTS_AS_ALTER' , TRUE  );
END;
/

spool idx02.sql

SELECT 'connect &&1/&&1'||chr(10) from dual;
SELECT 'set echo on'||chr(10) from dual;
SELECT 'spool idx02_res.txt'||chr(10) from dual;

SELECT DBMS_METADATA.GET_DDL('INDEX', index_name, 'CORRWIN'  )
  FROM tmp_cons02
 WHERE 1=1 -- table_name = segment_name
   and 2=2 -- segment_name not like 'BIN$%'

/

SELECT 'spool off'||chr(10) from dual;

spool off

prompt
prompt perl -pi -e 's/ PCTFREE/ --PCTFREE/i' *.{tab,idx}.sql
prompt perl -pi -e 's/;/\n;/'                *.{tab,idx}.sql
prompt

--
-- @F:\work\bradesco.sinacor\tech\sql\rev_cons.sql

exit