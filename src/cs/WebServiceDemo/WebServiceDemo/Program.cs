using ProxyClient;

namespace WebServiceDemo
{
    class Program
    {
        static void Main(string[] args)
        {
            var service = new GetMsgToCreateSheetService();
            var Paramstr = "<?xml version=\"1.0\" encoding=\"GBK\"?><root><data><request>";
            var result = service.getMsgToCreateSheet(Paramstr);
            System.Console.Read();
        }
    }
}
