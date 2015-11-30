using Boco.Rnop.Framework.Common.Services.Log;
using Boco.Rnop.Framework.RestWebService;
using Boco.Rnop.Framework.Web.Core;
using Boco.Rnop.PerformanceEvaluation.Data;
using Boco.Rnop.PerformanceEvaluation.UI.Models;
using Boco.Rnop.Search.Data;
using Boco.Rnop.Search.ServiceClient;
using Boco.Rnop.Utility;
using Dqas.TemplateManage.DTO;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml.Serialization;
using Boco.Rnop.AppCore.Data;
using Newtonsoft.Json;
using System.Text;
using Boco.Rnop.Framework.BusiCore.Service;

namespace Boco.Rnop.PerformanceEvaluation.UI.Controllers
{
    public class PerformanceQueryController : ExtendedController
    {
        [CustomAuthorize(AuthType.LoginAllow)]
        public ActionResult Index()
        {
            return View();
        }

        [CustomAuthorize(AuthType.LoginAllow)]
        public ActionResult Query(PerfQueryParameter input)
        {
            return View();
        }

        [CustomAuthorize(AuthType.LoginAllow)]
        public JsonResult GetTemplateList()
        {
            List<TemplateInfoDtoSL> list = TemplateSearchClient.GetTemplateInfoList(0);
            var templateSource = list.Select(t => new KendoDropDownListItemModel { value = t.TemplateID.ToString(), text = t.TemplateName }).Distinct().ToList();
            return Json(templateSource);
        }

        [CustomAuthorize(AuthType.LoginAllow)]
        public JsonResult GetGrid(PerformanceQueryModel perfQueryModel)
        {
            var list = new List<PerformanceQueryModel>();
            list.Add(perfQueryModel);
            list.Add(perfQueryModel);
            list.Add(perfQueryModel);
            return Json(list);
        }

