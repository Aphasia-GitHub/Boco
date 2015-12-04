/**
 * Created by Pengxuan Men on 2015-08-03.
 */
define([
    'core/const',
    'core/conf',
    'core/ajax',
    'util/geo',
    'jquery',
    'echarts',
    'echarts/config',
    'echarts/chart/map'
], function () {
    'use strict';

    console.info("Loaded modules:", arguments);

    var C = require('core/const'),
        conf = require('core/conf'),
        ajax = require('core/ajax'),
        geo = require('util/geo'),
        echarts = require('echarts'),
        echartsConfig = require('echarts/config'),
        $ = require('jquery'),
        EVENT = {
            SHOW_LOADING: "showLoading",
            HIDE_LOADING: "hideLoading",
            IN_PROVENCE: "inProvence",
            IN_REGION: "inRegion"
        },
        EVENT_NAMES = [];

    $.each(EVENT, function (k, v) {
        EVENT_NAMES.push(v);
    });

    function EChartsMap(id, option, events) {
        var self = this,
            mapChart = null,
            defaultOption = option,
            mapTypeHistory = [],
            lastMapType = null,
            isLoading = false,
            eventListeners = {},
            $container = null;

        init(id, option, events);

        function init(id, option, events) {
            $container = $(id);
            if (mapChart == null && $container.length === 1) {
                mapChart = echarts.init($container[0]);
            } else {
                $container = null;
            }
            if (mapChart == null) {
                console.error("Fail to init ECharts map.");
                return;
            }
            mapChart.setOption(option);
            // 选取下钻
            mapChart.on(echartsConfig.EVENT.MAP_SELECTED, function (param) {
                if (!param.target || param.target == lastMapType) {
                    return;
                }
                if ($.inArray(param.target, C.PROVINCES) !== -1) {
                    // 下钻到省
                    mapTypeHistory.push(self.getCurrentMapType());
                    self.triggerEvent(EVENT.IN_PROVENCE, param);
                } else if (geo.codes[param.target]) {
                    // 下钻到地市
                    mapTypeHistory.push(self.getCurrentMapType());
                    self.triggerEvent(EVENT.IN_REGION, param);
                }
            });
            if ($.isPlainObject(events)) {
                $.each(events, function (i, eventName) {
                    self.on(eventName, events[eventName]);
                });
            }
            $(window).on("resize", function (e) {
                mapChart.resize();
            });
        }

        this.on = function (eventName, eventListener) {
            if ($.inArray(eventName, EVENT_NAMES) !== -1) {
                if ($.isFunction(eventListener)) {
                    eventListeners[eventName] = eventListener;
                }
            } else if (mapChart) {
                mapChart.on(eventName, eventListener);
            }
            return this;
        };

        this.getMap = function () {
            return mapChart;
        };

        this.getCurrentMapType = function () {
            return mapChart && mapChart.getSeries()[0].mapType || null;
        };

        this.getHistoryLevel = function () {
            return mapTypeHistory.length;
        };

        this.popHistory = function () {
            return mapTypeHistory.pop();
        };

        this.isReady = function () {
            return mapChart != null;
        };

        this.isLoading = function () {
            return isLoading;
        };

        this.triggerEvent = function (name, data) {
            if (mapChart && eventListeners[name]) {
                //console.log("triggerEvent:", name, data);
                eventListeners[name](this, data);
            }
            return this;
        };

        this.showLoading = function () {
            isLoading = true;
            this.triggerEvent(EVENT.SHOW_LOADING);
            mapChart.component.tooltip.hideTip();
            mapChart.showLoading();
            return this;
        };

        this.hideLoading = function () {
            isLoading = false;
            mapChart.hideLoading();
            this.triggerEvent(EVENT.HIDE_LOADING);
            return this;
        };

        this.getOption = function () {
            return mapChart.getOption();
        };

        this.setOption = function (option, notMerge) {
            console.debug("map setOption()", option);
            mapChart.resize();
            if (notMerge) {
                mapChart.setOption(defaultOption, true);
            }
            mapChart.setOption(option);
            lastMapType = this.getCurrentMapType();
            return this;
        };

        this.show = function () {
            if ($container) {
                $container.show();
            }
            return this;
        };

        this.hide = function () {
            if ($container) {
                $container.hide();
                lastMapType = null;
            }
            return this;
        };

        this.EVENT = EVENT;
    }

    return {
        init: function (id, option, events) {
            return new EChartsMap(id, option, events);
        },
        roundValue: function(value, precision) {
            var times;
            precision = precision || 0;
            if (precision > 0) {
                times = Math.pow(10, precision);
                return Math.round(value * times) / times;
            }
            return Math.round(value);
        },
        EVENT: EVENT
    };
});
