define([
    'core/const',
    'core/conf',
    'core/ajax',
    'ui/alerts',
    'util/charts',
    'util/date-format',
    'tmpl',
    'jquery',
    'core/utils',
    'echarts',
    'echarts/chart/line',
    'bootstrap-dialog'
], function () {

    var C = require('core/const'),
        conf = require('core/conf'),
        ajax = require('core/ajax'),
        geo = require('util/geo'),
        alerts = require('ui/alerts'),
        charts = require('util/charts'),
        tmpl = require('tmpl'),
        BootstrapDialog = require('bootstrap-dialog'),
        $ = require('jquery'),
        echarts = require('echarts'),
        TPL_NE_SOURCE = 'templateNemSource',
        TPL_NEM_FORM_NE_LIST = 'templateNemFormNeList',
        TPL_DIALOG_TABLE = 'templateGisDialogTable',
        TPL_DIALOG_RESOURCE = 'templateGisDialog',
        SEL_MAP_GIS = '#jsGisMap',
        dialog,
        filterKey = '',
        pageNo = 1,
        alarmPageNo = 1,
        alarmPageNum = 11,
        itemNum = 5,
        getToPoint = false,
        startTime = "",
        endTime = "",
        newPageno = null;

    function getTimeDefault(callback) {
        ajax.init().success(function (code, msg, data) {
            callback(data);
        }).error(function (code, msg, data) {
            if (code !== C.AJAX_CODE.LOGIN_REQUIRED) {
                alerts.tip(msg || C.MESSAGE.UNKNOWN_ERROR);
            }
            callback(null);
        }).complete(function (jqXHR, textStatus) {
        }).post(conf.AJAX.OVERVIEW_PM_GET_TIME);
    }

    //获取告警信息
    function getAlarmInformation(intid, startTime, endTime) {
        alerts.loading(true);
        var intId;
        if (!intid) {
            var choose = $("#indGroupperform .list-group-item.active");
            if (choose.length < 1) {
                choose = $("#indGroupalarm .list-group-item.active");
            }
            intId = choose.attr("data-intid");
        } else {
            intId = intid;
        }
        ajax.init().success(function (code, msg, data) {
            if (code == C.AJAX_CODE.OK && data && data.length > 0) {
                alarmPageNum = data.length;
                $("#alarmInfo").html(tmpl(TPL_DIALOG_TABLE, {tables: data, flag: 0}));
            } else {
                data = [["级别", "厂家告警号", "标题", "发生时间"]];
                $("#alarmInfo").html(tmpl(TPL_DIALOG_TABLE, {tables: data, flag: 1}));
            }
            alerts.loading(false);
        }).error(function (code, msg, data) {
            if (code !== C.AJAX_CODE.LOGIN_REQUIRED) {
                alerts.tip(msg || C.MESSAGE.UNKNOWN_ERROR);
            }
            data = [["级别", "厂家告警号", "标题", "发生时间"]];
            $("#alarmInfo").html(tmpl(TPL_DIALOG_TABLE, {tables: data, flag: 1}));
            alerts.loading(false);
        }).complete(function (jqXHR, textStatus) {
        }).post(conf.AJAX.SCENE_ALARM_DETAIL, {
            start: alarmPageNo,
            length: 11,
            int_id: intId,
            startTime: startTime,
            endTime: endTime
        });
    }

    //获取场景性能图表
    function getScenePerformanceChart(kpiList, intId, neType, getList, getTime) {
        getTime = getTime || getTimeDefault;
        $("#trendAnalysis").replaceWith("");
        var htmlstr = '';
        htmlstr += '<div id="trendAnalysis">';
        htmlstr += '    <div class="kpi-choose"><span style=\"font-weight: bold;\">指标：</span><div id="mulPerform"></div><span id="chooseMulPer" style="color: rgb(0,157,217);cursor: pointer;"><i class="fa fa-caret-down fa-lg"></i></span></div>';
        htmlstr += '    <div id="divChart" style=\"height:252px;width: 395px;text-align: center;\">请选择指标！</div>';
        htmlstr += '    <div class="mul-perform"></div>';
        htmlstr += '</div>';
        $("#performInfo").append(htmlstr);
        if (getList) {
            getList(function (data) {
                if (!intId && !neType) {
                    var ch = $("#indGroupperform .list-group-item.active");
                    if (ch.length < 1) {
                        ch = $("#indGroupalarm  .list-group-item.active");
                    }
                    neType = ch.attr("data-netype");
                    intId = ch.attr("data-intid");
                }
                $("#trendAnalysis").on("click", "#chooseMulPer", function () {
                    getTime(function (time) {
                        if (!time) {
                            return;
                        }
                        if (!kpiList) {
                            var kpis = [
                                {
                                    "kpitypename": "呼叫接入类",
                                    "list": [
                                        {
                                            "id": "Radio_SuccConn_Rate",
                                            "time": time,
                                            "title": "无线连接成功率",
                                            "value": "%"
                                        },
                                        {
                                            "id": "Paging_Cong_Rate",
                                            "time": time,
                                            "title": "寻呼拥塞率",
                                            "value": "%"
                                        }
                                    ]
                                },
                                {
                                    "kpitypename": "资源负荷类",
                                    "list": [
                                        {
                                            "id": "PuschPrbTotMeanDl_Rate",
                                            "time": time,
                                            "title": "下行PRB平均占用率",
                                            "value": "%"
                                        },
                                        {
                                            "id": "PDCCH_CCE_Occupied_Rate",
                                            "time": time,
                                            "title": "PDCCH信道占用率",
                                            "value": "%"
                                        },
                                        {
                                            "id": "RRC_UserConnMean",
                                            "time": time,
                                            "title": "平均RRC连接用户数",
                                            "value": "个"
                                        }
                                    ],
                                    "kpitypeid": "-1"
                                },
                                {
                                    "kpitypename": "业务完整类",
                                    "list": [
                                        {
                                            "id": "PDCP_SduMeanDelayDl",
                                            "time": time,
                                            "title": "用户面下行平均时延",
                                            "value": "毫秒/包"
                                        }
                                    ],
                                    "kpitypeid": "-1"
                                },
                                {
                                    "kpitypename": "呼叫保持类",
                                    "list": [
                                        {
                                            "id": "ERAB_Drop_Rate",
                                            "time": time,
                                            "title": "E-RAB掉线率",
                                            "value": "%"
                                        }
                                    ],
                                    "kpitypeid": "-1"
                                },
                                {
                                    "kpitypename": "移动管理类",
                                    "list": [
                                        {
                                            "id": "HO_SuccOutIntraMode_Rate",
                                            "time": time,
                                            "title": "系统内切换成功率",
                                            "value": "%"
                                        }
                                    ],
                                    "kpitypeid": "-1"
                                }
                            ];
                            performMultiselect(kpis, data.kpi, intId, neType, time);
                        } else {
                            performMultiselect(kpiList, data.kpi, intId, neType, time);
                        }
                    }, getTimeDefault);
                });
                if (data.kpi && kpiList) {
                    getTime(function (time) {
                        performMultiselect(kpiList, data.kpi, intId, neType, time);
                    }, getTimeDefault);
                } else {
                    getTime(function (time) {
                        if (!time) {
                            return;
                        }
                        var kpis = [
                            {
                                "kpitypename": "呼叫接入类",
                                "list": [
                                    {
                                        "id": "Radio_SuccConn_Rate",
                                        "time": time,
                                        "title": "无线连接成功率",
                                        "value": "%"
                                    },
                                    {
                                        "id": "Paging_Cong_Rate",
                                        "time": time,
                                        "title": "寻呼拥塞率",
                                        "value": "%"
                                    }
                                ]
                            },
                            {
                                "kpitypename": "资源负荷类",
                                "list": [
                                    {
                                        "id": "PuschPrbTotMeanDl_Rate",
                                        "time": time,
                                        "title": "下行PRB平均占用率",
                                        "value": "%"
                                    },
                                    {
                                        "id": "PDCCH_CCE_Occupied_Rate",
                                        "time": time,
                                        "title": "PDCCH信道占用率",
                                        "value": "%"
                                    },
                                    {
                                        "id": "RRC_UserConnMean",
                                        "time": time,
                                        "title": "平均RRC连接用户数",
                                        "value": "个"
                                    }
                                ],
                                "kpitypeid": "-1"
                            },
                            {
                                "kpitypename": "业务完整类",
                                "list": [
                                    {
                                        "id": "PDCP_SduMeanDelayDl",
                                        "time": time,
                                        "title": "用户面下行平均时延",
                                        "value": "毫秒/包"
                                    }
                                ],
                                "kpitypeid": "-1"
                            },
                            {
                                "kpitypename": "呼叫保持类",
                                "list": [
                                    {
                                        "id": "ERAB_Drop_Rate",
                                        "time": time,
                                        "title": "E-RAB掉线率",
                                        "value": "%"
                                    }
                                ],
                                "kpitypeid": "-1"
                            },
                            {
                                "kpitypename": "移动管理类",
                                "list": [
                                    {
                                        "id": "HO_SuccOutIntraMode_Rate",
                                        "time": time,
                                        "title": "系统内切换成功率",
                                        "value": "%"
                                    }
                                ],
                                "kpitypeid": "-1"
                            }
                        ];
                        performMultiselect(kpis, null, intId, neType, time);
                    }, getTimeDefault);
                }
            });
        } else {
            if (!intId && !neType) {
                var ch = $("#indGroupperform .list-group-item.active");
                if (ch.length < 1) {
                    ch = $("#indGroupalarm  .list-group-item.active");
                }
                neType = ch.attr("data-netype");
                intId = ch.attr("data-intid");
            }
            getTime(function (time) {
                if (!time) {
                    return;
                }
                var kpis = [
                    {
                        "kpitypename": "呼叫接入类",
                        "list": [
                            {
                                "id": "Radio_SuccConn_Rate",
                                "time": time,
                                "title": "无线连接成功率",
                                "value": "%"
                            },
                            {
                                "id": "Paging_Cong_Rate",
                                "time": time,
                                "title": "寻呼拥塞率",
                                "value": "%"
                            }
                        ]
                    },
                    {
                        "kpitypename": "资源负荷类",
                        "list": [
                            {
                                "id": "PuschPrbTotMeanDl_Rate",
                                "time": time,
                                "title": "下行PRB平均占用率",
                                "value": "%"
                            },
                            {
                                "id": "PDCCH_CCE_Occupied_Rate",
                                "time": time,
                                "title": "PDCCH信道占用率",
                                "value": "%"
                            },
                            {
                                "id": "RRC_UserConnMean",
                                "time": time,
                                "title": "平均RRC连接用户数",
                                "value": "个"
                            }
                        ],
                        "kpitypeid": "-1"
                    },
                    {
                        "kpitypename": "业务完整类",
                        "list": [
                            {
                                "id": "PDCP_SduMeanDelayDl",
                                "time": time,
                                "title": "用户面下行平均时延",
                                "value": "毫秒/包"
                            }
                        ],
                        "kpitypeid": "-1"
                    },
                    {
                        "kpitypename": "呼叫保持类",
                        "list": [
                            {
                                "id": "ERAB_Drop_Rate",
                                "time": time,
                                "title": "E-RAB掉线率",
                                "value": "%"
                            }
                        ],
                        "kpitypeid": "-1"
                    },
                    {
                        "kpitypename": "移动管理类",
                        "list": [
                            {
                                "id": "HO_SuccOutIntraMode_Rate",
                                "time": time,
                                "title": "系统内切换成功率",
                                "value": "%"
                            }
                        ],
                        "kpitypeid": "-1"
                    }
                ];
                performMultiselect(kpis, null, intId, neType, time);
            }, getTimeDefault);
            $("#trendAnalysis").on("click", "#chooseMulPer", function () {
                getTime(function (time) {
                    if (!time) {
                        return;
                    }
                    var kpis = [
                        {
                            "kpitypename": "呼叫接入类",
                            "list": [
                                {
                                    "id": "Radio_SuccConn_Rate",
                                    "time": time,
                                    "title": "无线连接成功率",
                                    "value": "%"
                                },
                                {
                                    "id": "Paging_Cong_Rate",
                                    "time": time,
                                    "title": "寻呼拥塞率",
                                    "value": "%"
                                }
                            ]
                        },
                        {
                            "kpitypename": "资源负荷类",
                            "list": [
                                {
                                    "id": "PuschPrbTotMeanDl_Rate",
                                    "time": time,
                                    "title": "下行PRB平均占用率",
                                    "value": "%"
                                },
                                {
                                    "id": "PDCCH_CCE_Occupied_Rate",
                                    "time": time,
                                    "title": "PDCCH信道占用率",
                                    "value": "%"
                                },
                                {
                                    "id": "RRC_UserConnMean",
                                    "time": time,
                                    "title": "平均RRC连接用户数",
                                    "value": "个"
                                }
                            ],
                            "kpitypeid": "-1"
                        },
                        {
                            "kpitypename": "业务完整类",
                            "list": [
                                {
                                    "id": "PDCP_SduMeanDelayDl",
                                    "time": time,
                                    "title": "用户面下行平均时延",
                                    "value": "毫秒/包"
                                }
                            ],
                            "kpitypeid": "-1"
                        },
                        {
                            "kpitypename": "呼叫保持类",
                            "list": [
                                {
                                    "id": "ERAB_Drop_Rate",
                                    "time": time,
                                    "title": "E-RAB掉线率",
                                    "value": "%"
                                }
                            ],
                            "kpitypeid": "-1"
                        },
                        {
                            "kpitypename": "移动管理类",
                            "list": [
                                {
                                    "id": "HO_SuccOutIntraMode_Rate",
                                    "time": time,
                                    "title": "系统内切换成功率",
                                    "value": "%"
                                }
                            ],
                            "kpitypeid": "-1"
                        }
                    ];
                    performMultiselect(kpis, null, intId, neType, time);
                }, getTimeDefault);
            });
        }

        $("#trendAnalysis").on("mousedown", ".mul-perform", function (e) {
            $(this).css("cursor", "move");
            var position = $(this).position();
            var x = e.pageX;
            var y = e.pageY;
            $("#trendAnalysis").on("mousemove", ".mul-perform", function (ev) {
                var _x = position.left + (ev.pageX - x);
                var _y = position.top + (ev.pageY - y);
                $(".mul-perform").animate({left: _x + "px", top: _y + "px"}, 0);
            });
        });
        $("#trendAnalysis").on("mouseup", ".mul-perform", function (e) {
            $(this).css("cursor", "default");
            $("#trendAnalysis").off("mousemove", ".mul-perform");
        });
    }

    //性能多选
    function performMultiselect(kpis, kpi, intId, neType, time) {
        var datas;
        if (kpis && kpis.length > 0) {
            datas = kpis;
        } else {
            datas = "";
        }
        var htmlstr = "";
        if ($(".mul-perform>div").length == 0) {
            htmlstr += '<div class=\"perform-multiselect\">';
            htmlstr += '<div class=\"multiselect-close\" style="cursor: pointer;"><i class="fa fa-times"></i></div>';
            $.each(datas, function (i, data) {
                htmlstr += '    <div class=\"mulcheckboxs-lines\">';
                htmlstr += '        <div class=\"mulcheckboxs-lines-name\">' + data.kpitypename + '</div>';
                if (data.list) {
                    $.each(data.list, function (i, list) {
                        htmlstr += '<div class=\"mulcheckboxs\">';
                        var units = list.value;
                        var unit = units.split(/[\d+\.?\d]/);
                        if (kpi == null) {
                            if (list.id == "Radio_SuccConn_Rate" || list.id == "ERAB_Drop_Rate") {
                                htmlstr += '<input type=\"checkbox\" data-id=\"' + list.id + '\" data-time="' + time + '" data-unit="' + unit[unit.length - 1] + '" data-title=\"' + list.title + '\" checked=\"true\"/>';
                            } else {
                                htmlstr += '<input type=\"checkbox\" data-id=\"' + list.id + '\" data-time="' + time + '" data-unit="' + unit[unit.length - 1] + '" data-title=\"' + list.title + '\"/>';
                            }
                        } else if (list.id == kpi) {
                            htmlstr += '<input type=\"checkbox\" data-id=\"' + list.id + '\" data-time="' + time + '" data-unit="' + unit[unit.length - 1] + '" data-title=\"' + list.title + '\" checked=\"true\"/>';
                        } else {
                            htmlstr += '<input type=\"checkbox\" data-id=\"' + list.id + '\" data-time="' + time + '" data-unit="' + unit[unit.length - 1] + '" data-title=\"' + list.title + '\"/>';
                        }
                        htmlstr += '    <span title=\"' + list.title + '\">' + list.title + '</span>';
                        htmlstr += '</div>';
                    });
                }
                htmlstr += '   </div>';
            });
            htmlstr += '<div style="float: right;margin: 0 10px 10px 0;">（可同时选择2项）</div>';
            htmlstr += '</div>';
            $(".mul-perform").append(htmlstr);
            var choosed = $(".mulcheckboxs>input:checked");
            if (choosed.length > 0) {
                htmlstr = "";
                $.each(choosed, function (i, choose) {
                    var kpi = $(choose).data();
                    htmlstr += '<div data-id=\"' + kpi.id + '\" data-time=\"' + time + '\" data-unit=\"' + kpi.unit + '\" data-title=\"' + kpi.title + '\"> ' + kpi.title + ' </div>';
                });
                $("#mulPerform").append(htmlstr);
                drawChart(intId, neType);
            } else {
                $(".mul-perform").show();
            }
        } else {
            $(".mul-perform").show();
        }
        $(".perform-multiselect").off("click", ".multiselect-close").off("change", ".mulcheckboxs>input");
        $(".perform-multiselect").on("click", ".multiselect-close", function () {
            $(".mul-perform").hide();
        }).on("change", ".mulcheckboxs>input", function () {
            var choosed = $(".mulcheckboxs>input:checked");
            if (choosed.length > 2) {
                alert("最多选中两项！");
                $(this).attr("checked", false);
                return;
            }
            $("#mulPerform").empty();
            var checkeds = [];
            for (var i = 0; i < choosed.length; i++)
                checkeds.push($($(choosed)[i]).data());
            var htmlstr = "";
            if (checkeds) {
                $.each(checkeds, function (i, kpi) {
                    htmlstr += '<div data-id=\"' + kpi.id + '\" data-time=\"' + time + '\" data-unit=\"' + kpi.unit + '\" data-title=\"' + kpi.title + '\"> ' + kpi.title + ' </div>';
                });
                $("#mulPerform").append(htmlstr);
            }
            drawChart(intId, neType);
        });
    }

    //绘制图表
    function drawChart(intId, neType) {
        var draws = [];
        $("#divChart").empty();
        if ($("#mulPerform>div").length > 0) {
            for (var i = 0; i < $("#mulPerform>div").length; i++) {
                draws.push($($("#mulPerform>div")[i]).data());
            }
        } else {
            $("#divChart").append("请选择指标！");
        }
        if (draws && draws.length > 0) {
            var time = draws[0].time;
            var myChart = echarts.init(document.getElementById('divChart'));
            var provinceId = $(".neSourceCond>.provinceID").html() == "-" ? "" : $(".neSourceCond>.provinceID").html();
            if (draws.length == 1) {
                getChartData(draws, draws[0].id, intId, neType, time, provinceId, function (data, draws) {
                    chartData(myChart, data, draws, time);
                });
            } else if (draws.length == 2) {
                getChartData(draws, draws[0].id, intId, neType, time, provinceId, function (data, draws) {
                    chartData(myChart, data, draws, time);
                    getChartData(draws, draws[1].id, intId, neType, time, provinceId, function (data, draws) {
                        chartData(myChart, data, draws, time, 2);
                    });
                });
            }
        }
    }

    //获取图表数据
    function getChartData(draws, kpiid, intId, neType, time, provinceId, callback) {
        ajax.init().success(function (code, msg, data) {
            if (code == C.AJAX_CODE.OK) {
                callback(data, draws);
            }
        }).error(function (code, msg, data) {
            if (code !== C.AJAX_CODE.LOGIN_REQUIRED) {
                alerts.tip(msg || C.MESSAGE.UNKNOWN_ERROR);
            }
            callback(null, draws);
        }).complete(function (jqXHR, textStatus) {
        }).post(conf.AJAX.SCENE_PM_CHART, {
            startTime: time,
            kpiId: kpiid,
            intId: intId,
            neType: neType,
            provinceId: provinceId
        });
    }

    //图表数据处理
    function chartData(myChart, data, draws, time, times) {
        var maxmindata = [];
        var dataObj = new Array(24),
            Time = [],
            option = "",
            unit;
        time = time.substr(11, 2);
        time++;
        for (var i = 0; i < 24; i++) {
            if (time + 1 == 25) {
                Time.push("0" + 0);
                time = 1;
            } else {
                if (time < 10) {
                    Time.push("0" + time++);
                } else {
                    Time.push((time++).toString());
                }
            }
        }
        if (times == 2) {
            unit = draws[1].unit;
        } else {
            unit = draws[0].unit
        }
        if (data.currentData && data.currentData.length > 0) {
            $.each(data.currentData, function (i, chart) {
                var hour = $.inArray(chart.hour, Time);
                if (unit == "%") {
                    dataObj[hour] = (chart.value * 100).toFixed(2);
                    maxmindata.push((chart.value * 100).toFixed(2));
                } else {
                    dataObj[hour] = chart.value;
                    maxmindata.push(chart.value * 100);
                }
            });
        } else if (data.currentData && data.currentData.length == 0) {
            dataObj = [];
        }
        if (draws.length == 1) {
            option = initChartOption([dataObj, []], maxmindata, [draws[0].title, null], [draws[0].unit,], Time, 1);
        } else if (draws.length > 1) {
            option = initChartOption([dataObj, []], maxmindata, [draws[0].title, draws[1].title], [draws[0].unit, draws[1].unit], Time, 2);
        }
        if (times == 2) {
            var secondData;
            var secondOption = myChart.getOption();
            secondOption.yAxis[1] = $.extend({
                type: 'value',
                axisLabel: {
                    formatter: '{value}' + draws[1].unit
                }
            }, charts.calculateAxisRange(maxmindata, draws[1].unit));
            myChart.setOption(secondOption);
            secondData = myChart.getSeries();
            if (secondData) {
                secondData[1].data = dataObj;
                myChart.setSeries(secondData);
            }
        } else {
            myChart.setOption(option);
        }

    }

    //初始化图表选项
    function initChartOption(Datas, MaxMinDatas, Titles, Units, Times, No) {
        var option = {
            tooltip: {
                trigger: 'axis',
                formatter: function (params, ticket, callback) {
                    var res = params[0].name + "时";
                    for (var i = 0, l = params.length; i < l; i++) {
                        res += '<br/>' + params[i].seriesName + ' : <br/>' + params[i].value + Units[i];
                    }
                    return res;
                }
            },
            xAxis: [
                {
                    type: 'category',
                    boundaryGap: false,
                    data: Times
                }
            ],
            yAxis: [
                $.extend({
                    type: 'value',
                    axisLabel: {
                        formatter: '{value}' + Units[0]
                    }
                }, charts.calculateAxisRange(MaxMinDatas, Units[0])),
            ],
            grid: {
                x: 70,
                y: 20,
                x2: 65,
                y2: 20
            },
            series: [
                {
                    name: Titles[0],
                    type: 'line',
                    data: Datas[0]
                }
            ]
        };
        if (No == 1) {
            option.legend = {
                data: [Titles[0]]
            };
        } else {
            option.legend = {
                data: [Titles[0], Titles[1]]
            };
            option.yAxis[1] =
                $.extend({
                    type: 'value',
                    axisLabel: {
                        formatter: '{value}' + Units[1]
                    }
                }, charts.calculateAxisRange(MaxMinDatas, Units[1]));
            option.series.push({
                name: Titles[1],
                type: 'line',
                yAxisIndex: 1,
                data: Datas[1]
            });
        }
        return option;
    }

    //上一步
    function previous(url, param, page) {
        var currentpage;
        currentpage = pageNo - 1;
        if (currentpage == 0) {
            alert("已经是第一页！");
            $(".fa-arrow-circle-left").attr("disabled", true);
            return false;
        }
        pageNo -= 1;
        getNeList(url, param, page);
    }

    //下一步
    function next(url, param, page) {
        if (itemNum < 5) {
            alert("已经是最后一页！");
            $(".fa-arrow-circle-right").attr("disabled", true);
            return false;
        }
        pageNo += 1;
        getNeList(url, param, page);
    }

    function getNeListBySearch(url, param) {
        filterKey = $('#searchCondition').val();
        console.log("searchCondition", filterKey);
        var searchNum = 0;
        param.filterKey = filterKey;
        param.page = 1;
        ajax.init().success(function (code, msg, data) {
            var htmlstr = tmpl(TPL_NEM_FORM_NE_LIST, data);
            searchNum = data.items.length;//为空表示翻页，不为空表示模糊查询
            if (searchNum == 0) {
                alert("无相关网元！");
            }
            else {
                //console.log("itemNum:", itemNum);
                if (htmlstr) {
                    $('.modal-content .list-group').empty();
                    $('.modal-content .list-group').append(htmlstr);
                    $('.modal-content .list-group').find('button.active').trigger('click');
                }
            }
        }).error(function (code, msg, data) {
            if (code !== C.AJAX_CODE.LOGIN_REQUIRED) {
                //  alerts.tip(msg || C.MESSAGE.UNKNOWN_ERROR);
            }
            //fnUnlock();
        }).complete(function (jqXHR, textStatus) {

        }).post(url, param);
    }

    //查询
    function getNeList(url, param, page) {
        filterKey = $('#searchCondition').val();
        console.log("searchCondition", filterKey);
        itemNum = 0;
        param.filterKey = filterKey;
        param.page = page;
        ajax.init().success(function (code, msg, data) {
            var htmlstr = tmpl(TPL_NEM_FORM_NE_LIST, data);
            itemNum = data.items.length;//为空表示翻页，不为空表示模糊查询
            newPageno = data.page;
            if (itemNum == 0) {
                alert("已经是最后一页！");
                $(".fa-arrow-circle-right").attr("disabled", true);
            }
            else {
                //console.log("itemNum:", itemNum);
                if (htmlstr) {
                    $('.modal-content .list-group').empty();
                    $('.modal-content .list-group').append(htmlstr);
                    if (getToPoint) {
                        $('.modal-content .list-group').find('button.active').trigger('click');
                    }
                }
            }
        }).error(function (code, msg, data) {
            if (code !== C.AJAX_CODE.LOGIN_REQUIRED) {
                //  alerts.tip(msg || C.MESSAGE.UNKNOWN_ERROR);
            }
            //fnUnlock();
        }).complete(function (jqXHR, textStatus) {

        }).post(url, param);
    }

    //获取网元资源信息
    function getNeResource(intId, neType, callback) {
        ajax.init().success(function (code, msg, data) {
            var htmlstr = "";
            htmlstr += tmpl(TPL_DIALOG_RESOURCE, {data: data});
            callback(htmlstr);
        }).error(function (code, msg, data) {
            if (code !== C.AJAX_CODE.LOGIN_REQUIRED) {
                alerts.tip(msg || C.MESSAGE.UNKNOWN_ERROR);
            }
            callback(null);
        }).complete(function (jqXHR, textStatus) {
        }).post(conf.AJAX.GIS_DIALOG_LIST, {int_id: intId, neType: neType});
    }

    function callGis(name, param) {
        console.debug('callGis:', name, param);
        var frame = $(SEL_MAP_GIS + ' iframe')[0];
        if (frame && frame.contentWindow[name]) {
            return frame.contentWindow[name].apply(null, param);
        }
        return null;
    }

    function exportAlarmTable(intId, startTime, endTime) {
        if (!intId) {
            var ch = $("#indGroupperform .list-group-item.active");
            if (ch.length < 1) {
                ch = $("#indGroupalarm .list-group-item.active");
            }
            intId = ch.attr("data-intid");
        }
        var param = {};
        param.intId = intId;
        var form = $("<form>");
        form.attr('style', 'display:none');
        form.attr('target', '_blank');
        form.attr('method', 'post');
        form.attr('action', conf.AJAX.GIS_DIALOG_TABLE_EXPORT);
        form.attr("accept-charset", "utf-8");
        if (param.intId != '') {
            var input1 = $('<input>');
            input1.attr('name', 'int_id');
            input1.attr('value', param.intId);
            form.append(input1);
        }
        if (startTime != '') {
            var input2 = $('<input>');
            input1.attr('name', 'startTime');
            input1.attr('value', startTime);
            form.append(input2);
        }
        if (endTime != '') {
            var input3 = $('<input>');
            input1.attr('name', 'endTime');
            input1.attr('value', endTime);
            form.append(input3);
        }
        $('body').append(form);
        form.submit();
        form.remove();
    }


    return {
        /**
         * Gis网元详情面板。
         * @param intId 网元唯一标识。
         * @param neType 网元类型。
         * @param kpiList 性能指标列表
         * @param getTime 获取时间
         * @param getList 获取需要参数
         **/
        showContextDialog: function (intId, neType, kpiList, getTime, getList) {
            if (!getList && !intId && !neType) {
                return;
            }
            pageNo = 1;
            if (dialog) {
                dialog.close();
            }
            dialog = new BootstrapDialog({
                title: "网元信息面板",
                message: "",
                closeByBackdrop: false,
                draggable: true,
                cssClass: "neInfo-dialog",
                onshown: function (dialogRef) {
                    dialogRef.getModal().prev('.modal-backdrop').addClass('hidden');
                },
                onhidden: function () {
                    $('#jsBtnSidebarCollapse').trigger('click');
                }
            });
            alerts.loading(true);
            dialog.realize();
            if (intId && neType) {
                getNeResource(intId, neType, function (htmlstr) {
                    dialog.setMessage($(htmlstr));
                    //dialog.open();
                });
            }
            getList && getList(function (data) {
                if (data.title) {
                    dialog.setTitle(data.title);
                }
                if (data.data) {
                    dialog.setMessage($(data.data));
                }
                if (data.url && data.params) {
                    dialog.getModalBody().on('click', '.submit.butt', function () {
                        getNeListBySearch(data.url, data.params);
                        $('#searchCondition').val("");
                    }).on('click', '.fa-arrow-circle-left', function () {
                        var dataPage = null;
                        if (newPageno == null) {
                            dataPage = data.page;
                        } else {
                            dataPage = newPageno;
                        }
                        previous(data.url, data.params, dataPage);
                    }).on('click', '.fa-arrow-circle-right', function () {
                        var dataPage = null;
                        if (newPageno == null) {
                            dataPage = data.page;
                        } else {
                            dataPage = newPageno;
                        }
                        next(data.url, data.params, dataPage);
                    })
                }
            });
            dialog.getModalBody().on('click', '.list-group-item', function () {
                if (!$(this).hasClass('active')) {
                    $("#performInfo").empty();
                    $("#alarmInfo").empty();
                }
                $(this).closest('.list-group').find('.list-group-item.active').removeClass('active');
                $(this).addClass('active');
                var data = $(this).data();
                var html = tmpl(TPL_NE_SOURCE, data);
                $('#sourceInfo').html(html);
                if ($(".neInformation>.nav.nav-tabs>li.active").attr("class") == "perform_tab active") {
                    getScenePerformanceChart(kpiList, intId, neType, getList, getTime);
                } else if ($(".neInformation>.nav.nav-tabs>li.active").attr("class") == "alarm_tab active") {
                    alarmPageNo = 1;
                    getAlarmInformation(intId, startTime, endTime);
                }
                var intIdNe = $(this).data().intid,
                    neTypeNe = $(this).data().netype;
                ajax.init().success(function (code, msg, data) {
                    if (code == C.AJAX_CODE.OK && data && data.x && data.y) {
                        callGis('centerAndZoom', [data.x, data.y, 15]);
                        getToPoint = true;
                    }
                    else {
                        getToPoint = false;
                        console.warn("此网元没有具体坐标，无法对其进行定位！");
                        alert("此网元没有具体坐标，无法对其进行定位！");
                    }
                }).error(function (code, msg, data) {
                    if (code !== C.AJAX_CODE.LOGIN_REQUIRED) {
                        alerts.tip(msg || C.MESSAGE.UNKNOWN_ERROR);
                    }
                }).complete(function (jqXHR, textStatus) {
                }).post(conf.AJAX.CM_COMMON_POSITION, {type: neTypeNe, intId: intIdNe});
            }).on('click', '.source_tab', function () {
                $(".js-operate-button").hide();
            }).on('click', '.perform_tab', function () {
                $(".js-operate-button").hide();
                if ($("#performInfo>div").length == 0) {
                    getScenePerformanceChart(kpiList, intId, neType, getList, getTime);
                }
            }).on('click', '.alarm_tab', function () {
                $(".js-operate-button").show();
                if ($("#alarmInfo>div").length == 0 || $("#alarmInfo>div>table>tbody>tr>td>span").text() == "查询失败，请重试！") {
                    alarmPageNo = 1;
                    getAlarmInformation(intId, startTime, endTime);
                }
            }).on('click', '.previousBut', function () {
                alarmPageNo -= 1;
                if (alarmPageNo < 1) {
                    alert("已经是第一页！");
                    alarmPageNo += 1;
                    return;
                }
                getAlarmInformation(intId, startTime, endTime);
            }).on('click', '.nextBut', function () {
                alarmPageNo += 1;
                if (alarmPageNum < 11) {
                    alert("已经是最后一页！");
                    alarmPageNo -= 1;
                    return;
                }
                getAlarmInformation(intId, startTime, endTime);
            }).on('click', ".js-table-export", function () {
                exportAlarmTable(intId, startTime, endTime);
            }).on('click', ".js-table-clock", function () {
                $(".js-alarm-times").show();
                var end = new Date();
                $("#alarmEndTime").val(end.format("yyyy-mm-dd HH:mm"));
                end.setDate(end.getDate() - 3);
                $("#alarmStartTime").val(end.format("yyyy-mm-dd HH:mm"));
                $("#alarmStartTime").datetimepicker({format: 'YYYY-MM-DD HH:mm'});
                $("#alarmEndTime").datetimepicker({format: 'YYYY-MM-DD HH:mm'});
            }).on('click', ".js-alarm-times-confirm", function () {
                startTime = $("#alarmStartTime").val();
                endTime = $("#alarmEndTime").val();
                if (!startTime || !endTime) {
                    alert("请选择时间！");
                    return;
                }
                getAlarmInformation(intId, startTime, endTime);
                $(".js-alarm-times").hide();
            }).on('click', ".js-alarm-times-close", function () {
                $(".js-alarm-times").hide();
                $("#alarmStartTime").val("");
                $("#alarmEndTime").val("");
            });
            alerts.loading(false);
            dialog.open();
        }
    };
});
