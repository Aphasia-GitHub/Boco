/******************************************************************************
    * FileName  :    DTMerge
    * CreateTime:    2015/12/22 11:04:28
    * Author    :    zhengfei@boco.com.cn
    * Remarks   :    
    * Copyright (c) 2015 BOCO Group All Rights Reserved
******************************************************************************/

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace DTLinq
{
    public class DTMerge
    {
        private DataTable _dt1 = null;
        private DataTable _dt2 = null;
        public DataTable DT1
        {
            get
            {
                if (_dt1 == null)
                {
                    _dt1 = new DataTable();
                    _dt1.Columns.Add("Stu1");
                    for (var i = 0; i < 10; i++)
                    {
                        var dr = _dt1.NewRow();
                        dr["Stu1"] = i;
                        _dt1.Rows.Add(dr);
                    }
                }
                return _dt1;
            }
        }

        public DataTable DT2
        {
            get
            {
                if(_dt2 == null)
                {
                    _dt2 = new DataTable();
                    _dt2.Columns.Add("Stu2");
                    for (var i = 10; i > 0; i--)
                    {
                        var dr = _dt2.NewRow();
                        dr["Stu2"] = i;
                        _dt2.Rows.Add(dr);
                    }
                }
                return _dt2;
            }
        }

        public void MergTest1()
        {            

            // Merge
            DataTable dt3 = DT1.Copy();
            dt3.Merge(DT2, true);

            Console.Read();
        }

        //DataTable newDataTable = DataTable1.Clone();
        // DT1 和 DT2 数据条数是一样的
        public DataTable MergTest2()
        {
            var dt = UniteDataTable2(DT1,DT2,"MergeDT");
            return dt;
        }


        /// <summary> 
        /// 将两个列不同(结构不同)的DataTable合并成一个新的DataTable 
        /// </summary> 
        /// <param name="DataTable1">表1</param> 
        /// <param name="DataTable2">表2</param> 
        /// <param name="DTName">合并后新的表名</param> 
        /// <returns>合并后的新表</returns> 
        private DataTable UniteDataTable(DataTable DataTable1, DataTable DataTable2, string DTName)
        {
            //克隆DataTable1的结构
            DataTable newDataTable = DataTable1.Clone();
            for (int i = 0; i < DataTable2.Columns.Count; i++)
            {
                //再向新表中加入DataTable2的列结构
                newDataTable.Columns.Add(DataTable2.Columns[i].ColumnName);
            }
            object[] obj = new object[newDataTable.Columns.Count];
            //添加DataTable1的数据
            for (int i = 0; i < DataTable1.Rows.Count; i++)
            {
                DataTable1.Rows[i].ItemArray.CopyTo(obj, 0);
                newDataTable.Rows.Add(obj);
            }

            if (DataTable1.Rows.Count >= DataTable2.Rows.Count)
            {
                for (int i = 0; i < DataTable2.Rows.Count; i++)
                {
                    for (int j = 0; j < DataTable2.Columns.Count; j++)
                    {
                        newDataTable.Rows[i][j + DataTable1.Columns.Count] = DataTable2.Rows[i][j].ToString();
                    }
                }
            }
            else
            {
                DataRow dr3;
                //向新表中添加多出的几行
                for (int i = 0; i < DataTable2.Rows.Count - DataTable1.Rows.Count; i++)
                {
                    dr3 = newDataTable.NewRow();
                    newDataTable.Rows.Add(dr3);
                }
                for (int i = 0; i < DataTable2.Rows.Count; i++)
                {
                    for (int j = 0; j < DataTable2.Columns.Count; j++)
                    {
                        newDataTable.Rows[i][j + DataTable1.Columns.Count] = DataTable2.Rows[i][j].ToString();
                    }
                }
            }
            newDataTable.TableName = DTName; //设置DT的名字 
            return newDataTable;
        }

        /// <summary> 
        /// 将两个列不同(结构不同)的DataTable合并成一个新的DataTable 
        /// </summary> 
        /// <param name="DataTable1">表1</param> 
        /// <param name="DataTable2">表2</param> 
        /// <param name="DTName">合并后新的表名</param> 
        /// <returns>合并后的新表</returns> 
        private DataTable UniteDataTable2(DataTable DataTable1, DataTable DataTable2, string DTName)
        {
            DataTable newDataTable = new DataTable();
            if (DataTable1.Rows.Count > DataTable2.Rows.Count)
            {
                newDataTable = FillData(DataTable1, DataTable2);
            }
            else
            {
                newDataTable = FillData(DataTable2, DataTable1);
            }

            newDataTable.TableName = DTName; //设置DT的名字 
            return newDataTable;
        }

        private DataTable FillData(DataTable dt1, DataTable dt2)
        {
            //克隆DataTable1的结构
            DataTable newDataTable = dt1.Clone();
            for (int i = 0; i < dt2.Columns.Count; i++)
            {
                //再向新表中加入DataTable2的列结构
                newDataTable.Columns.Add(dt2.Columns[i].ColumnName);
            }
            object[] obj = new object[newDataTable.Columns.Count];
            //添加DataTable1的数据
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                dt1.Rows[i].ItemArray.CopyTo(obj, 0);
                newDataTable.Rows.Add(obj);
            }
            for (int i = 0; i < dt2.Rows.Count; i++)
            {
                for (int j = 0; j < dt2.Columns.Count; j++)
                {
                    newDataTable.Rows[i][j + dt1.Columns.Count] = dt2.Rows[i][j].ToString();
                }
            }
            return newDataTable;
        }
    }
}
