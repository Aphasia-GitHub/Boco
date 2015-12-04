/**
 * Created by Pengxuan Men on 2015-08-02.
 */
define([
    'core/const',
    'core/conf',
    'core/ajax',
    'util/date-format',
    'util/geo',
    'ui/alerts',
    'ui/echarts-map',
    'ui/gis-dialog',
    'tmpl',
    'jquery',
    'core/utils',
    'bootstrap',
    'bootstrap-dialog',
    'echarts',
    'echarts/chart/map',
    'echarts/chart/bar',
    'echarts/chart/line',
    'util/charts',
    'util/strings',
    'bootstrap-datetimepicker'
], function () {
    'use strict';

    var C = require('core/const'),
        conf = require('core/conf'),
        ajax = require('core/ajax'),
        dataFormat = require('util/date-format'),
        geo = require('util/geo'),
        alerts = require('ui/alerts'),
        echartsMap = require('ui/echarts-map'),
        gisDialog = require('ui/gis-dialog'),
        tmpl = require('tmpl'),
        $ = require('jquery'),
        BootstrapDialog = require('bootstrap-dialog'),
        echarts = require('echarts'),
        charts = require('util/charts'),
        strings = require('util/strings'),

        TPL_SIDEBAR_IND = 'template-sidebar-indicators',
        TPL_OVEARVIAEW_LEGEND = 'templateOverviewLegend',
        TPL_NETYPE_LIST = 'templateNeTypeStatistics',
        TPL_LEGEND_EDIT = 'template-legend-editBox',
        SEL_SIDEBAR_COLLAPSE = '#jsSidebarCollapse',
        SEL_SIDEBAR_CONTENT = '#jsSidebarContent',
        SEL_SIDEBAR_TABS = '#jsSidebarTabs',
        SEL_MAP_CHART = '#jsChartMap',
        SEL_MAP_GIS = '#jsGisMap',
        SEL_CHART_EXTRA = '#jsChartExtra',
        SEL_MAP_TITLE = '#jsMapTitle',
        SEL_MAP_TITLE_GIS = '#jsMapTileGis',
        SET_MAP_TITLE_EDIT_GIS = '#jsLegendEdit',
        SEL_MAP_TOOLBOX = '#jsMapToolbox',
        SEL_BTN_MAP_RETURN = '#jsMapReturnBtn',
        URLS_LOAD_DATA = {
            alarm: {
                queryByGeo: conf.AJAX.OVERVIEW_ALARM_QUERY_BY_GEO,
                queryByInd: conf.AJAX.OVERVIEW_ALARM_QUERY_BY_IND
            },
            performance: {
                queryByGeo: conf.AJAX.OVERVIEW_PM_QUERY_BY_GEO,
                queryByInd: conf.AJAX.OVERVIEW_PM_QUERY_BY_IND
            },
            resource: {
                queryByGeo: conf.AJAX.OVERVIEW_CM_QUERY_BY_GEO,
                queryByInd: conf.AJAX.OVERVIEW_CM_QUERY_BY_IND
            },
            cover: {
                queryByGeo: conf.AJAX.OVERVIEW_CM_QUERY_BY_GEO,
                queryByInd: conf.AJAX.OVERVIEW_COVER_QUERY_BY_IND
            }
        },
        RES_KEY_MAP = {
            8104: 'enb',
            8105: 'cel',
            8111: 'rru',
            8112: 'cel',
            10007: 'sit'
        },
        mapOption = {
            title: {
                show: false,
                text: '',
                x: 'center',
                textStyle: {
                    fontSize: 20,
                    fontFamily: '"Microsoft YaHei", Arial, sans-serif'
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: '{b}: {c}'
            },
            /*toolbox: {
             show: true,
             padding: 15,
             orient : 'vertical',
             x: 'right',
             y: 'center',
             feature: {
             saveAsImage: {show: true}
             }
             },*/
            series: [
                {
                    //name: '',
                    type: 'map',
                    mapType: 'china',
                    selectedMode: 'single',
                    itemStyle: {
                        normal: {
                            borderWidth: 2,
                            borderColor: 'white',
                            label: {
                                show: true,
                                formatter: '{a}'
                            }
                        },
                        emphasis: {
                            color: '#5bc0de',
                            borderWidth: 2,
                            borderColor: 'white',
                            label: {show: true}
                        }
                    },
                    data: []
                }
            ]
        },
        dataRange = {
            padding: 15,
            x: 'left',
            y: 'top',
            color: ['#ff5a00', '#fed7bc']
        },
        map = null,
        chartExtra1 = null,
        chartExtra2 = null,
        param = {geoId: conf.USER_GEO_ID},
    //paramHistories = [],
        geoHistories = [],
        jqXhrQueryByGeo = null,
        jqXhrQueryByInd = null,
        jqXhrQueryByTime = null,
        MAPTITLE = {
            alarm: [
                {
                    name: "一级",
                    color: "#d9534f"
                },
                {
                    name: "二级",
                    color: "#f0ad4e"
                },
                {
                    name: "三级",
                    color: "#f0ea4d"
                },
                {
                    name: "四级",
                    color: "#5bc0de"
                },
                {
                    name: "无告警",
                    color: "#5cb85c"
                }
            ],
            performance: [
                {
                    name: "一级",
                    color: "#d9534f",
                    value: "red"
                },
                {
                    name: "二级",
                    color: "#f0ad4e",
                    value: "orange"
                },
                {
                    name: "三级",
                    color: "#f0ea4d",
                    value: "yellow"
                },
                {
                    name: "正常",
                    color: "#5cb85c",
                    value: "green"
                }
            ]
        };

    function initEvents() {
        $(window).resize(function (e) {
            if (!isExtraChartVisible()) {
                return;
            }

            if (chartExtra1) {
                chartExtra1.resize();
            }
            if (chartExtra2) {
                chartExtra2.resize();
            }
        });
        $(SEL_SIDEBAR_COLLAPSE).on('show.bs.collapse', function (e) {
            //console.debug('show.bs.collapse');
        }).on('shown.bs.collapse', function (e) {
            //console.debug('shown.bs.collapse');
            if (e.target === this) {
                $(SEL_SIDEBAR_CONTENT).removeClass('full-width');
                $(window).trigger('resize');
            }
        }).on('hide.bs.collapse', function (e) {
            //console.debug('hide..bs.collapse');
        }).on('hidden.bs.collapse', function (e) {
            //console.debug('hidden.bs.collapse');
            if (e.target === this) {
                $(SEL_SIDEBAR_CONTENT).addClass('full-width');
                $(window).trigger('resize');
            }
        }).on('click', '.js-indicators .list-group-item', function (e) {
            $(this).closest('.js-indicators').find('.list-group-item.active').removeClass('active');
            $(this).addClass('active');
            loadMap();
            return false;
        }).on('click', '.js-indicators .list-group-item .table-export', function () {
            var key = $.unparam($(this).closest('.list-group-item').attr("data-cond"));
            //window.open("http://localhost:88/dxlte.web/topology-alarm/explortAlarm.do?"+ $.param(key));

            var form = $("<form>");
            form.attr('style', 'display:none');
            form.attr('target', '_blank');
            form.attr('method', 'post');
            form.attr('action', conf.AJAX.OVERVIEW_ALARM_EXPORT_BY_IND);
            form.attr("accept-charset", "utf-8");
            if (key != '') {
                var input1 = $('<input>');
                input1.attr('name', 'alarminquiryuri');
                input1.attr('value', key.alarminquiryuri);
                form.append(input1);

                var input2 = $('<input>');
                input2.attr('name', 'alarmkey');
                input2.attr('value', key.alarmkey);
                form.append(input2);
            }
            $('body').append(form);
            form.submit();
            form.remove();
            return false;
        }).on('click', '.js-indicators .list-group-item .value .resource-list', function () {
            $(".ne-type-statistics").show();
            listData(this, "city_name", 1);
            return false;
        });
        $(".ne-type-statistics").on("change", ".js-statistics-type-select", function () {
            var column = $(".js-statistics-type-select").val();
            listData(this, column, 2);
        }).on("click", ".js-statistics-table-detail a", function () {
            listData(this, "town_name", 4);
        }).on("click", ".js-statistics-table-return", function () {
            listData(this, "city_name", 3);
        }).on("click", ".js-statistics-table-close", function () {
            $(".ne-type-statistics").hide();
        }).on("click", ".pagination .js-page-num", function () {
            var pageNum = $(this).text();
            $(".js-page-num").removeClass("active");
            $(this).addClass("active");
            paginationResource(pageNum);
        }).on("click", ".pagination .js-start", function () {
            if ($(this).hasClass("disabled")) {
                return;
            }
            $(".js-page-num").removeClass("active");
            $($(".js-page-num")[0]).addClass("active");
            paginationResource(1);
        }).on("click", ".pagination .js-end", function () {
            if ($(this).hasClass("disabled")) {
                return;
            }
            var pageno = $(".js-page-num").length;
            $(".js-page-num").removeClass("active");
            $($(".js-page-num")[pageno - 1]).addClass("active");
            paginationResource(pageno);
        }).on('click', '.fa-external-link.js-table-export', function () {
            var param = $(this).data('value');
            var form = $("<form>");
            form.attr('style', 'display:none');
            form.attr('target', '');
            form.attr('method', 'post');
            form.attr('action', conf.AJAX.OVERVIEW_RESOURCE_EXPORT);
            form.attr("accept-charset", "utf-8");
            if (param != '') {
                var input1 = $('<input>');
                input1.attr('name', 'geoId');
                input1.attr('value', $.unparam(param)['geoId']);
                form.append(input1);

                var input2 = $('<input>');
                input2.attr('name', 'reqId');
                input2.attr('value', $.unparam(param)['reqId']);
                form.append(input2);

                var input3 = $('<input>');
                input3.attr('name', 'time');
                input3.attr('value', $.unparam(param)['time']);
                form.append(input3);

                var input4 = $('<input>');
                input4.attr('name', 'column');
                input4.attr('value', $.unparam(param)['column']);
                form.append(input4);

                if ($.unparam(param)['grpName']) {
                    var input5 = $('<input>');
                    input5.attr('name', 'grpName');
                    input5.attr('value', $.unparam(param)['grpName']);
                    form.append(input5);
                }
            }
            $('body').append(form);
            form.submit();
            form.remove();
            return false;
        });
        $(SEL_SIDEBAR_TABS).on('shown.bs.tab', 'li', function (e, data) {
            var $tab = $(this),
                category = $tab.find('a').data('category'),
                title = $.trim($tab.text());
            param.category = category;
            delete param.ind;
            if (title) {
                $('title').text($('title').text().replace(/^(.+ - )?(.+)$/, title + ' - $2'));
            }
            loadData();
        }).on('click', 'li a', function (e, data) {
            data = $.extend(data, {});
            var category = $(this).data('category');

            // Cover tab is not allowed for prefecture user.
            if (category == 'cover' && getMapLevel() >= 3) {
                alerts.tip('该地图级别不支持切换到网络覆盖！请先返回上一级。');
                return false;
            }

            // Change page history
            if ($.support.html5History && !data.skipHistory) {
                history[data.firstLoad ? 'replaceState' : 'pushState']({
                    type: 'sidebar-tab',
                    target: category
                }, null, "#" + category);
            }
        });
        $('.js-btn-reload').click(function () {
            loadData();
            return false;
        });
        $(SEL_BTN_MAP_RETURN).click(function () {
            param.geoId = geoHistories.pop();
            loadData();
            return false;
        });
        $(SEL_MAP_TOOLBOX).on('click', '.js-btn-save-as-image', function (e) {
            var $this = $(this),
                chart;
            if ($this.is('.js-chart-extra1')) {
                if (chartExtra1) {
                    chartExtra1.component.toolbox._onSaveAsImage();
                }
            } else if ($this.is('.js-chart-extra2')) {
                if (chartExtra2) {
                    chartExtra2.component.toolbox._onSaveAsImage();
                }
            } else {
                chart = map && map.getMap();
                if (chart) {
                    chart.component.toolbox._onSaveAsImage();
                }
            }
            return false;
        }).on('click', '.js-btn-show-bar-chart', function (e) {
            togglePerformanceBarChart();
            return false;
        });
        // Handle page history
        $(window).on("popstate", function (e) {
            var state = $.extend(e.originalEvent.state, {});
            console.log("Change page history:", state);
            if (state.type == "sidebar-tab" && state.target && $(SEL_SIDEBAR_TABS + ' li a[data-category="' + state.target + '"]').length > 0) {
                $(SEL_SIDEBAR_TABS + ' li a[data-category="' + state.target + '"]').trigger("click", {skipHistory: true});
            }
        });
        $(SEL_MAP_TITLE_GIS).on('click', '.sceneLegend .sceneLegendBtn', function (e) {
            $(this).hide();
            $(SEL_MAP_TITLE_GIS).find('.sceneLegend .legendInfo').show();
            $('.editLegend').hide();
        }).on('click', '.sceneLegend .legendInfo', function (e) {
            $(this).hide();
            $(SEL_MAP_TITLE_GIS).find('.sceneLegend .sceneLegendBtn').show();
        }).on('mouseover', '.sceneLegend .legendInfo', function () {
            $('#jsMapTileGis').find('.editLegend').show();
        }).on('mouseout', '.sceneLegend .legendInfo', function () {
            $('#jsMapTileGis').find('.editLegend').hide();
        }).on('click', '.sceneLegend .editLegend', function () {
            $(SET_MAP_TITLE_EDIT_GIS).find('.editContent').show();
            return false;
        });
        $(SET_MAP_TITLE_EDIT_GIS).on('click', '.but.saveRange', function () {
            var colorBlocks = $(SET_MAP_TITLE_EDIT_GIS).find('.legendEditWindow .colorRange>div');
            $.each(colorBlocks, function (i, colorBlock) {
                var id = $(colorBlock).attr('id'),
                    title = $(colorBlock).find('.startDigit').val() + $(colorBlock).find('.unit').attr('value') + '-' + $(colorBlock).find('.endDigit').val() + $(colorBlock).find('.unit').attr('value');
                $(SEL_MAP_TITLE_GIS).find('.sceneLegend .legendInfo .legend ').find('.' + id).attr('title', title);
                $(SEL_MAP_TITLE_GIS).find('.sceneLegend .legendInfo .legend ').find('.' + id).parent().find('.itemName').attr('title', title);
            });
            /*
             * 保存门限设置的接口调用
             * */
            var category = param.category,
                $selectedIndicator = $(getSidebarSelector(category)).find('.list-group-item.active'),
                kpi_id = $.unparam($selectedIndicator.data('cond')).reqId,
                up1_limit = $(SET_MAP_TITLE_EDIT_GIS).find('#red .startDigit').val(),
                low1_limit = $(SET_MAP_TITLE_EDIT_GIS).find('#red .endDigit').val(),
                up2_limit = $(SET_MAP_TITLE_EDIT_GIS).find('#orange .startDigit').val(),
                low2_limit = $(SET_MAP_TITLE_EDIT_GIS).find('#orange .endDigit').val(),
                up3_limit = $(SET_MAP_TITLE_EDIT_GIS).find('#yellow .startDigit').val(),
                low3_limit = $(SET_MAP_TITLE_EDIT_GIS).find('#yellow .endDigit').val(),
                up4_limit = $(SET_MAP_TITLE_EDIT_GIS).find('#green .startDigit').val(),
                low4_limit = $(SET_MAP_TITLE_EDIT_GIS).find('#green .endDigit').val();
            if (up1_limit - 0 >= low1_limit - 0) {
                alerts.tip("一级的最小值门限不能大于等于最大值门限！");
                return;
            } else if (up2_limit - 0 >= low2_limit - 0) {
                alerts.tip("二级的最小值门限不能大于等于最大值门限！");
                return;
            } else if (up3_limit - 0 >= low3_limit - 0) {
                alerts.tip("三级的最小值门限不能大于等于最大值门限！");
                return;
            } else if (up4_limit - 0 >= low4_limit - 0) {
                alerts.tip("正常的最小值门限不能大于等于最大值门限！");
                return;
            }

            var kpi_levels = ['1_' + up1_limit + '_' + low1_limit, '2_' + up2_limit + '_' + low2_limit, '3_' + up3_limit + '_' + low3_limit, '4_' + up4_limit + '_' + low4_limit],
                params = {
                    kpi_id: kpi_id,
                    kpi_levels: kpi_levels
                };
            ajax.init().success(function (code, msg, data) {
                if (code == C.AJAX_CODE.OK) {
                    alerts.tip(C.MESSAGE.SUCCESS_SAVE);
                    refreshGis();
                }
            }).error(function (code, msg, data) {
                if (code !== C.AJAX_CODE.LOGIN_REQUIRED) {
                    alerts.tip(msg || C.MESSAGE.UNKNOWN_ERROR);
                }
            }).complete(function (jqXHR, textStatus) {
            }).post(conf.AJAX.OVERVIEW_PM_CUSTOM_RANGE, params);
            $(SET_MAP_TITLE_EDIT_GIS).find('.editContent').hide();
        }).on('click', '.but.cancelRange', function () {
            $(SET_MAP_TITLE_EDIT_GIS).find('.editContent').hide();
        }).on("change", ".colorRange input", function () {
            var pre_brother = $(this).parent().prev(),
                next_brother = $(this).parent().next();
            if('high' == $(SEL_SIDEBAR_CONTENT).find('.editContent').attr('data-style')){
                if($(this).attr('class') == 'startDigit' && pre_brother ){
                    if($(this).val().split('.')[1] && $(this).val().split('.')[1].length > 2){
                        alerts.tip("门限值最多为两位小数!");
                        return ;
                    }
                    else{
                        pre_brother.find('.endDigit').val($(this).val());
                    }
                }
                else if($(this).attr('class') == 'endDigit' && next_brother){
                    if($(this).val().split('.')[1] && $(this).val().split('.')[1].length > 2){
                        alerts.tip("门限值最多为两位小数!");
                        return ;
                    }
                    else{
                        next_brother.find('.startDigit').val($(this).val());
                    }
                }
            }
            else if('low' == $(SEL_SIDEBAR_CONTENT).find('.editContent').attr('data-style')){
                if($(this).attr('class') == 'startDigit' && pre_brother ){
                    if($(this).val().split('.')[1] && $(this).val().split('.')[1].length > 2){
                        alerts.tip("门限值最多为两位小数!");
                        return;
                    }
                    else{
                        next_brother.find('.endDigit').val($(this).val());
                    }
                }
                else if($(this).attr('class') == 'endDigit' && next_brother){
                    if($(this).val().split('.')[1] && $(this).val().split('.')[1].length > 2){
                        alerts.tip("门限值最多为两位小数!");
                        return ;
                    }
                    else{
                        pre_brother.find('.startDigit').val($(this).val());
                    }
                }
            }
        });
        $('#jsSidebarPerformance').on('change', '.timeType', function () {// 今天
            var today = new Date();
            today.setHours(0);
            today.setMinutes(0);
            today.setSeconds(0);
            today.setMilliseconds(0);
            var oneday = 1000 * 60 * 60 * 24;
            // 昨天
            var yesterday = new Date(today - oneday);
            // 上周一
            var lastMonday = new Date(today - oneday * (today.getDay() + 6));
            // 上个月1号
            var lastMonthFirst = new Date(today - oneday * today.getDate());
            lastMonthFirst = new Date(lastMonthFirst - oneday * (lastMonthFirst.getDate() - 1));

            var htmlstr = '<input type="text" class="form-control input-sm" id="inputTimePerformance" />';
            if ($(this).val() == 3) {
                $('#jsSidebarPerformance .dateTime').empty();
                $('#jsSidebarPerformance .dateTime').append(htmlstr);
                $('#jsSidebarPerformance .form-control').datetimepicker({
                    viewMode: 'days', format: 'YYYY-MM-DD 00:00:00'/*,disabledDates: [
                     moment("12/25/2013"),
                     new Date(2013, 11 - 1, 21),
                     "11/22/2013 00:53"
                     ]*/
                });
                $('#jsSidebarPerformance .form-control').val(lastMonthFirst.format(dataFormat.masks.isoDateTimeNew));
            }
            else if ($(this).val() == 2) {
                $('#jsSidebarPerformance .dateTime').empty();
                $('#jsSidebarPerformance .dateTime').append(htmlstr);
                $('#jsSidebarPerformance .form-control').datetimepicker({
                    viewMode: 'days', format: 'YYYY-MM-DD 00:00:00', daysOfWeekDisabled: [0, 2, 3, 4, 5, 6]
                });
                $('#jsSidebarPerformance .form-control').val(lastMonday.format(dataFormat.masks.isoDateTimeNew));
            }
            else if ($(this).val() == 1) {
                $('#jsSidebarPerformance .dateTime').empty();
                $('#jsSidebarPerformance .dateTime').append(htmlstr);
                $('#jsSidebarPerformance .form-control').datetimepicker({
                    viewMode: 'days', format: 'YYYY-MM-DD 00:00:00'
                });
                $('#jsSidebarPerformance .form-control').val(yesterday.format(dataFormat.masks.isoDateTimeNew));
            }
            else if ($(this).val() == 0) {
                $('#jsSidebarPerformance .dateTime').empty();
                $('#jsSidebarPerformance .dateTime').append(htmlstr);
                $('#jsSidebarPerformance .form-control').datetimepicker({
                    viewMode: 'days', format: 'YYYY-MM-DD HH:00:00'
                });
                getTime('performance', function (time) {
                    $('#jsSidebarPerformance .form-control').val(time);
                });
            }
        });
        $('#jsSidebarPerformance .timeType').trigger('change');
    }

    function getResurceList(param, column, callback) {
        ajax.init().success(function (code, msg, data) {
            var tempObj = {};
            var dataObj = [];
            if (data.list && data.list.length > 0) {
                tempObj = data.list;
                $.each(tempObj, function (i, temp) {
                    if (column == "city_name") {
                        dataObj.push([temp.CITY_NAME, temp.COUNT]);
                    } else if (column == "town_name") {
                        dataObj.push([temp.TOWN_NAME, temp.COUNT]);
                    } else if (column == "area_1") {
                        dataObj.push([temp.AREA_1, temp.COUNT]);
                    } else if (column == "area_2") {
                        dataObj.push([temp.AREA_2, temp.COUNT]);
                    } else if (column == "area_3") {
                        dataObj.push([temp.AREA_3, temp.COUNT]);
                    } else if (column == "area_4") {
                        dataObj.push([temp.AREA_4, temp.COUNT]);
                    } else if (column == "area_5") {
                        dataObj.push([temp.AREA_5, temp.COUNT]);
                    }
                });
            } else {
                dataObj = null;
            }
            callback(dataObj);
        }).error(function (code, msg, data) {
            if (code !== C.AJAX_CODE.LOGIN_REQUIRED) {
                alerts.tip(msg || C.MESSAGE.UNKNOWN_ERROR);
            }
            callback(null);
        }).complete(function (jqXHR, textStatus) {
        }).post(conf.AJAX.OVERVIEW_RESOURCE_LIST, param);
    }

    function listData(obj, column, type) {
        var key,
            geoname,
            reqname,
            urlkey,
            paramkey,
            regname;
        if (type == 1) {
            key = $(obj).data("cond");
        } else if (type == 2 || type == 3) {
            key = $("#key").data("key");
        } else if (type == 4) {
            urlkey = $(obj).data("conf");
            key = $("#key").data("key");
        }
        if (type == 1) {
            regname = "区县";
        } else {
            regname = $(".js-statistics-type-select option:selected").text()
        }
        if (type == 4) {
            geoname = $.unparam(urlkey)['grpName'];
            regname = "乡镇";
        } else {
            geoname = geo.getFullName($.unparam(key)['geoId']);
        }
        reqname = $.unparam(key)['reqId'];
        switch (reqname) {
            case "8104":
                reqname = "基站";
                break;
            case "8105":
                reqname = "小区";
                break;
            case "8111":
                reqname = "RRU";
                break;
            case "8112":
                reqname = "天线";
                break;
            case "10007":
                reqname = "站址";
                break;
        }
        if (type == 1) {
            urlkey = key + "&column=" + column;
            paramkey = key + "&column=town_name";
        } else if (type == 2) {
            urlkey = key + "&column=" + column;
            paramkey = key;
            if ($(".js-statistics-type-select").val() == "city_name") {
                urlkey = key + "&column=" + column;
                paramkey = key + "&column=town_name";
            }
        } else if (type == 3) {
            urlkey = key + "&column=city_name";
            paramkey = key + "&column=town_name";
        }
        getResurceList(urlkey, column, function (data) {
            $(".ne-type-statistics").html(tmpl(TPL_NETYPE_LIST, {
                geoName: geoname,
                reqName: reqname,
                regname: regname,
                column: column,
                paramkey: paramkey,
                key: key,
                data: data,
                urlkey: urlkey
            }));
            if (data && data.length > 15) {
                paginationResource(1);
            }
            if (type == 2) {
                $(".js-statistics-type-select").val(column);
            }
        });
    }

    function paginationResource(start) {
        var i = (start - 1) * 6;
        var tr = $(".js-statistics-table-detail>tr");
        tr.hide();
        for (var j = 0; j < 6; j++) {
            $(tr[i + j]).show();
        }
        var sum = $(".js-page-num").length;
        $(".js-start").removeClass("disabled");
        $(".js-end").removeClass("disabled");
        if (start == 1) {
            $(".js-start").addClass("disabled");
        } else if (start == sum) {
            $(".js-end").addClass("disabled");
        }
    }

    function initMap() {
        var chart;

        map = echartsMap.init(SEL_MAP_CHART, mapOption).on(echartsMap.EVENT.IN_PROVENCE, function (map, mapParam) {
            console.debug('Go into provence:', mapParam.target);
            geoHistories.push(param.geoId);
            param.geoId = geo.codes[mapParam.target];
            loadData();
        }).on(echartsMap.EVENT.IN_REGION, function (map, mapParam) {
            if (param.category == 'cover') {
                return;
            }
            console.debug('Go into region.');
            geoHistories.push(param.geoId);
            param.geoId = geo.codes[mapParam.target];
            loadData();
        }).on(echartsMap.EVENT.CLICK, function () {
            console.error(arguments);
        }).on(echartsMap.EVENT.MAGIC_TYPE_CHANGED, function () {
            console.error(arguments);
        });
        chart = map.getMap();
        return chart != null;
    }

    function loadData() {
        console.debug('Load data:', param);

        if (param.category != 'cover' && !URLS_LOAD_DATA[param.category]) {
            console.error('No ajax urls.');
            return;
        }

        if (jqXhrQueryByGeo != null) {
            jqXhrQueryByGeo.abort();
            jqXhrQueryByGeo = null;
        }
        if (jqXhrQueryByInd != null) {
            jqXhrQueryByInd.abort();
            jqXhrQueryByInd = null;
        }
        if (jqXhrQueryByTime != null) {
            jqXhrQueryByTime.abort();
            jqXhrQueryByTime = null;
        }
        loadSidebar(loadMap);
    }

    function loadSidebar(callback) {
        var category = param.category,
            ind = param.ind,
            time = getTime(category),
            sumLevel = $('#jsSidebarPerformance .timeType option:checked').attr("value");

        /*if (category == 'cover') {
         processSidebar(C.AJAX_CODE.OK, null, null, category, ind, time);
         if (callback) {
         callback();
         }
         return;
         }*/

        alerts.loading(true);

        if (category == 'performance' && $.isEmptyString(time)) {
            // Wait to get default time.
            getTime(category, function (time) {
                if (time != null) {
                    // Then load again.
                    loadSidebar(callback);
                } else {
                    processMapEmptyData();
                    alerts.loading(false);
                }
            });
            return;
        }

        param.time = time;

        jqXhrQueryByGeo = ajax.init().success(function (code, msg, data) {
            processSidebar(code, msg, data, category, ind, time, sumLevel);
            if (callback) {
                callback();
            } else {
                processMapEmptyData();
                alerts.loading(false);
            }
        }).error(function (code, msg, data) {
            alerts.loading(false);
            if (code !== C.AJAX_CODE.LOGIN_REQUIRED) {
                processMapEmptyData();
                alerts.tip(msg || C.MESSAGE.UNKNOWN_ERROR);
            }
        }).complete(function (jqXHR, textStatus) {
            if (textStatus != 'abort') {
                jqXhrQueryByGeo = null;
            }
        }).post(URLS_LOAD_DATA[category].queryByGeo, {
            geoId: param.geoId,
            time: time,
            sumLevel: $('.timeType option:checked').attr("value")
        });
    }

    function loadMap() {
        console.debug('Load map:', param);
        var category = param.category,
            geoId = param.geoId,
            mapLevel = getMapLevel(),
            $selectedIndicator = $(getSidebarSelector(category)).find('.list-group-item.active'),
            title = $selectedIndicator.data('title'),
            unit = $selectedIndicator.data('unit'),
            value = $selectedIndicator.data('value'),
            cond = $selectedIndicator.data('cond'),
            group = $selectedIndicator.closest('.panel').find('.panel-title a').data('title');

        if ($selectedIndicator.length === 0) {
            console.error('No active indicator.');
            processMapTitle(geoId, category, null);
            refreshMapToolbox(false);
            alerts.loading(false);
            return;
        }

        processMapTitle(category, title, unit, value, $.unparam(cond));
        refreshMapToolbox();

        console.debug('Selected indicator:', group, title, cond);
        console.debug('Map level:', mapLevel);

        param.ind = [group, title];

        alerts.loading(true);

        if (mapLevel >= 3) {
            param.mapCond = null;
            param.region = null;
            geo.getCenterAndZoom(param.geoId, function (location) {
                var handlerCancelLoading = null,
                    callbackPageLoaded = function (e) {
                        if (e) {
                            console.log('Gis page loaded: ', e);
                        } else {
                            console.warn('Gis page timeout: ', e);
                        }
                        $(SEL_MAP_GIS).removeClass('hidden');
                        callGis("setShowDialogHandler", [function (intId, neType) {
                            gisDialog.showContextDialog(intId, neType, getTimeForDialog);
                        }]);
                        toggleMapReturnBtn();
                        if (category == 'resource') {
                            alerts.loading(false);
                        } else {
                            if (callGis('getInited') === false) {
                                callGis('setInitCallback', [function () {
                                    alerts.loading(false);
                                }])
                            } else {
                                alerts.loading(false);
                            }
                        }

                        if (handlerCancelLoading != null) {
                            clearTimeout(handlerCancelLoading);
                        }
                    };

                if (location) {
                    console.log('Region Location:', location);
                    map.hide();
                    handlerCancelLoading = setTimeout(function () {
                        handlerCancelLoading = null;
                        callbackPageLoaded();
                    }, 60000);
                    $(SEL_MAP_GIS).empty().append(
                        $('<iframe style="width: 100%; height: 100%;"></iframe>')
                            .load(callbackPageLoaded)
                            .attr('src', (category == 'resource' ? conf.PAGE.GIS_MAP : conf.PAGE.GIS_MAP_ALARM) + '?' + $.param($.extend({
                                    //referrerPath: conf.BASE_PATH,
                                    page: 'resource',
                                    where: (geo.isCounty(param.geoId) ? 'CITY_ID=' : 'REGION_ID=') + param.geoId,
                                    type: category,
                                    cond: category == 'resource' ? null : encodeURIComponent(cond),
                                    resourceType: category == 'resource' && $.unparam(cond)['reqId'] ? RES_KEY_MAP[$.unparam(cond)['reqId']] : null
                                }, location)))
                    );
                } else {
                    console.error('Fail to find extent for this region:', param.geoId, geo.names[param.geoId]);
                    if (geoHistories.length > 0) {
                        param.geoId = geoHistories.pop();
                    }
                    alerts.loading(false);
                }
            });
        } else {
            param.mapCond = cond;
            $(SEL_MAP_GIS).addClass('hidden').empty();
            map.show();
            jqXhrQueryByInd = ajax.init().success(function (code, msg, data) {
                processMapData(code, msg, data, cond, category, title, unit);
            }).error(function (code, msg, data) {
                if (code !== C.AJAX_CODE.LOGIN_REQUIRED) {
                    processMapEmptyData(title);
                    alerts.tip(msg || C.MESSAGE.UNKNOWN_ERROR);
                }
            }).complete(function (jqXHR, textStatus) {
                if (textStatus != 'abort') {
                    jqXhrQueryByInd = null;
                    alerts.loading(false);
                }
            }).post(URLS_LOAD_DATA[category].queryByInd, cond);
        }
    }

    function processSidebar(code, msg, data, category, ind, time, sumLevel) {
        var groups = [];

        if (code == C.AJAX_CODE.NO_DATA || !data) {
            data = {};
        }

        if (category == 'alarm') {
            groups = getAlarmIndicators(data.tree);
        } else if (category == 'performance') {
            groups = getPerformanceIndicators(data.list, time, sumLevel);
        } else if (category == 'resource') {
            groups = getResourceIndicators(data.list, time);
        } else if (category == 'cover') {
            //groups = getCoverIndicators();
            groups = getCoverIndicators2(data.list);
        } else {
            console.error('Unknown category.');
        }

        if (groups && groups.length > 0) {
            processSidebarActive(groups, ind);
            $(getSidebarSelector(category)).find('.js-indicators').html(
                tmpl(TPL_SIDEBAR_IND, {category: param.category, groups: groups}));
            console.debug('Processed groups:', groups.length, groups);
        } else {
            $(getSidebarSelector(category)).find('.js-indicators').empty();
            console.error('Fail to get sidebar indicators.');
            //alerts.loading(false);
        }
    }

    function processSidebarActive(groups, ind) {
        var found = false,
            group = null;
        $.each(groups, function (i, group) {
            if (ind ? ind[0] == group.title : i == 0) {
                $.each(group.items, function (j, item) {
                    if (ind ? ind[1] == item.title : j == 0) {
                        item.active = true;
                        group.active = true;
                        found = true;
                        return false;
                    }
                });
                if (found) {
                    return false;
                }
            }
        });
        if (!found && ind != null) {
            processSidebarActive(groups, null);
        }
    }

    function processMapTitle(category, title, unit, value, cond) {
        if (!title || getMapLevel() >= 3) {
            $(SEL_MAP_TITLE).removeData('title').addClass("hidden").empty();

            // GIS legend
            if ("alarm" == category || "performance" == category) {
                $(SEL_MAP_TITLE_GIS).removeClass("hidden");
                value = value ? value + (unit || '') : '-';
                if ("performance" == category) {
                    $(SET_MAP_TITLE_EDIT_GIS).removeClass("hidden");
                    ajax.init().success(function (code, msg, data) {
                        if (code == C.AJAX_CODE.OK && data && data.levels && data.levels.length > 0) {
                            $(SEL_SIDEBAR_CONTENT).find('.sceneLegend').html(tmpl(TPL_OVEARVIAEW_LEGEND, {
                                GeoName: geo.names[param.geoId],
                                condName: title,
                                condValue: value,
                                legend: MAPTITLE[category],
                                range: data.levels,
                                unit: value.split(/[\d+\.?\d]/)[value.split(/[\d+\.?\d]/).length - 1]
                            }));
                            $(SEL_SIDEBAR_CONTENT).find('.editContent').empty();
                            $(SEL_SIDEBAR_CONTENT).find('.editContent').html(tmpl(TPL_LEGEND_EDIT, {
                                legend: MAPTITLE[category],
                                range: data.levels,
                                unit: value.split(/[\d+\.?\d]/)[value.split(/[\d+\.?\d]/).length - 1]
                            })).hide();
                            if(data.levels[0].start < data.levels[1].start){
                                $(SEL_SIDEBAR_CONTENT).find('.editContent').attr('data-style','high');
                            }else{$(SEL_SIDEBAR_CONTENT).find('.editContent').attr('data-style','low');}
                            $(SEL_SIDEBAR_CONTENT).find('.sceneLegend .sceneLegendBtn').trigger('click');
                        }
                        else if (code == C.AJAX_CODE.OK && data && data.levels && data.levels.length == 0) {
                            $(SEL_SIDEBAR_CONTENT).find('.sceneLegend').html(tmpl(TPL_OVEARVIAEW_LEGEND, {
                                GeoName: geo.names[param.geoId],
                                condName: title,
                                condValue: value,
                                legend: MAPTITLE[category]
                            }));
                            $(SEL_SIDEBAR_CONTENT).find('.editContent').empty();
                            $(SEL_SIDEBAR_CONTENT).find('.editContent').html(tmpl(TPL_LEGEND_EDIT, {
                                legend: MAPTITLE[category],
                                unit: value.split(/[\d+\.?\d]/)[value.split(/[\d+\.?\d]/).length - 1]
                            })).hide();
                            $(SEL_SIDEBAR_CONTENT).find('.sceneLegend .sceneLegendBtn').trigger('click');
                        }
                    }).error(function (code, msg, data) {
                        if (code !== C.AJAX_CODE.LOGIN_REQUIRED) {
                            alerts.tip(msg || C.MESSAGE.UNKNOWN_ERROR);
                        }
                    }).complete(function (jqXHR, textStatus) {

                    }).post(conf.AJAX.OVERVIEW_MAPTITLE_RANGE, {
                        kpiId: cond.reqId
                    });
                }
                else {
                    $(SEL_MAP_TITLE_GIS).find('.sceneLegend').html(tmpl(TPL_OVEARVIAEW_LEGEND, {
                        GeoName: geo.names[param.geoId],
                        condName: title,
                        condValue: value,
                        legend: MAPTITLE[category]
                    }));
                    $(SEL_MAP_TITLE_GIS).find('.sceneLegend .sceneLegendBtn').trigger('click');
                }
            }
            else {
                $(SEL_MAP_TITLE_GIS).addClass("hidden").find('.sceneLegend').empty();
                $(SET_MAP_TITLE_EDIT_GIS).addClass("hidden").find('.editContent').empty();
            }

            return;
        }

        //if (category == 'alarm') {
        //    category = '告警概览';
        //} else if (category == 'performance') {
        //    category = '性能概览';
        //} else if (category == 'resource') {
        //    category = '资源概览';
        //} else {
        //    console.error('Unknown category.');
        //    category = '';
        //}

        value = value ? value + (unit || '') : '-';
        $(SEL_MAP_TITLE_GIS).addClass("hidden").find('.sceneLegend').empty();
        $(SET_MAP_TITLE_EDIT_GIS).addClass("hidden").find('.editContent').empty();
        $(SEL_MAP_TITLE).data('title', title).removeClass("hidden")
            .html(title + ' - <del>' + geo.names[param.geoId] + '</del><br><h4>' + value + '</h4>');
    }

    function processMapData(code, msg, data, cond, category, title, unit) {
        var mapData = null;

        toggleMapReturnBtn();

        if (code == C.AJAX_CODE.NO_DATA || !data) {
            data = {};
        }

        if (category == 'alarm') {
            mapData = getAlarmMapData(data.data);
        } else if (category == 'performance') {
            mapData = getPerformanceMapData(data, unit);
        } else if (category == 'resource') {
            mapData = getResourceMapData(data.list);
        } else if (category == 'cover') {
            mapData = getCoverMapData(data, param.geoId);
        } else {
            console.error('Unknown category.');
        }

        if (mapData) {
            console.debug('mapData:', mapData);
            map.setOption({
                title: {
                    //show: true,
                    text: title + ' - ' + geo.names[param.geoId]
                },
                tooltip: mapData.tooltip,
                /*toolbox: category == 'performance' ? {
                 feature: {
                 magicType: {
                 show: true,
                 title : {
                 bar : '展现柱形图'
                 },
                 type: ['bar']
                 }
                 }
                 } : null,*/
                dataRange: mapData.heatmap ? null : $.extend({}, dataRange, mapData.dataRange),
                series: [{
                    name: title,
                    mapType: getMapType(param.geoId),
                    itemStyle: mapData.itemStyle,
                    heatmap: mapData.heatmap,
                    data: mapData.data,
                    unit: unit,
                    cond: cond
                }]
            }, true);
            refreshMapToolbox();
            if (category !== 'performance') {
                togglePerformanceBarChart(false);
            } else {
                refreshPerformanceBarChart();
            }
        } else {
            processMapEmptyData(title);
        }
    }

    function processMapEmptyData(title) {
        toggleMapReturnBtn();

        map.setOption({
            dataRange: null,
            series: [{
                name: title || '',
                mapType: getMapType(param.geoId)
            }]
        }, true);
        refreshMapToolbox(false);
    }

    function getAlarmIndicators(list) {
        var groups = [];
        if ($.isArray(list)) {
            $.each(list, function (i, groupObj) {
                var items = [];
                if (groupObj && groupObj.classify && $.isArray(groupObj.alarmInfoEntry)) {
                    $.each(groupObj.alarmInfoEntry, function (j, itemObj) {
                        if (itemObj.alarmCounterName && itemObj.alarminquiryuri && itemObj.alarmkey) {
                            items.push({
                                title: itemObj.alarmCounterName,
                                value: itemObj.alarmCount,
                                cond: $.param({alarminquiryuri: itemObj.alarminquiryuri, alarmkey: itemObj.alarmkey})
                            });
                        }
                    });
                    if (items.length > 0) {
                        groups.push({title: groupObj.classify, items: items});
                    }
                }
            });
        }
        return groups;
    }

    function getAlarmMapData(list) {
        var data = [],
            min = 0,
            max = 4;
        if ($.isArray(list)) {
            $.each(list, function (i, item) {
                if (item.objectid) {
                    data.push({
                        name: geo.names[item.objectid],
                        value: item.alarmInfoEntry && item.alarmInfoEntry[0] && item.alarmInfoEntry[0].alarmCount || 0,
                        geoId: item.objectid
                    })
                }
            })
        }
        if (data.length > 0) {
            $.each(data, function (i, obj) {
                min = Math.min(min, obj.value);
                max = Math.max(max, obj.value);
            });
            max = Math.ceil((max - min) / 4) * 4 + min;
            return {
                data: data,
                dataRange: charts.calculateDataRange(min, max, 4)
            };
        }
        return null;
    }

    function getPerformanceIndicators(list, time, sumLevel) {
        var groups = [];
        if ($.isArray(list)) {
            $.each(list, function (i, groupObj) {
                var items = [];
                if (groupObj.classify && $.isArray(groupObj.data)) {
                    $.each(groupObj.data, function (j, itemObj) {
                        if (itemObj.name && itemObj.column && itemObj.type) {
                            items.push({
                                title: itemObj.name,
                                value: itemObj.value,
                                unit: itemObj.unit,
                                cond: $.param({
                                    geoId: param.geoId,
                                    reqId: itemObj.column,
                                    type: itemObj.type,
                                    time: time,
                                    sumLevel: sumLevel,
                                    userId: conf.USER_ID
                                })
                            })
                        }
                    });
                    if (items.length > 0) {
                        groups.push({title: groupObj.classify, items: items});
                    }
                }
            });
        }
        return groups;
    }

    function getPerformanceMapData(rawData, unit) {
        var data = [],
            min = 0,
            max = 4,
            dataRange = {};
        if ($.isArray(rawData.data)) {
            $.each(rawData.data, function (i, item) {
                if (item.PROVINCE_ID) {
                    data.push({
                        name: geo.names[item.PROVINCE_ID],
                        value: echartsMap.roundValue(item.VALUE, rawData.precision),
                        geoId: item.PROVINCE_ID
                    })
                }
            })
        }
        if (rawData.levels && rawData.levels.length > 0) {
            dataRange.splitList = rawData.levels;
            dataRange.color = ['#d9534f', '#f0ad4e', '#f0ea4d', '#5cb85c']; // #5bc0de
        }
        dataRange.precision = rawData.precision;
        if (data.length > 0) {
            if (!dataRange.splitList) {
                $.each(data, function (i, obj) {
                    if (obj.name === geo.names[param.geoId]) {
                        return;
                    }
                    min = Math.min(min, obj.value);
                    max = Math.max(max, obj.value);
                });
                max = Math.ceil((max - min) / 4) * 4 + min;
                dataRange = charts.calculateDataRange(min, max, 4, 0);
                dataRange.color = ['#d9534f', '#f0ad4e', '#f0ea4d', '#5cb85c']; // #5bc0de
            }
            charts.addUnitToSplitList(dataRange.splitList, charts.isUnitMeaningful(unit) ? unit : '');
            console.debug('dataRange:', dataRange);
            return {
                tooltip: {
                    formatter: function (params, ticket, callback) {
                        return strings.format('{0}：{1}',
                            params.name,
                            params.value === '-' ? params.value : params.value + (charts.isUnitMeaningful(unit) ? unit : ''));
                    }
                },
                data: data,
                dataRange: dataRange
            };
        }
        return null;
    }

    function togglePerformanceBarChart(show) {
        if (show === undefined) {
            show = !isExtraChartVisible();
        }
        if (show) {
            $(SEL_CHART_EXTRA).removeClass('hidden');
        } else {
            $(SEL_CHART_EXTRA).addClass('hidden');
        }
        refreshMapToolbox();
        refreshPerformanceBarChart();
    }

    function refreshPerformanceBarChart() {
        if (!isExtraChartVisible()) {
            return;
        }

        if (!chartExtra1) {
            chartExtra1 = echarts.init($(SEL_CHART_EXTRA).find('.js-chart-extra-1')[0], 'macarons').on('click', function (param) {
                var data = (map.getOption().series[0] || {}).data,
                    index = param.dataIndex + 1;
                if (data && data[index] && data[index].geoId) {
                    drawPerformanceLineChart(chartExtra2, data[index].geoId)
                }
                return false;
            });
        }
        if (!chartExtra2) {
            chartExtra2 = echarts.init($(SEL_CHART_EXTRA).find('.js-chart-extra-2')[0], 'macarons');
        }
        drawPerformanceBarChart(chartExtra1);
        drawPerformanceLineChart(chartExtra2);
    }

    /**
     * @Deprecated
     */
    function showPerformanceBarChart() {
        var title = param.ind[1],
            time = param.time;

        BootstrapDialog.show({
            title: (title || '') + (title && time ? '（' + time.replace(/:00$/, '') + '）' : ''),
            message: function (dialog) {
                return $('<div><div class="chart js-chart-overview"></div><div class="chart js-chart-trend"></div></div>');
            },
            onshown: function (dialog) {
                var $message = dialog.getModalBody().find('.' + dialog.getNamespace('message')),
                    chart = echarts.init($message.find('.js-chart-overview')[0], 'macarons');
                drawPerformanceBarChart(echarts.init($message.find('.js-chart-overview')[0], 'macarons'));
            }
        });
    }

    function drawPerformanceBarChart(chart) {
        var mapOption = map.getOption(),
            data = (mapOption.series[0] || {}).data,
            unit = (mapOption.series[0] || {}).unit,
            title = param.ind[1],
            time = param.time,
            lineData = [],
            values = [],
            xLabels = [];

        if (!data) {
            return;
        }

        $.each(data, function (i, item) {
            if (item.name) {
                if (i == 0) {
                    lineData.push({name: item.name, value: item.value, xAxis: -1, yAxis: item.value});
                    lineData.push({xAxis: Number.MAX_VALUE, yAxis: item.value});
                } else {
                    values.push(item.value);
                    xLabels.push(item.name);
                }
            }
        });
        //console.debug('barChart:', values, xLabels);

        chart.setOption({
            //calculable : true,
            title: {
                text: title + "区域对比",
                x: 'center'
            },
            tooltip: {
                trigger: 'axis'
            },
            xAxis: [
                {
                    type: 'category',
                    data: xLabels,
                    axisLabel: {
                        interval: 0, //全部显示
                        formatter: function (val) {
                            return val && val.split('').join("\n") || '';
                        }
                        //rotate: -70 //旋转角度
                    }
                }
            ],
            yAxis: [
                $.extend({
                    type: 'value',
                    axisLabel: {
                        formatter: '{value}' + unit
                    }
                }, charts.calculateAxisRange(values, unit))
            ],
            series: [
                {
                    name: title + "(" + unit + ")",
                    type: 'bar',
                    data: values,
                    markLine : {
                        clickable: false,
                        symbol: 'circle',
                        symbolSize: 2,
                        /*effect: {
                            show: true
                        },*/
                        itemStyle: {
                            normal: {
                                color: '#5cb85c',
                                label: {
                                    show: false
                                }
                            }
                        },
                        data : [lineData]
                    }
                }
            ]
        }, true);
    }

    function drawPerformanceLineChart(chart, geoId) {
        var mapOption = map.getOption(),
            data = (mapOption.series[0] || {}).data,
            unit = (mapOption.series[0] || {}).unit,
            cond = (mapOption.series[0] || {}).cond,
            title = param.ind[1],
            sumLevel = $.unparam(cond).sumLevel || 0,
            timeRange = ['24小时', '30天', '12周', '12月'][sumLevel] || '24小时',
            values = [],
            xLabels = [];

        geoId = geoId || data && data[0] && data[0].geoId || param.geoId;

        jqXhrQueryByTime = ajax.init().success(function (code, msg, data) {
            if (code === C.AJAX_CODE.OK && data && data.list) {
                $.each(data.list, function (i, item) {
                    values.push(item.VALUE);
                    xLabels.push(item.TIME ? (sumLevel == 0 ? item.TIME.replace(/^\d{4}-/, '') + ':00' : item.TIME.replace(/^\d{4}-| \d{2}$/, '')) : null);
                });
                //console.debug('lineChart:', values, xLabels);

                chart.setOption({
                    //calculable : true,
                    title: {
                        text: geo.names[geoId] + title + timeRange + "趋势",
                        x: 'center'
                    },
                    tooltip: {
                        trigger: 'axis'
                    },
                    xAxis: [
                        {
                            type: 'category',
                            boundaryGap: false,
                            data: xLabels
                        }
                    ],
                    yAxis: [
                        $.extend({
                            type: 'value',
                            axisLabel: {
                                formatter: '{value}' + unit
                            }
                        }, charts.calculateAxisRange(values, unit))
                    ],
                    series: [
                        {
                            name: title + "(" + unit + ")",
                            type: 'line',
                            data: values/*,
                            XmarkLine: {
                                itemStyle: {
                                    normal: {
                                        color: '#5cb85c'
                                    }
                                },
                                data: [
                                    {type: 'average', name: '平均值'}
                                ]
                            }*/
                        }
                    ]
                });
            } else {
                chart.clear();
            }
        }).error(function (code, msg, data) {
        }).complete(function (jqXHR, textStatus) {
            if (textStatus != 'abort') {
                jqXhrQueryByTime = null;
            }
        }).post(conf.AJAX.OVERVIEW_PM_QUERY_BY_TIME, $.extend({}, $.unparam(cond), {
            geoId: geoId
        }));
    }

    function getResourceIndicators(list, time) {
        var groups = [];
        if ($.isArray(list)) {
            $.each(list, function (i, groupObj) {
                var items = [];
                if (groupObj.classify && $.isArray(groupObj.data)) {
                    $.each(groupObj.data, function (j, itemObj) {
                        if (itemObj.name && itemObj.column) {
                            items.push({
                                title: itemObj.name,
                                value: itemObj.value,
                                cond: $.param({geoId: param.geoId, reqId: itemObj.column, time: time})
                            });
                        }
                    });
                    if (items.length > 0) {
                        groups.push({title: groupObj.classify, items: items})
                    }
                }
            });
        }
        return groups;
    }

    function getResourceMapData(list) {
        var data = [],
            min = 0,
            max = 4;
        if ($.isArray(list)) {
            $.each(list, function (i, item) {
                if (item.BUSINESSID) {
                    data.push({name: geo.names[item.BUSINESSID], value: item.VALUE, geoId: item.BUSINESSID})
                }
            });
        }
        if (data.length > 0) {
            $.each(data, function (i, obj) {
                min = Math.min(min, obj.value);
                max = Math.max(max, obj.value);
            });
            max = Math.ceil((max - min) / 4) * 4 + min;
            return {
                data: data,
                dataRange: charts.calculateDataRange(min, max, 4)
            };
        }
        return null;
    }

    function getCoverIndicators() {
        var items = [];
        items.push({title: '基站', cond: $.param({geoId: param.geoId, type: 'ENB'})});
        items.push({title: '小区', cond: $.param({geoId: param.geoId, type: 'CEL'})});
        items.push({title: 'RRU', cond: $.param({geoId: param.geoId, type: 'RRU'})});
        items.push({title: '天线', cond: $.param({geoId: param.geoId, type: 'ANT'})});
        items.push({title: '站址', cond: $.param({geoId: param.geoId, type: 'SIT'})});
        return [{title: '资源类型', items: items}];
    }

    function getCoverIndicators2(list) {
        var items = [];
        if (list && list[0] && $.isArray(list[0].data)) {
            $.each(list[0].data, function (j, itemObj) {
                if (itemObj.column) {
                    if (itemObj.column == 8104) {
                        items.push({
                            title: '基站',
                            value: itemObj.value,
                            cond: $.param({geoId: param.geoId, type: 'ENB'})
                        });
                    } else if (itemObj.column == 8105) {
                        items.push({
                            title: '小区',
                            value: itemObj.value,
                            cond: $.param({geoId: param.geoId, type: 'CEL'})
                        });
                    } else if (itemObj.column == 8111) {
                        items.push({
                            title: 'RRU',
                            value: itemObj.value,
                            cond: $.param({geoId: param.geoId, type: 'RRU'})
                        });
                    } else if (itemObj.column == 8112) {
                        items.push({
                            title: '天线',
                            value: itemObj.value,
                            cond: $.param({geoId: param.geoId, type: 'ANT'})
                        });
                    } else if (itemObj.column == 10007) {
                        items.push({
                            title: '站址',
                            value: itemObj.value,
                            cond: $.param({geoId: param.geoId, type: 'SIT'})
                        });
                    }
                }
            });
        }
        return [{title: '资源类型', items: items}];
    }

    function getCoverMapData(list, geoId) {
        var data = [],
            rate,
            centerX,
            centerY,
            n;
        if ($.isArray(list) && list.length > 3) {
            centerX = list[0];
            centerY = list[1];
            for (n = 3; n < list.length; n += 3) {
                data.push([(centerX + list[n]), (centerY + list[n + 1]), list[n + 2]]);
            }

            return {
                itemStyle: {
                    normal: {
                        color: 'transparent',
                        borderWidth: 1,
                        borderColor: 'rgba(0,0,0,0.2)',
                        label: {
                            show: true,
                            formatter: '{a}'
                        }
                    },
                    emphasis: {
                        color: 'rgba(255,255,255,0.5)',
                        borderWidth: 1,
                        borderColor: 'rgba(0,0,0,0.2)',
                        label: {show: true}
                    }
                },
                tooltip: {
                    show: false
                },
                heatmap: geo.isNation(geoId) ? {
                    blurSize: 5,
                    minAlpha: 0.02,
                    opacity: 0.8,
                    data: data
                } : {
                    blurSize: 5,
                    minAlpha: 0.05,
                    opacity: 0.75,
                    data: data
                }
            }
        }
        return null;
    }

    function isExtraChartVisible() {
        return $(SEL_CHART_EXTRA).is(':visible');
    }

    function refreshMapToolbox(show) {
        if (show === false || getMapLevel() >= 3) {
            $(SEL_MAP_TOOLBOX).addClass('hidden').empty();
        } else {
            $(SEL_MAP_TOOLBOX).html(tmpl('template-map-toolbox', {
                category: param.category,
                bar: param.category === 'performance' && isExtraChartVisible()
            })).removeClass('hidden');
        }
    }

    function toggleMapReturnBtn() {
        $(SEL_BTN_MAP_RETURN).toggleClass("hidden", geoHistories.length == 0).toggleClass("gis", getMapLevel() >= 3);
    }

    function getMapType(geoId) {
        geoId = geoId || 100000;
        if (geoId == 100000) {
            return 'china';
        }
        return geo.names[geoId];
    }

    function getMapLevel() {
        return conf.USER_ROLE_TYPE + geoHistories.length;
    }

    function getTime(category, callback) {
        var $time = null,
            time = null;
        if (category == 'performance') {
            $time = $('#inputTimePerformance');
            if ($time.valTrim().length === 0 && callback) {
                // Init time async.
                ajax.init().success(function (code, msg, data) {
                    $time.val(data);
                    callback(data);
                }).error(function (code, msg, data) {
                    if (code !== C.AJAX_CODE.LOGIN_REQUIRED) {
                        alerts.tip("获取默认时间失败！");
                    }
                    callback(null);
                    /*data = new Date().format('yyyy-mm-dd HH:00');
                     $time.val(data);
                     callback(data);*/
                }).complete(function (jqXHR, textStatus) {
                }).post(conf.AJAX.OVERVIEW_PM_GET_TIME, {});
                return time;
            }
        } else if (category == 'resource') {
            $time = $('#inputTimeResource');
            if ($time.valTrim().length === 0) {
                $time.val(new Date().format(dataFormat.masks.isoDate));
            }
        }
        if ($time != null) {
            time = $time.valTrim();
        }
        if (callback) {
            callback(time)
        }
        return time;
    }

    function getTimeForDialog(callback, getTimeDefault) {
        if (param.category == 'performance') {
            getTime(param.category, callback);
        } else {
            getTimeDefault(callback);
        }
    }

    function getSidebarSelector(category) {
        return '#jsSidebar' + $.toCamelCase(category);
    }

    function refreshGis() {
        var category = param.category,
            frame = $(SEL_MAP_GIS + ' iframe')[0];
        if (category != 'resource' && frame) {
            alerts.loading(true);
            callGis('showRefresh', [function () {
                alerts.loading(false);
            }]);
        }
    }

    function callGis(name, param) {
        console.debug('callGis:', name, param);
        var frame = $(SEL_MAP_GIS + ' iframe')[0];
        if (frame && frame.contentWindow[name]) {
            return frame.contentWindow[name].apply(null, param);
        }
        return null;
    }

    return {
        initPage: function () {
            // Init map.
            if (!conf.USER_GEO_ID || !initMap()) {
                return;
            }

            // Cover tab is not allowed for prefecture user.
            if (conf.USER_ROLE_TYPE == 3) {
                $(SEL_SIDEBAR_TABS + ' li a[data-category="cover"]').closest("li").remove();
            }

            var currentTab;

            console.debug('Init map level:', getMapLevel());
            initEvents();

            currentTab = (location.hash || "").replace(/^#+/, "");
            console.log("Current Tab:", currentTab);

            // Init Current tab when load
            if (currentTab.length > 0 && $(SEL_SIDEBAR_TABS + ' li a[data-category="' + currentTab + '"]').length > 0) {
                $(SEL_SIDEBAR_TABS + ' li a[data-category="' + currentTab + '"]').trigger("click", {firstLoad: true});
            } else {
                $(SEL_SIDEBAR_TABS + ' li:eq(0) a').trigger('click', {firstLoad: true});
            }
        }
    }
});
