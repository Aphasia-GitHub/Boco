create or replace procedure CheckTwoWay

as
  begin
    EXECUTE IMMEDIATE  'CREATE global temporary TABLE  Temp_TwoWay
    (
      M_INT_ID int,
      M_NAME varchar(200),
      M_PCI int,
      N_INT_ID int,
      N_NAME varchar(200),
      N_PCI_MOD int
    ) 
    on commit preserve rows';
    
    declare
       --类型定义
       cursor c_Items
       is
       select * from(
         select
           m.M_INT_ID,
           m.M_NAME,
           m.M_PCI,
           m.N_INT_ID,
           m.N_NAME,
           m.N_PCI
         from eutranrelation m,eutranrelation n
         where m.m_int_id=n.n_int_id and m.n_int_id=n.m_int_id and  m.n_int_id<>0) 
      where rownum < 11;
       c_row c_Items%rowtype;
       begin
         for c_row in c_Items loop
           insert into Temp_TwoWay
           select 
            m.M_INT_ID,
            m.M_NAME,
            m.M_PCI,
            m.N_INT_ID,
            m.N_NAME,
           mod(m.N_PCI,3) as N_PCI_MOD from eutranrelation m where m.m_int_id=c_row.M_INT_ID;
         end loop;
         end;
  end;
