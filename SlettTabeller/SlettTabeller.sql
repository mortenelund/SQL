set serveroutput on
DECLARE
  ok CHAR(30);
  AntTab INTEGER;
  melding CHAR(80);
  CURSOR table_cur IS
	select distinct table_name
  	from dba_tables 
  	WHERE owner = 'AGRESSO' and table_name like 'HAGRESSO%';
BEGIN
  ok := ' tabeller er slettet!';
  AntTab := 0;	
  FOR table_rec IN table_cur
  LOOP
  	dbms_output.put_line ('drop table ' || table_rec.table_name || ' purge');
	execute immediate 'drop table ' || table_rec.table_name || ' purge';
	AntTab := AntTab + 1;
  END LOOP;      
  melding := to_char(AntTab) || ok;
  dbms_output.put_line (melding);
END;
/