        [CustomAuthorize(AuthType.LoginAllow)]
        public JsonResult GetTemplateData()
        {
            #region [OLD]
            //TemplateSearchParameter param = new TemplateSearchParameter();
            //param.NeGranularity = 300;
            //param.TemplateName = "临时模板-包含gis信息";
            //param.PageIndex = 1;
            //param.PageSize = 100;
            //param.TimeGran = 0;//小时
            //param.SortKpiIds = "10007040003016,10007040003017";
            //// KpiSearchClient.GetKpisByIds();
            //param.VendorId = 7;
            //param.Technology = "LTE";

            //TimeObjDTO timeObjDto = new TimeObjDTO();
            //timeObjDto.TimeGranularity = 0;//小时
            //timeObjDto.SeriesTimeList = new List<DateTime>();
            //timeObjDto.SeriesTimeList.Add(new DateTime(2015, 10, 4));

            //NeObjDTO neObjDto = new NeObjDTO();
            //neObjDto.IsWholeNESelected = false;
            //neObjDto.HasNEsSelected = true;
            //neObjDto.NeDic = new Dictionary<string, List<long>>();
            //neObjDto.NeDic.Add("CdmaCell", new List<long>() { -2962856508243594720, -3248553596720008672 });

            //TemplateDtoSL ttTempalte = new TemplateQueryRepository().CreateTemplateDto(param);
            ////ttTempalte.IsQueryFromHistory = false;
            //var res = TemplateQuerySearchClient.QueryByTemplateObjNoPaging(ttTempalte, timeObjDto, neObjDto);
            #endregion

            //public static List<KpiDtoSL> GetKpisByIds(List<long> kpiIds)
            var kpis = KpiSearchClient.GetKpisByIds(new List<long> { 119990030010000003, 119990030010000004 });
            //var kpi = KpiSearchClient.GetKpiById(10007040003016);
            //public static CommonResponse<KpiDtoSL> GetKpiById(long kpiId)

            TemplateSearchModel model = new TemplateSearchModel
            {
                NeGranularity = 300,
                TemplateName = "临时模板-包含gis信息",
                VendorId = -1,
                TimeGran = 0,
                Kpis = new List<long> { 119990030010000003, 119990030010000004 },
                Regions = new List<long> { -518079985, -249357804 }
            };

            var modelStr = JsonConvert.SerializeObject(model);
            var newModel = JsonConvert.DeserializeObject<TemplateSearchModel>(modelStr);

            var tstr = GetTemplateDataById(modelStr);

            #region [OLD-11-27]
            /*
            TemplateSearchParameter param = new TemplateSearchParameter();
            param.NeGranularity = 300;
            param.TemplateName = "临时模板-包含gis信息";
            param.PageIndex = 1;
            param.PageSize = 100;
            param.TimeGran = 0;//小时
            param.SortKpiIds = "10007040003016,10007040003017";
            // KpiSearchClient.GetKpisByIds();
            param.VendorId = 7;
            param.Technology = "LTE";

            TimeObjDTO timeObjDto = new TimeObjDTO();
            timeObjDto.TimeGranularity = 0;//小时
            timeObjDto.SeriesTimeList = new List<DateTime>();
            timeObjDto.SeriesTimeList.Add(new DateTime(2015, 10, 4));

            NeObjDTO neObjDto = new NeObjDTO();
            neObjDto.IsWholeNESelected = true;  // false
            neObjDto.HasNEsSelected = true;
            neObjDto.NeDic = new Dictionary<string, List<long>>();

            //neObjDto.NeDic.Add("CdmaCell", new List<long>() { -2962856508243594720, -3248553596720008672 });

            TemplateDtoSL ttTempalte = new TemplateQueryRepository().CreateTemplateDto(param);
            //ttTempalte.IsQueryFromHistory = false;
            
            var res = TemplateQuerySearchClient.QueryByTemplateObjNoPaging(ttTempalte, timeObjDto, neObjDto);
            */
            #endregion

            TemplateSearchParameter param = new TemplateSearchParameter();
            param.NeGranularity = 300;
            param.TemplateName = "临时模板-包含gis信息";
            param.TimeGran = 0;//小时
            param.SortKpiIds = "119990030010000003,119990030010000004";
            param.VendorId = -1;
            //param.Technology = "LTE";

            TimeObjDTO timeObjDto = new TimeObjDTO();
            timeObjDto.TimeGranularity = 0;//小时 
            timeObjDto.SeriesTimeList = new List<DateTime>();
            timeObjDto.SeriesTimeList.Add(new DateTime(2015, 10, 4));

            NeObjDTO neObjDto = new NeObjDTO();
            neObjDto.IsWholeNESelected = false;
            neObjDto.HasNEsSelected = true;
            neObjDto.NeDic = new Dictionary<string, List<long>>();
            neObjDto.NeDic.Add("Region", new List<long> { -518079985, -249357804 });

            TemplateDtoSL ttTempalte = new TemplateQueryRepository().CreateTemplateDto(param);
            ttTempalte.IsQueryFromHistory = false;
            var res = TemplateQuerySearchClient.QueryByTemplateObjNoPaging(ttTempalte, timeObjDto, neObjDto);
            // 构建指标范围
            var disx = (from r in res.Result.Result.AsEnumerable()
                        select r["C1"]).Distinct().ToList();
            var disy = (from r in res.Result.Result.AsEnumerable()
                        select r["C2"]).Distinct().ToList();
            return Json(res, JsonRequestBehavior.AllowGet);
        }

