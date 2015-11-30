/*
在tap_cfg_dictionary加入一条渲染数据记录
http://localhost:8080/GISUtility/ThematicRender?plugin=AppCorePlugin&IsActive=true&DSKey=AppCore_ThematicRender
*/
INSERT INTO TAP_CFG_DICTIONARY(USER_ID, PARAM_NAME, PARAM_VALUE) VALUES ('-1','AppCore_ThematicRender','http://localhost:8080/GISUtility/GetThematicRenderDatas?plugin=AppCorePlugin&IsActive=true')

/*修改外部数据渲染链接*/
UPDATE TAP_MENU SET URL = 'GISUtility/GISPreview?plugin=AppCorePlugin&IsActive=true' WHERE SIGN_NAME = 'Default_V4' AND NAME = '外部数据渲染界面'
