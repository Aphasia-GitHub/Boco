using System;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace JsonTest
{
    class Program
    {
        static void Main(string[] args)
        {
            TestJson();
            Console.ReadKey();
        }

        static void TestJson()
        {
            var jsonObj = new
            {
                Text = "123",
                Cols = new List<object>()
            };
            jsonObj.Cols.Add(new { ABC = "ABC1", SA = "SA1" });
            jsonObj.Cols.Add(new { ABC = "ABC2", SA = "SA2" });

            var str = JsonConvert.SerializeObject(jsonObj);
            Console.WriteLine(str);
        }
    }
}
