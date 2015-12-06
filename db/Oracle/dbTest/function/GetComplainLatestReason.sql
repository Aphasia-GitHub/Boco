create or replace function GetComplainLatestReason(LatestReason string,problem_reason string)
  RETURN varchar2 is
  Result varchar2(256);
begin
  Result:=null;
  if LatestReason is null then
    if instr(problem_reason,'APԭ��',1,1)>0 then
      Result:='APԭ��';
    elsif instr(problem_reason,'UIM������',1,1)>0 then
      Result:='UIM������';
    elsif instr(problem_reason,'WiFi������',1,1)>0 then
      Result:='WiFi������';
    elsif instr(problem_reason,'�߽�ԭ��',1,1)>0 then
      Result:='�߽�ԭ��';
    elsif instr(problem_reason,'����������',1,1)>0 then
      Result:='����������';
    elsif instr(problem_reason,'��Ƶ��Ⱦ',1,1)>0 then
      Result:='��Ƶ��Ⱦ';
    elsif instr(problem_reason,'��ɽ��ũ��������',1,1)>0 then
      Result:='��ɽ��ũ��������';
    elsif instr(problem_reason,'��������',1,1)>0 then
      Result:='��������';
    elsif instr(problem_reason,'�ֶ�����ԭ��',1,1)>0 then
      Result:='�ֶ�����ԭ��';
    elsif instr(problem_reason,'��������',1,1)>0 then
      Result:='��������';
    elsif instr(problem_reason,'ɽ��ũ��������',1,1)>0 then
      Result:='ɽ��ũ��������';
    elsif instr(problem_reason,'�豸ԭ��',1,1)>0 then
      Result:='�豸ԭ��';
    elsif instr(problem_reason,'�ҷ�ԭ��',1,1)>0 then
      Result:='�ҷ�ԭ��';
    elsif instr(problem_reason,'���߸���',1,1)>0 then
      Result:='���߸���';
    elsif instr(problem_reason,'����Դ',1,1)>0 then
      Result:='����Դ';
    elsif instr(problem_reason,'����ԭ��',1,1)>0 then
      Result:='����ԭ��';
    elsif instr(problem_reason,'�ź�δ����',1,1)>0 then
      Result:='�ź�δ����';
    elsif instr(problem_reason,'�û�ԭ��',1,1)>0 then
      Result:='�û�ԭ��';
    elsif instr(problem_reason,'ԭ�����',1,1)>0 then
      Result:='ԭ�����';
    elsif instr(problem_reason,'�Ż����',1,1)>0 then
      Result:='�Ż����';
    elsif instr(problem_reason,'����',1,1)>0 then
      Result:='����';
    else
      Result:='����';
    end if;
  else
    Result:=LatestReason;
  end if;
  return(Result);
end GetComplainLatestReason;
