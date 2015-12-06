create or replace function f_split_string(var_str   in string,
                                          var_split In String)
  return t_ret_table is
  var_out     t_ret_table;
  var_tmp     varchar2(4000);
  var_element varchar2(4000);
begin
  var_tmp := var_str;
  var_out := t_ret_table();
  --如果存在匹配的分割符
  while instr(var_tmp, var_split) > 0
  loop
    var_element := substr(var_tmp, 1, instr(var_tmp, var_split) - 1);
    var_tmp     := substr(var_tmp,
                          instr(var_tmp, var_split) + length(var_split),
                          length(var_tmp));
    var_out.extend(1);
    var_out(var_out.count) := var_element;
  end loop;
  var_out.extend(1);
  var_out(var_out.count) := var_tmp;
  return var_out;
end f_split_string;