        [CustomAuthorize(AuthType.LoginAllow)]
        public JsonResult GetTemplateDataById(string dictKey)
        {
            #region [序列化模板配置]
            var modelStr = dictKey;//ConfigurationServiceClient.GetParamValue(dictKey);
            var templateModel = JsonConvert.DeserializeObject<TemplateSearchModel>(modelStr);
            #endregion

            #region [构造模板查询实体]
            TemplateSearchParameter param = new TemplateSearchParameter();
            param.NeGranularity = templateModel.NeGranularity;
            param.TemplateName = templateModel.TemplateName;
            param.TimeGran = templateModel.TimeGran;
            param.SortKpiIds = templateModel.GetSortKpiIds();//"119990030010000003,119990030010000004";
            param.VendorId = templateModel.VendorId;

            TimeObjDTO timeObjDto = new TimeObjDTO();
            timeObjDto.TimeGranularity = 0;//小时 
            timeObjDto.SeriesTimeList = new List<DateTime>();
            timeObjDto.SeriesTimeList.Add(new DateTime(2015, 10, 4));   // 等王元玮告知获取最近一周的数据修改

            NeObjDTO neObjDto = new NeObjDTO();
            neObjDto.IsWholeNESelected = false;
            neObjDto.HasNEsSelected = true;
            neObjDto.NeDic = new Dictionary<string, List<long>>();
            neObjDto.NeDic.Add("Region", templateModel.Regions);

            TemplateDtoSL ttTempalte = new TemplateQueryRepository().CreateTemplateDto(param);
            ttTempalte.IsQueryFromHistory = false;
            var res = TemplateQuerySearchClient.QueryByTemplateObjNoPaging(ttTempalte, timeObjDto, neObjDto);
            #endregion

            #region [构造查询模板]
            var dtDropList = new DataTable();
            dtDropList.Columns.Add("text");             // dtDropList 必须列 text
            dtDropList.Columns.Add("value");            // dtDropList 必须列 value
            dtDropList.Columns.Add("renderSetting");    // dtDropList 必须列 renderSetting
            dtDropList.Columns.Add("id");

            //res.Result.ColumnAliasNameDictionary.
            /*
            列	中文	字段名	renderStting	
            C1 	LAC 	LAC	渲染设置
            */
            var tempKpis = KpiSearchClient.GetKpisByIds(templateModel.Kpis);
            foreach (var tk in tempKpis)
            {
                // 获取每个指标的范围
                var item = res.Result.ColumnAliasNameDictionary.FirstOrDefault(p => p.Value == tk.ChineseName);
                if (item.Value == null) { continue; }
                var dprow = dtDropList.NewRow();
                dprow["id"] = "";
                dprow["text"] = item.Value; //drow["FIELD_ALIAS"].ToString();
                dprow["value"] = item.Key;  //drow["FIELD"].ToString();

                var distinctKpiVals = (from r in res.Result.Result.AsEnumerable()
                                       select r[item.Key]).Distinct().ToList();

                var fieldType = tk.FieldDataType.ToLower();
                if (fieldType.Contains("char") || fieldType.Contains("date") || fieldType.Contains("null"))
                {
                    StringBuilder renderStr = new StringBuilder("{");
                    renderStr.Append("dataType:0,data:[");
                    //renderStr.Append("{Value:");
                    foreach (var kval in distinctKpiVals)
                    {
                        renderStr.Append("{Value:");
                        renderStr.Append(kval);
                        renderStr.Append("},");
                    }
                    renderStr.Remove(renderStr.Length - 1, 1);
                    renderStr.Append("]}");
                    dprow["renderSetting"] = renderStr.ToString();
                    // 枚举
                    // {"dataType":0,"data":[{"Value":"A"},{"Value":"B"},{"Value":"C"},{"Value":"D"}]}
                }
                else
                {
                    double maxNum = 0;
                    double minNum = 0;
                    double parseNum = 0;
                    foreach (var kval in distinctKpiVals)
                    {
                        double.TryParse(kval.ToString(), out parseNum);
                        if (parseNum > maxNum)
                        {
                            maxNum = parseNum;
                        }
                        if (parseNum < minNum)
                        {
                            minNum = parseNum;
                        }
                    }
                    StringBuilder renderStr = new StringBuilder("{dataType:1,data:[{MinNum:");
                    renderStr.Append(minNum);
                    renderStr.Append(",MaxNum:");
                    renderStr.Append(maxNum);
                    renderStr.Append(",RangeText:[");
                    renderStr.Append(minNum);
                    renderStr.Append(",");
                    renderStr.Append(maxNum);
                    renderStr.Append("]}]}");
                    dprow["renderSetting"] = renderStr.ToString();
                    // 数字
                    //{"dataType":1,"data":[{"MinNum":0,"MaxNum":10,"RangeText":"[0,10]"}]}
                }
                dtDropList.Rows.Add(dprow);
            }
            #endregion
            var graphicType = GetNEType(templateModel.NeGranularity);
            var ret = new
            {
                hasSaveButton = true,           // 是否有保存按钮
                dtReuslts = res.Result.Result,  // 数据集合
                dtDropList = dtDropList,        // 下拉集合
                groupName = "Template",         // 分组名称
                windowTitle = "GIS渲染",         // 图例窗口
                renderGraphic = new { key = graphicType, value = graphicType }  // 渲染图形
            };


            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        private string GetNEType(int neType)
        {
            if(neType == 300 || neType == 9300)
            {
                return "CELL";
            }
            else if (neType == 201)
            {
                return "BTS";
            }
            else
            {
                return "CELL";
            }
        }
    }
}
