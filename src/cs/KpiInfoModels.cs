using System.Text;
using System.Linq;
using System.Collections.Generic;

namespace Boco.Rnop.AppCore.Data
{
    public class KpiInfoModels
    {
        /// <summary>
        /// kpiId
        /// </summary>
        public long KpiId { get; set; }
        /// <summary>
        /// 厂家id
        /// </summary>
        public int VendorId { get; set; }
        /// <summary>
        /// 厂家名称
        /// </summary>
        public string VendorName { get; set; }
        /// <summary>
        /// kpi英文名
        /// </summary>
        public string EnglishName { get; set; }
        /// <summary>
        /// KPI中文名
        /// </summary>
        public string ChineseName { get; set; }
        /// <summary>
        /// 制式
        /// </summary>
        public string Technology { get; set; }
        /// <summary>
        /// 网元粒度
        /// </summary>
        public int NeType { get; set; }//etrancell:8105,enodeb:8104
        /// <summary>
        /// kpi对应指标表名
        /// </summary>
        public string TableName { get; set; }
        /// <summary>
        /// kpi对应指标列名
        /// </summary>
        public string FieldName { get; set; }
        /// <summary>
        /// kpi单位
        /// </summary>
        public string Unit { get; set; }
        /// <summary>
        /// kpi类型
        /// </summary>
        public int KpiCategoryId { get; set; }
        /// <summary>
        /// kpi数据类型
        /// </summary>
        public string FieldDataType { get; set; }
    }

    public class KpiTreeNodeModelMappingDB
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public int NeType { get; set; }
        public string Technology { get; set; }
        public string FieldName { get; set; }
        public int VendorId { get; set; }
        public long ParentId { get; set; }
        public string ParentName { get; set; }
        public int IsKpi { get; set; }
        public bool IsKpiBool
        {
            get { return IsKpi == 1; }
        }
    }

    public class KpiTreeNodeModel
    {
        public long id { get; set; }
        public string text { get; set; }
        public string field;
        public string technology;
        public object tag { get; set; }
        public bool expanded { get; set; }
        public bool hasChildren { get; set; }
        public IList<KpiTreeNodeModel> items { get; set; }

        public KpiTreeNodeModel(long id, string name, string technology, string field,
            bool expanded, bool hasChildren, object tag = null)
        {
            this.id = id;
            this.text = name;
            this.field = field;
            this.technology = technology;
            this.expanded = expanded;
            this.hasChildren = hasChildren;
            this.tag = tag;
        }

        public static IList<KpiTreeNodeModel> GetKpiTreeNodeModel(IList<KpiTreeNodeModelMappingDB> data)
        {
            if (data == null || !data.Any()) return null;
            IList<KpiTreeNodeModel> result = new List<KpiTreeNodeModel>();
            var parent = data.Where(d => d.ParentId == -1).ToList();
            foreach (var p in parent)
            {
                var currentNode = new KpiTreeNodeModel(p.Id, p.Name, p.Technology, p.FieldName, false, false);
                IList<KpiTreeNodeModel> currentNodeChildNodes = null;
                GetChildNodes(p.Id, data, ref currentNodeChildNodes);
                currentNode.hasChildren = null != currentNodeChildNodes && currentNodeChildNodes.Any();
                currentNode.items = currentNodeChildNodes;
                if (!currentNode.hasChildren && !p.IsKpiBool)
                {
                    continue;
                }
                result.Add(currentNode);
            }
            return result;


        }
        private static void GetChildNodes(long parentId, IList<KpiTreeNodeModelMappingDB> data, ref IList<KpiTreeNodeModel> result)
        {
            if (data == null || !data.Any()) return;

            var childNodes = data.Where(d => d.ParentId == parentId).ToList();
            foreach (var c in childNodes)
            {

                var currentNode = new KpiTreeNodeModel(c.Id, c.Name, c.Technology, c.FieldName, false, false);
                IList<KpiTreeNodeModel> currentNodeChildNodes = null;
                GetChildNodes(c.Id, data, ref currentNodeChildNodes);
                currentNode.hasChildren = null != currentNodeChildNodes && currentNodeChildNodes.Any();
                currentNode.items = currentNode.hasChildren ? currentNodeChildNodes : null;
                if (!currentNode.hasChildren && !c.IsKpiBool)
                {
                    continue;
                }
                result = result ?? new List<KpiTreeNodeModel>();
                result.Add(currentNode);
            }

        }
    }

    /// <summary>
    /// 模板查询参数类
    /// </summary>
    public class TemplateSearchModel
    {
        /// <summary>
        /// 网元粒度
        /// </summary>
        public int NeGranularity { get; set; }
        /// <summary>
        /// 模板名称
        /// </summary>
        public string TemplateName { get; set; }
        /// <summary>
        /// 时间粒度
        /// </summary>
        public int TimeGran { get; set; }
        /// <summary>
        /// 指定kpi
        /// </summary>
        public List<long> Kpis { get; set; }
        /// <summary>
        /// 厂家类别
        /// </summary>
        public int VendorId { get; set; }
        /// <summary>
        /// 地市id
        /// </summary>
        public List<long> Regions { get; set; }

        public string GetSortKpiIds()
        {
            if (Kpis == null || Kpis.Count == 0) { return null; }

            StringBuilder sb = new StringBuilder();
            Kpis.ForEach(p =>
            {
                sb.Append(p);
                sb.Append(",");
            });
            sb = sb.Remove(sb.Length - 1, 1);

            return sb.ToString();
        }
    }
}
