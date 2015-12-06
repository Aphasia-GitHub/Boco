create or replace function GetComplainLatestReason(LatestReason string,problem_reason string)
  RETURN varchar2 is
  Result varchar2(256);
begin
  Result:=null;
  if LatestReason is null then
    if instr(problem_reason,'AP原因',1,1)>0 then
      Result:='AP原因';
    elsif instr(problem_reason,'UIM卡问题',1,1)>0 then
      Result:='UIM卡问题';
    elsif instr(problem_reason,'WiFi弱覆盖',1,1)>0 then
      Result:='WiFi弱覆盖';
    elsif instr(problem_reason,'边界原因',1,1)>0 then
      Result:='边界原因';
    elsif instr(problem_reason,'城区弱覆盖',1,1)>0 then
      Result:='城区弱覆盖';
    elsif instr(problem_reason,'导频污染',1,1)>0 then
      Result:='导频污染';
    elsif instr(problem_reason,'非山区农村弱覆盖',1,1)>0 then
      Result:='非山区农村弱覆盖';
    elsif instr(problem_reason,'工程受阻',1,1)>0 then
      Result:='工程受阻';
    elsif instr(problem_reason,'局端数据原因',1,1)>0 then
      Result:='局端数据原因';
    elsif instr(problem_reason,'能力受限',1,1)>0 then
      Result:='能力受限';
    elsif instr(problem_reason,'山区农村弱覆盖',1,1)>0 then
      Result:='山区农村弱覆盖';
    elsif instr(problem_reason,'设备原因',1,1)>0 then
      Result:='设备原因';
    elsif instr(problem_reason,'室分原因',1,1)>0 then
      Result:='室分原因';
    elsif instr(problem_reason,'无线干扰',1,1)>0 then
      Result:='无线干扰';
    elsif instr(problem_reason,'无资源',1,1)>0 then
      Result:='无资源';
    elsif instr(problem_reason,'线缆原因',1,1)>0 then
      Result:='线缆原因';
    elsif instr(problem_reason,'信号未覆盖',1,1)>0 then
      Result:='信号未覆盖';
    elsif instr(problem_reason,'用户原因',1,1)>0 then
      Result:='用户原因';
    elsif instr(problem_reason,'原因待查',1,1)>0 then
      Result:='原因待查';
    elsif instr(problem_reason,'优化解决',1,1)>0 then
      Result:='优化解决';
    elsif instr(problem_reason,'其他',1,1)>0 then
      Result:='其他';
    else
      Result:='其它';
    end if;
  else
    Result:=LatestReason;
  end if;
  return(Result);
end GetComplainLatestReason;
