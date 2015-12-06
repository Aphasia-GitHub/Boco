create or replace function GetComplainResult(complain_result string,oper_result string)
  RETURN varchar2 is
  Result varchar2(256);
begin
  Result:=null;
  if complain_result is null then
    if instr(oper_result,'已解决_网络质量',1,1)>0 then
      Result:='已解决_网络质量';
    elsif instr(oper_result,'已解决_用户原因',1,1)>0 then
      Result:='已解决_用户原因';
    elsif instr(oper_result,'已解决_能力受限',1,1)>0 then
      Result:='已解决_能力受限';
    elsif instr(oper_result,'已解决_工程入网',1,1)>0 then
      Result:='已解决_工程入网';
    elsif instr(oper_result,'已解决_设备原因',1,1)>0 then
      Result:='已解决_设备原因';
    elsif instr(oper_result,'已解决_其它',1,1)>0 then
      Result:='已解决_其它';
    elsif instr(oper_result,'已处理_需工程解决',1,1)>0 then
      Result:='已处理_需工程解决';
    elsif instr(oper_result,'已处理_需优化解决',1,1)>0 then
      Result:='已处理_需优化解决';
    elsif instr(oper_result,'已处理_需扩容解决',1,1)>0 then
      Result:='已处理_需扩容解决';
    elsif instr(oper_result,'已处理_设备原因',1,1)>0 then
      Result:='已处理_设备原因';
    elsif instr(oper_result,'已处理_用户原因',1,1)>0 then
      Result:='已处理_用户原因';
    elsif instr(oper_result,'已处理_无确切解决时间',1,1)>0 then
      Result:='已处理_无确切解决时间';
    elsif instr(oper_result,'已处理_其它',1,1)>0 then
      Result:='已处理_其它';
    elsif instr(oper_result,'已处理_设备故障',1,1)>0 then
      Result:='已处理_设备故障';
    elsif instr(oper_result,'已解决_设备故障',1,1)>0 then
      Result:='已解决_设备故障';
    elsif instr(oper_result,'已处理_需现场查看',1,1)>0 then
      Result:='已处理_需现场查看';
    else
      Result:='无';
    end if;
  else
    Result:=complain_result;
  end if;
  return(Result);
end GetComplainResult;
