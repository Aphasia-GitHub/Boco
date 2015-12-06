create or replace function GetComplainResult(complain_result string,oper_result string)
  RETURN varchar2 is
  Result varchar2(256);
begin
  Result:=null;
  if complain_result is null then
    if instr(oper_result,'�ѽ��_��������',1,1)>0 then
      Result:='�ѽ��_��������';
    elsif instr(oper_result,'�ѽ��_�û�ԭ��',1,1)>0 then
      Result:='�ѽ��_�û�ԭ��';
    elsif instr(oper_result,'�ѽ��_��������',1,1)>0 then
      Result:='�ѽ��_��������';
    elsif instr(oper_result,'�ѽ��_��������',1,1)>0 then
      Result:='�ѽ��_��������';
    elsif instr(oper_result,'�ѽ��_�豸ԭ��',1,1)>0 then
      Result:='�ѽ��_�豸ԭ��';
    elsif instr(oper_result,'�ѽ��_����',1,1)>0 then
      Result:='�ѽ��_����';
    elsif instr(oper_result,'�Ѵ���_�蹤�̽��',1,1)>0 then
      Result:='�Ѵ���_�蹤�̽��';
    elsif instr(oper_result,'�Ѵ���_���Ż����',1,1)>0 then
      Result:='�Ѵ���_���Ż����';
    elsif instr(oper_result,'�Ѵ���_�����ݽ��',1,1)>0 then
      Result:='�Ѵ���_�����ݽ��';
    elsif instr(oper_result,'�Ѵ���_�豸ԭ��',1,1)>0 then
      Result:='�Ѵ���_�豸ԭ��';
    elsif instr(oper_result,'�Ѵ���_�û�ԭ��',1,1)>0 then
      Result:='�Ѵ���_�û�ԭ��';
    elsif instr(oper_result,'�Ѵ���_��ȷ�н��ʱ��',1,1)>0 then
      Result:='�Ѵ���_��ȷ�н��ʱ��';
    elsif instr(oper_result,'�Ѵ���_����',1,1)>0 then
      Result:='�Ѵ���_����';
    elsif instr(oper_result,'�Ѵ���_�豸����',1,1)>0 then
      Result:='�Ѵ���_�豸����';
    elsif instr(oper_result,'�ѽ��_�豸����',1,1)>0 then
      Result:='�ѽ��_�豸����';
    elsif instr(oper_result,'�Ѵ���_���ֳ��鿴',1,1)>0 then
      Result:='�Ѵ���_���ֳ��鿴';
    else
      Result:='��';
    end if;
  else
    Result:=complain_result;
  end if;
  return(Result);
end GetComplainResult;
