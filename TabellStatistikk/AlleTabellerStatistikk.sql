set serveroutput on
DECLARE
  ok CHAR(20);
  AntTab INTEGER;
  melding CHAR(50);
  CURSOR table_cur IS
	select distinct table_name
  	from dba_tables 
  	WHERE owner = 'AGRESSO' and last_analyzed<(sysdate-1);
BEGIN
  ok := ' er analysert!';
  AntTab := 0;	
  FOR table_rec IN table_cur
  LOOP
	dbms_stats.gather_table_stats( 
	ownname=> 'AGRESSO', 
	tabname=> table_rec.table_name, 
	estimate_percent=> DBMS_STATS.AUTO_SAMPLE_SIZE, 
	cascade=> DBMS_STATS.AUTO_CASCADE, 
	degree=> null, 
	no_invalidate=> DBMS_STATS.AUTO_INVALIDATE, 
	granularity=> 'AUTO', 
	method_opt=> 'FOR ALL COLUMNS SIZE AUTO');
	AntTab := AntTab + 1;
  END LOOP;      
  melding := to_char(AntTab) || ok;
  dbms_output.put_line (melding);
END;
/



