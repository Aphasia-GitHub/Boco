/**
 * Created by Pengxuan Men on 2015-08-03.
 */
define([
    'core/const',
    'core/conf',
    'core/ajax',
    'jquery'
], function (C, conf, ajax, $) {
    'use strict';

    var NATION_CODE = 100000,
        CODES = {
            "全国": NATION_CODE,
            "北京": 110000,
            "天津": 120000,
            "河北": 130000,
            "山西": 140000,
            "内蒙古": 150000,
            "辽宁": 210000,
            "吉林": 220000,
            "黑龙江": 230000,
            "上海": 310000,
            "江苏": 320000,
            "浙江": 330000,
            "安徽": 340000,
            "福建": 350000,
            "江西": 360000,
            "山东": 370000,
            "河南": 410000,
            "湖北": 420000,
            "湖南": 430000,
            "广东": 440000,
            "广西": 450000,
            "海南": 460000,
            "重庆": 500000,
            "四川": 510000,
            "贵州": 520000,
            "云南": 530000,
            "西藏": 540000,
            "陕西": 610000,
            "甘肃": 620000,
            "青海": 630000,
            "宁夏": 640000,
            "新疆": 650000,
            //"台湾": 710000,
            //"香港": 810000,
            //"澳门": 820000,

            "北京市": 110100,
            "天津市": 120100,
            "上海市": 310100,
            "重庆市": 500100,

            //"崇明县": 310200,            // ??
            "湖北省直辖县市": 429000,       // 仙桃
            "省直辖县级行政区划": 469000, // 海南直辖县市
            "自治区直辖县级行政区划": 659000, // 新疆直辖县市

            "石家庄市": 130100,
            "唐山市": 130200,
            "秦皇岛市": 130300,
            "邯郸市": 130400,
            "邢台市": 130500,
            "保定市": 130600,
            "张家口市": 130700,
            "承德市": 130800,
            "沧州市": 130900,
            "廊坊市": 131000,
            "衡水市": 131100,
            "太原市": 140100,
            "大同市": 140200,
            "阳泉市": 140300,
            "长治市": 140400,
            "晋城市": 140500,
            "朔州市": 140600,
            "晋中市": 140700,
            "运城市": 140800,
            "忻州市": 140900,
            "临汾市": 141000,
            "吕梁市": 141100,
            "呼和浩特市": 150100,
            "包头市": 150200,
            "乌海市": 150300,
            "赤峰市": 150400,
            "通辽市": 150500,
            "鄂尔多斯市": 150600,
            "呼伦贝尔市": 150700,
            "巴彦淖尔市": 150800,
            "乌兰察布市": 150900,
            "兴安盟": 152200,
            "锡林郭勒盟": 152500,
            "阿拉善盟": 152900,
            "沈阳市": 210100,
            "大连市": 210200,
            "鞍山市": 210300,
            "抚顺市": 210400,
            "本溪市": 210500,
            "丹东市": 210600,
            "锦州市": 210700,
            "营口市": 210800,
            "阜新市": 210900,
            "辽阳市": 211000,
            "盘锦市": 211100,
            "铁岭市": 211200,
            "朝阳市": 211300,
            "葫芦岛市": 211400,
            "长春市": 220100,
            "吉林市": 220200,
            "四平市": 220300,
            "辽源市": 220400,
            "通化市": 220500,
            "白山市": 220600,
            "松原市": 220700,
            "白城市": 220800,
            "延边朝鲜族自治州": 222400, // 延边
            "哈尔滨市": 230100,
            "齐齐哈尔市": 230200,
            "鸡西市": 230300,
            "鹤岗市": 230400,
            "双鸭山市": 230500,
            "大庆市": 230600,
            "伊春市": 230700,
            "佳木斯市": 230800,
            "七台河市": 230900,
            "牡丹江市": 231000,
            "黑河市": 231100,
            "绥化市": 231200,
            "大兴安岭地区": 232700, // 大兴安岭
            "南京市": 320100,
            "无锡市": 320200,
            "徐州市": 320300,
            "常州市": 320400,
            "苏州市": 320500,
            "南通市": 320600,
            "连云港市": 320700,
            "淮安市": 320800,
            "盐城市": 320900,
            "扬州市": 321000,
            "镇江市": 321100,
            "泰州市": 321200,
            "宿迁市": 321300,
            "杭州市": 330100,
            "宁波市": 330200,
            "温州市": 330300,
            "嘉兴市": 330400,
            "湖州市": 330500,
            "绍兴市": 330600,
            "金华市": 330700,
            "衢州市": 330800,
            "舟山市": 330900,
            "台州市": 331000,
            "丽水市": 331100,
            "合肥市": 340100,
            "芜湖市": 340200,
            "蚌埠市": 340300,
            "淮南市": 340400,
            "马鞍山市": 340500,
            "淮北市": 340600,
            "铜陵市": 340700,
            "安庆市": 340800,
            "黄山市": 341000,
            "滁州市": 341100,
            "阜阳市": 341200,
            "宿州市": 341300,
            "六安市": 341500,
            "亳州市": 341600,
            "池州市": 341700,
            "宣城市": 341800,
            "福州市": 350100,
            "厦门市": 350200,
            "莆田市": 350300,
            "三明市": 350400,
            "泉州市": 350500,
            "漳州市": 350600,
            "南平市": 350700,
            "龙岩市": 350800,
            "宁德市": 350900,
            "南昌市": 360100,
            "景德镇市": 360200,
            "萍乡市": 360300,
            "九江市": 360400,
            "新余市": 360500,
            "鹰潭市": 360600,
            "赣州市": 360700,
            "吉安市": 360800,
            "宜春市": 360900,
            "抚州市": 361000,
            "上饶市": 361100,
            "济南市": 370100,
            "青岛市": 370200,
            "淄博市": 370300,
            "枣庄市": 370400,
            "东营市": 370500,
            "烟台市": 370600,
            "潍坊市": 370700,
            "济宁市": 370800,
            "泰安市": 370900,
            "威海市": 371000,
            "日照市": 371100,
            "莱芜市": 371200,
            "临沂市": 371300,
            "德州市": 371400,
            "聊城市": 371500,
            "滨州市": 371600,
            "菏泽市": 371700,
            "郑州市": 410100,
            "开封市": 410200,
            "洛阳市": 410300,
            "平顶山市": 410400,
            "安阳市": 410500,
            "鹤壁市": 410600,
            "新乡市": 410700,
            "焦作市": 410800,
            "濮阳市": 410900,
            "许昌市": 411000,
            "漯河市": 411100,
            "三门峡市": 411200,
            "南阳市": 411300,
            "商丘市": 411400,
            "信阳市": 411500,
            "周口市": 411600,
            "驻马店市": 411700,
            "济源市": 419000,
            "武汉市": 420100,
            "黄石市": 420200,
            "十堰市": 420300,
            "宜昌市": 420500,
            "襄阳市": 420600,
            "鄂州市": 420700,
            "荆门市": 420800,
            "孝感市": 420900,
            "荆州市": 421000,
            "黄冈市": 421100,
            "咸宁市": 421200,
            "随州市": 421300,
            "恩施土家族苗族自治州": 422800, // 恩施
            "潜江市": 429100,
            "天门市": 429200,
            "长沙市": 430100,
            "株洲市": 430200,
            "湘潭市": 430300,
            "衡阳市": 430400,
            "邵阳市": 430500,
            "岳阳市": 430600,
            "常德市": 430700,
            "张家界市": 430800,
            "益阳市": 430900,
            "郴州市": 431000,
            "永州市": 431100,
            "怀化市": 431200,
            "娄底市": 431300,
            "湘西土家族苗族自治州": 433100, // 湘西
            "广州市": 440100,
            "韶关市": 440200,
            "深圳市": 440300,
            "珠海市": 440400,
            "汕头市": 440500,
            "佛山市": 440600,
            "江门市": 440700,
            "湛江市": 440800,
            "茂名市": 440900,
            "肇庆市": 441200,
            "惠州市": 441300,
            "梅州市": 441400,
            "汕尾市": 441500,
            "河源市": 441600,
            "阳江市": 441700,
            "清远市": 441800,
            "东莞市": 441900,
            "中山市": 442000,
            "潮州市": 445100,
            "揭阳市": 445200,
            "云浮市": 445300,
            "南宁市": 450100,
            "柳州市": 450200,
            "桂林市": 450300,
            "梧州市": 450400,
            "北海市": 450500,
            "防城港市": 450600,
            "钦州市": 450700,
            "贵港市": 450800,
            "玉林市": 450900,
            "百色市": 451000,
            "贺州市": 451100,
            "河池市": 451200,
            "来宾市": 451300,
            "崇左市": 451400,
            "海口市": 460100,
            "三亚市": 460200,
            "三沙市": 460300,
            "成都市": 510100,
            "自贡市": 510300,
            "攀枝花市": 510400,
            "泸州市": 510500,
            "德阳市": 510600,
            "绵阳市": 510700,
            "广元市": 510800,
            "遂宁市": 510900,
            "内江市": 511000,
            "乐山市": 511100,
            "南充市": 511300,
            "眉山市": 511400,
            "宜宾市": 511500,
            "广安市": 511600,
            "达州市": 511700,
            "雅安市": 511800,
            "巴中市": 511900,
            "资阳市": 512000,
            "阿坝藏族羌族自治州": 513200, // 阿坝
            "甘孜藏族自治州": 513300, // 甘孜
            "凉山彝族自治州": 513400, // 凉山
            "贵阳市": 520100,
            "六盘水市": 520200,
            "遵义市": 520300,
            "安顺市": 520400,
            "毕节市": 520500,
            "铜仁市": 520600,
            "黔西南布依族苗族自治州": 522300, // 黔西南
            "黔东南苗族侗族自治州": 522600, // 黔东南
            "黔南布依族苗族自治州": 522700, // 黔南
            "昆明市": 530100,
            "曲靖市": 530300,
            "玉溪市": 530400,
            "保山市": 530500,
            "昭通市": 530600,
            "丽江市": 530700,
            "普洱市": 530800,
            "临沧市": 530900,
            "楚雄彝族自治州": 532300, // 楚雄
            "红河哈尼族彝族自治州": 532500, // 红河
            "文山壮族苗族自治州": 532600, // 文山
            "西双版纳傣族自治州": 532800, // 西双版纳
            "大理白族自治州": 532900, // 大理
            "德宏傣族景颇族自治州": 533100, // 德宏
            "怒江傈僳族自治州": 533300, // 怒江
            "迪庆藏族自治州": 533400, // 迪庆
            "拉萨市": 540100,
            "昌都地区": 542100,
            "山南地区": 542200,
            "日喀则地区": 542300,
            "那曲地区": 542400,
            "阿里地区": 542500,
            "林芝地区": 542600,
            "西安市": 610100,
            "铜川市": 610200,
            "宝鸡市": 610300,
            "咸阳市": 610400,
            "渭南市": 610500,
            "延安市": 610600,
            "汉中市": 610700,
            "榆林市": 610800,
            "安康市": 610900,
            "商洛市": 611000,
            "兰州市": 620100,
            "嘉峪关市": 620200,
            "金昌市": 620300,
            "白银市": 620400,
            "天水市": 620500,
            "武威市": 620600,
            "张掖市": 620700,
            "平凉市": 620800,
            "酒泉市": 620900,
            "庆阳市": 621000,
            "定西市": 621100,
            "陇南市": 621200,
            "临夏回族自治州": 622900, // 临夏
            "甘南藏族自治州": 623000, // 甘南
            "西宁市": 630100,
            "海东地区": 632100,
            "格尔木市": 632900,
            "海北藏族自治州": 632200, // 海北
            "黄南藏族自治州": 632300, // 黄南
            "海南藏族自治州": 632500, // 海南
            "果洛藏族自治州": 632600, // 果洛
            "玉树藏族自治州": 632700, // 玉树
            "海西蒙古族藏族自治州": 632800, // 海西
            "银川市": 640100,
            "石嘴山市": 640200,
            "吴忠市": 640300,
            "固原市": 640400,
            "中卫市": 640500,
            "乌鲁木齐市": 650100,
            "克拉玛依市": 650200,
            "吐鲁番地区": 652100,
            "哈密地区": 652200,
            "昌吉回族自治州": 652300, // 昌吉
            "博尔塔拉蒙古自治州": 652700, // 博尔塔拉
            "巴音郭楞蒙古自治州": 652800, // 巴音郭楞
            "阿克苏地区": 652900,
            "克孜勒苏柯尔克孜自治州": 653000, // 克孜勒苏
            "喀什地区": 653100,
            "和田地区": 653200,
            "伊犁哈萨克自治州": 654000, // 伊犁
            "塔城地区": 654200,
            "阿勒泰地区": 654300,
            /*"台湾省": 710000,
            "香港特别行政区": 810100,
            "澳门特别行政区": 820000"*/

            // 北京市
            "东城区": 110101,
            "西城区": 110102,
            "朝阳区": 110105,
            "丰台区": 110106,
            "石景山区": 110107,
            "海淀区": 110108,
            "门头沟区": 110109,
            "房山区": 110111,
            "通州区": 110112,
            "顺义区": 110113,
            "昌平区": 110114,
            "大兴区": 110115,
            "怀柔区": 110116,
            "平谷区": 110117,
            "密云县": 110128,
            "延庆县": 110129,
            // 上海市
            "奉贤区": 310120,
            "崇明县": 310130,
            "黄浦区": 310101,
            "徐汇区": 310104,
            "长宁区": 310105,
            "静安区": 310106,
            "普陀区": 310107,
            "闸北区": 310108,
            "虹口区": 310109,
            "杨浦区": 310110,
            "闵行区": 310112,
            "宝山区": 310113,
            "嘉定区": 310114,
            "浦东新区": 310115,
            "金山区": 310116,
            "松江区": 310117,
            "青浦区": 310118
        },
        NAMES = {},
        MUNICIPALITY_CODES = [],
        MUNICIPALITY_NAMES = ['北京', '天津', '上海', '重庆'];

    $.each(CODES, function (name, code) {
        if ($.isNumeric(code)) {
            NAMES[code] = name;
        }
    });
    $.each(MUNICIPALITY_NAMES, function (i, name) {
        if (CODES[name]) {
            MUNICIPALITY_CODES.push(CODES[name]);
        }
    });

    // 中国各级行政区划
    // http://www.24en.com/column/Khubilai/2010-08-31/119131.html

    return {
        names: NAMES,
        codes: CODES,
        isValid: function (geoCode) {
            return /^[1-9][0-9]{5}$/.test(geoCode);
        },
        isAvailable: function (geoCode) {
            return /^[1-9][0-9]{5}$/.test(geoCode) && !!NAMES[geoCode];
        },
        /**
         * 该行政代码是否为全国。
         * @param {number} geoCode
         * @returns {boolean}
         */
        isNation: function (geoCode) {
            return geoCode == NATION_CODE;
        },
        /**
         * 该行政代码是否为省级。
         * @param {number} geoCode
         * @returns {boolean}
         */
        isProvince: function (geoCode) {
            return !this.isNation(geoCode) && geoCode % 10000 === 0;
        },
        /**
         * 该行政代码是否为直辖市（省级）。
         * @param {number} geoCode
         * @returns {boolean}
         */
        isMunicipality: function (geoCode) {
            return $.inArray(geoCode, MUNICIPALITY_CODES) > -1;
        },
        /**
         * 该行政代码是否为地区级。包括：地级市、自治州、地区、盟。
         * @param {number} geoCode
         * @returns {boolean}
         */
        isPrefecture: function (geoCode) {
            return geoCode % 100 === 0 && !this.isProvince(geoCode) && !this.isNation(geoCode);
        },
        /**
         * 该行政代码是否为副地区级。（此类型为特殊情况，在地图中与地区级同级显示。）
         * @param {number} geoCode
         * @returns {boolean}
         */
        isSubPrefecture: function (geoCode) {
            // TODO: need a list.
            return false;
        },
        /**
         * 该行政代码是否为县级。包括：县、市辖区、县级市、自治县、旗、自治旗、林区、特区。
         * @param {number} geoCode
         * @returns {boolean}
         */
        isCounty: function (geoCode) {
            return geoCode % 100 !== 0;
        },
        /**
         * 获取省级行政代码。
         * @param {number} geoCode
         * @returns {number}
         */
        getProvinceCode: function (geoCode) {
            return Math.floor(geoCode / 10000) * 10000;
        },
        getFullName: function (geoCode) {
            var name = NAMES[geoCode];
            if (this.isNation(geoCode)) {

            } else if (this.isProvince(geoCode)) {
                if (name == '内蒙古' || name == '广西' || name == '西藏' || name == '宁夏' || name == '新疆') {
                    if (name == '广西') {
                        name += '壮族'
                    } else if (name == '宁夏') {
                        name += '回族'
                    } else if (name == '新疆') {
                        name += '维吾尔'
                    }
                    name += '自治区'
                } else if (this.isMunicipality(geoCode)) {
                    name += '市';
                } else {
                    name += '省';
                }
            }
            return name;
        },
        getCenter: function (geoCode, callback) {
            if (!this.isValid(geoCode)) {
                console.error('Param error.');
                callback(null);
                return this;
            }

            if (this.isNation(geoCode)) {
                callback(C.GEO.NATION_CENTER_AND_ZOOM);
            } else if (this.isPrefecture(geoCode)) {
                this.getCenterAndZoom(geoCode, function (centerAndZoom, isExtent) {
                    if (isExtent && centerAndZoom) {
                        centerAndZoom = {
                            lng: (centerAndZoom.minX + centerAndZoom.maxX) / 2,
                            lat: (centerAndZoom.minY + centerAndZoom.maxY) / 2
                        };
                    }
                    callback(centerAndZoom);
                });
            } else {
                this.getExtent(geoCode, function (extent) {
                    callback(extent ? {
                        lng: (extent.minX + extent.maxX) / 2,
                        lat: (extent.minY + extent.maxY) / 2
                    } : null);
                });
            }
            return this;
        },
        getCenterAndZoom: function (geoCode, callback, acceptExtent) {
            if (!this.isValid(geoCode)) {
                console.error('Param error.');
                callback(null);
                return this;
            }

            var self = this;

            if (this.isNation(geoCode)) {
                callback(C.GEO.NATION_CENTER_AND_ZOOM);
            } else if (this.isProvince(geoCode)) {
                // Not support.
                console.warn('Not support to get center & zoom for province.');
                callback(null);
            } else if (this.isPrefecture(geoCode)) {
                ajax.init().success(function (code, msg, data) {
                    if (data && data.longitude && data.latitude && data.zoom_level) {
                        callback({lng: data.longitude, lat: data.latitude, zoom: data.zoom_level});
                    } else if (acceptExtent != false) {
                        self.getExtent(geoCode, function (extent) {
                            callback(extent, true);
                        });
                    } else {
                        callback(null);
                    }
                }).error(function (code, msg, data) {
                    if (code !== C.AJAX_CODE.LOGIN_REQUIRED) {
                    }
                    callback(null)
                }).complete(function (jqXHR, textStatus) {
                }).post(conf.AJAX.GIS_REGION_INFO, {
                    province_id: this.getProvinceCode(geoCode),
                    region_id: geoCode
                });
            } else if (this.isCounty(code)) {
                // Not support.
                console.warn('Not support to get center & zoom for county.');
                callback(null);
            }
            return this;
        },
        getExtent: function (geoCode, callback) {
            var url = null,
                name = null;
            if (this.isNation(geoCode)) {
            } else if (this.isProvince(geoCode)) {
                url = conf.REST.GIS_SERVICE_PROVINCE;
                name = this.getFullName(geoCode);
            } else if (this.isPrefecture(geoCode)) {
                url = conf.REST.GIS_SERVICE_PREFECTURE;
            } else if (this.isCounty(geoCode)) {
                url = conf.REST.GIS_SERVICE_COUNTY;
            }
            if (url == null) {
                callback(null);
                return this;
            }
            $.ajax(url + '/query', {
                data: {
                    f: 'json',
                    where: name ? 'NAME_CHN=\'' + name + '\'' : 'CODE=' + geoCode,
                    //returnGeometry: true,
                    //spatialRel: 'esriSpatialRelIntersects',
                    outFields: name ? 'Name_CHN' : 'CODE,Name_CHN',
                    outSR: 4326
                },
                dataType: 'json',
                success: function (data, textStatus, jqXHR) {
                    //console.debug(data);
                    var extent = null;
                    if (data && data.features && data.features.length === 1) {
                        $.each(data.features[0].geometry.rings, function (i, ring) {
                            $.each(ring, function (j, item) {
                                if (i === 0 && j === 0) {
                                    extent = {
                                        minX: item[0],
                                        minY: item[1],
                                        maxX: item[0],
                                        maxY: item[1]
                                    }
                                } else {
                                    extent.minX = Math.min(extent.minX, item[0]);
                                    extent.minY = Math.min(extent.minY, item[1]);
                                    extent.maxX = Math.max(extent.maxX, item[0]);
                                    extent.maxY = Math.max(extent.maxY, item[1]);
                                }
                            });
                        });
                        callback(extent);
                    } else {
                        callback(null);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    callback(null);
                }
            });
            return this;
        }
    }
});
