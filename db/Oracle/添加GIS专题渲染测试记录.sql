/*
在tap_cfg_dictionary加入一条渲染数据记录
http://localhost:8080/GISUtility/ThematicRender?plugin=AppCorePlugin&IsActive=true&DSKey=AppCore_ThematicRender
*/
INSERT INTO TAP_CFG_DICTIONARY(USER_ID, PARAM_NAME, PARAM_VALUE) VALUES ('-1','AppCore_ThematicRender','GISUtility/GetThematicRenderDatas?plugin=AppCorePlugin&IsActive=true')

/*修改外部数据渲染链接*/
UPDATE TAP_MENU SET URL = 'GISUtility/GISPreview?plugin=AppCorePlugin&IsActive=true' WHERE SIGN_NAME = 'Default_V4' AND NAME = '外部数据渲染界面'


PerformanceQuery/GetTemplateDataById?plugin=PerformanceEvaluationPlugin&IsActive=true&dictKey=Perf_Template

SELECT * FROM tap_cfg_dictionary d WHERE d.param_name = 'AppCore_ThematicRender'
DELETE FROM tap_cfg_dictionary WHERE param_name = 'AppCore_ThematicRender'
-- {"NeGranularity":300,"TemplateName":"临时模板-包含gis信息","TimeGran":0,"Kpis":[119990030010000003,119990030010000004],"VendorId":-1,"Regions":[-518079985,-249357804]}

-- 先删除旧有
DELETE FROM TAP_CFG_DICTIONARY WHERE PARAM_NAME in ('AppCore_ThematicRender','Perf_Template','Perf_ThematicRender');
INSERT INTO TAP_CFG_DICTIONARY(USER_ID, PARAM_NAME, PARAM_VALUE) VALUES ('-1','AppCore_ThematicRender','GISUtility/GetThematicRenderDatas?plugin=AppCorePlugin&IsActive=true');
INSERT INTO TAP_CFG_DICTIONARY(USER_ID, PARAM_NAME, PARAM_VALUE) VALUES ('-1','Perf_Template','{"NeGranularity":300,"TemplateName":"临时模板-包含gis信息","TimeGran":0,"Kpis":[119990030010000003,119990030010000004],"VendorId":-1,"Regions":[-518079985,-249357804]}');
INSERT INTO TAP_CFG_DICTIONARY(USER_ID, PARAM_NAME, PARAM_VALUE) VALUES ('-1','Perf_ThematicRender','PerformanceQuery/GetTemplateDataById?plugin=PerformanceEvaluationPlugin&IsActive=true&dictKey=Perf_Template');

http://localhost:8080/GISUtility/ThematicRender?plugin=AppCorePlugin&IsActive=true&DSKey=Perf_ThematicRender

