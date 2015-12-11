using System;
using System.Data;
using System.Linq;

namespace DTLinq
{
    class Program
    {
        static void Main(string[] args)
        {
            Test();
            Console.Read();
        }

        static void Test()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("ID"));
            dt.Columns.Add(new DataColumn("NAME"));
            dt.Columns.Add(new DataColumn("VALUE"));

            DataRow dr1 = dt.NewRow();
            dr1["ID"] = "01";
            dr1["NAME"] = "张三";
            dr1["VALUE"] = 1024;
            dt.Rows.Add(dr1);

            DataRow dr2 = dt.NewRow();
            dr2["ID"] = "02";
            dr2["NAME"] = "李四";
            dr2["VALUE"] = 1014;
            dt.Rows.Add(dr2);

            DataRow dr3 = dt.NewRow();
            dr3["ID"] = "03";
            dr3["NAME"] = "王五";
            dr3["VALUE"] = 1025;
            dt.Rows.Add(dr3);

            DataRow dr4 = dt.NewRow();
            dr4["ID"] = "04";
            dr4["NAME"] = "赵六";
            dr4["VALUE"] = 1004;
            dt.Rows.Add(dr4);

            // 获取DataTable中某一列的最大最小值
            var maxValue = dt.AsEnumerable().Max(p => { return p["VALUE"]; });
            var minValue = dt.AsEnumerable().Min(p => { return p["VALUE"]; });
        }
    }
}
