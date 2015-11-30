Namespace("Boco.Rnop.AppCore");

Boco.Rnop.AppCore.ThematicRenderHelper = function () {
    var self = this;
    var dsKey = $("#hidDSKey").val();
    var currentMap = null;
    var currentRenderSet = null;
    var btnRenderFirstClick = false;
    var prefixUrl = Boco.Rnop.Web.Environments.BaseUri();
    var datas = null;		// 全局数据源
    var dropDatas = [];		// 下拉数据源

    this.init = function () {
        initControl();
        bindEvent();
        initData();
    };

    //---------------------------------------------------------
    // Private Methods
    //---------------------------------------------------------
    function initControl() {
        currentRenderSet = new RenderSet("divRenderCtrl", 10);
        currentRenderSet.init();

        currentMap = new MapView("mapdiv", "", "");
        currentMap.init();

        $("#dpFiled").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value"
        });
    }

    function bindEvent() {
        var cbxKpi = $("#dpFiled").data("kendoDropDownList");
        cbxKpi.bind("change", bindGrid);

        $("#btnRender").click(function () {
            if (!btnRenderFirstClick) {
                currentMap.removeMapExtentListener("UniqueValueGisRenderHelper.registerExtendListener");
                registerExtendListener();
                btnRenderFirstClick = true;
            }
            locatePoint();
        });

        $("#btnSave").click(function () {
            if (currentRenderSet.getGridData().data.length === 0) { return; }
            $.ajax({
                type: "POST",
                data: {
                    userId: Boco.Rnop.Web.Environments.CurUserID(),
                    renderSetting: window.JSON.stringify(currentRenderSet.getGridData()),
                    field: $("#dpFiled").data("kendoDropDownList").value(),
                    fieldAlias: $("#dpFiled").data("kendoDropDownList").text(),
                    groupName: datas.groupName
                },
                url: prefixUrl + "/GISUtility/SaveRenderSetting?plugin=AppCorePlugin",
                dataType: "json",
                success: function (data) {
                    $.messager.alert("操作提示", data.msg, "info");
                }
            });
        });
    }

    function initData() {
        $.ajax({
            type: "GET",
            url: dsKey,
            dataType: "json",
            success: function (data) {
                datas = data;
                initRenderData();
                // 绑定下拉
                var cbxKpi = $("#dpFiled").data("kendoDropDownList");
                cbxKpi.setDataSource(data.dtDropList);
                // 绑定Grid
                bindGrid();
            }
        });
    }

    function initRenderData() {
        if (datas === null) { return; }
        $.each(datas.dtDropList, function (j, jitem) {
            var dropObj = {
                text: jitem.text,
                value: jitem.value,
                renderSetting: {}
            };

            jitem.renderSetting = JSON.parse(jitem.renderSetting);
            var colorSetting = [];
            $.each(jitem.renderSetting.data, function (k, kitem) {
                var kitemColor = (jitem.id !== "") ? kitem.Color :
                    BaseColorEnums.getColorByIndex(k).hexColor;
                var kitemColumnIndex = (jitem.id !== "") ? kitem.ColumnId : k;

                if (jitem.renderSetting.dataType === 0) {
                    var singleItem = createSingleInfoParameter({
                        ColumnId: kitemColumnIndex,
                        Value: kitem.Value,
                        Color: kitemColor
                    });
                    colorSetting.push(singleItem);
                } else {
                    if (jitem.renderSetting.dataType !== 1) { console.log(jitem.renderSetting.dataType); }
                    var rangeItem = createRangeInfoParameter({
                        ColumnId: kitemColumnIndex,
                        RangeText: kitem.RangeText,
                        MinNum: kitem.MinNum,
                        MaxNum: kitem.MaxNum,
                        Color: kitemColor
                    });
                    colorSetting.push(rangeItem);
                }
            });
            jitem.renderSetting.data = colorSetting;
            // 下拉数据源
            dropObj.renderSetting.dataType = jitem.renderSetting.dataType;
            dropObj.renderSetting.data = colorSetting;
            dropDatas.push(dropObj);
        });
    }

    function bindGrid() {
        var dataItem = $("#dpFiled").data("kendoDropDownList").dataItem();
        var rval = dataItem.value;
        var findData = dropDatas.filter(function (jitem) {
            return jitem.value === rval;
        });
        if (findData.length === 0) { return; }
        if (findData[0].renderSetting.dataType === 0) {
            currentRenderSet.setSingleInfos(findData[0].renderSetting.data);
        }
        if (findData[0].renderSetting.dataType === 1) {
            currentRenderSet.setRangeInfos(findData[0].renderSetting.data);
        }
    }

    function registerExtendListener() {
        var e = createMapEventParameter({
            callbackName: "UniqueValueGisRenderHelper.registerExtendListener",
            callback: function (evt) {
                var levelInfo = currentMap.getMapLevel();
                var scaleInfo = currentMap.getMapScale();
                // level 6
                if (levelInfo.CurrentLevel >= levelInfo.DefaultLevel - 2) {
                    try {
                        var filteredDataSource = datas.dtReuslts.filter(function (item) {
                            return (parseFloat(item.lon) >= evt.xmin &&
                                    parseFloat(item.lon) <= evt.xmax &&
                                    parseFloat(item.lat) >= evt.ymin &&
                                    parseFloat(item.lat) <= evt.ymax);
                        });

                        var dpSelectField = $("#dpFiled").data("kendoDropDownList").value();//value
                        var eFields = [];
                        $.each(filteredDataSource, function (i, item) {
                            var rObj = {
                                lon: parseFloat(item.lon),
                                lat: parseFloat(item.lat),
                                dir: parseFloat(item.dir),
                                compareField: item[dpSelectField],
                                labelField: ""
                            };
                            eFields.push(rObj);
                        });

                        // 后台指定
                        var e = createGisRenderParameter({
                            renderGraphic: datas.renderGraphic,
                            colorSetting: currentRenderSet.getGridData(),
                            hasLabel: false,
                            windowTitle: datas.windowTitle,
                            hasZoomScale: true,
                            haswindow: true,
                            fields: eFields,
                            optionalField: {
                                notExtend: true,
                                minScale: scaleInfo.DefaultScale * 4,
                                windowLeftOffset: 440
                            }
                        });
                        currentMap.doGisRender(e);
                    } catch (err) {
                        console.log("基础数据渲染出现异常");
                        console.log(err);
                    }
                }
            },
            optionalField: {}
        });
        currentMap.addMapExtentListener(e);
    }

    function locatePoint() {
        if (datas.dtReuslts.length === 0 || currentRenderSet.getGridData().data.length == 0) { return; }
        var lon = parseFloat(datas.dtReuslts[0].lon);
        var lat = parseFloat(datas.dtReuslts[0].lat);
        var levelInfo = currentMap.getMapLevel();
        currentMap.mapLocate(lon, lat, {
            showPath: false,
            level: levelInfo.DefaultLevel
        });
    }

    function getLon(obj) {
        if (typeof obj.lon !== "undefined") {
            return obj.lon;
        } else if (typeof obj.Lon !== "undefined") {
            return obj.Lon;
        } else if (typeof obj.LON !== "undefined") {
            return obj.LON;
        } else if (typeof obj.longitude !== "undefined") {
            return obj.longitude;
        } else if (typeof obj.Longitude !== "undefined") {
            return obj.Longitude;
        } else if (typeof obj.LONGITUDE !== "undefined") {
            return obj.LONGITUDE;
        } else {
            return;
        }
    }

    function getLat(obj) {
        if (typeof obj.lat !== "undefined") {
            return obj.lat;
        } else if (typeof obj.Lat !== "undefined") {
            return obj.Lat;
        } else if (typeof obj.LAT !== "undefined") {
            return obj.LAT;
        } else if (typeof obj.latitude !== "undefined") {
            return obj.latitude;
        } else if (typeof obj.Latitude !== "undefined") {
            return obj.Latitude;
        } else if (typeof obj.LATITUDE !== "undefined") {
            return obj.LATITUDE;
        } else {
            return;
        }
    }

    function getDir(obj) {
        if (typeof obj.dir !== "undefined") {
            return obj.dir;
        } else if (typeof obj.Dir !== "undefined") {
            return obj.Dir;
        } else if (typeof obj.DIR !== "undefined") {
            return obj.DIR;
        } else if (typeof obj.latitude !== "undefined") {
            return obj.latitude;
        } else if (typeof obj.Latitude !== "undefined") {
            return obj.Latitude;
        } else if (typeof obj.LATITUDE !== "undefined") {
            return obj.LATITUDE;
        } else {
            return;
        }
    }
};