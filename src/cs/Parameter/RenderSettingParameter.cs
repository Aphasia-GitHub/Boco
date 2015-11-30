namespace Boco.Rnop.AppCore.Data
{
    public class SaveRenderSettingParameter
    {
        public long ID { get; set; }
        public string UserID { get; set; }
        public string RenderSetting { get; set; }
        public string GroupName { get; set; }
        public string Field { get; set; }
        public string FieldAlias { get; set; }
    }

    public class GetRenderSettingParameter
    {
        public string GroupName { get; set; }
        public string UserID { get; set; }
    }
}
