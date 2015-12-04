/**
 * @author Pengxuan Men
 */
define(['util/strings'], function (strings) {
    return {
        calculateAxisRange: function (values, unit, splitNumber) {
            // 自定义Y轴放大聚焦算法
            var max = Math.round(Math.max.apply(null, values) + 1),
                min = Math.max(0, Math.min.apply(null, values) - 1);
            splitNumber = splitNumber || 5;
            // 保证百分数不超过100
            if (unit === "%") {
                max = Math.min(100, max);
                min = Math.min(100 - splitNumber, min);
            }
            // 保证分割不出现小数
            if ((max - min) % splitNumber != 0) {
                min -= (splitNumber - (max - min) % splitNumber);
            }
            if (min < 0) {
                max -= min;
                min = 0;
            }

            return {
                min: min,
                max: max,
                splitNumber: splitNumber
            };
        },
        calculateDataRange: function (min, max, splitNumber, minRange, unit) {
            var levels = [],
                len = max.toString().length,
                times = Math.pow(10, len - 1),
                range,
                i;
            console.debug(max, len, times);
            min = Math.floor(min / times) * times;
            range = Math.ceil((max - min) / times / splitNumber) * times;
            if (minRange && minRange > 0) {
                range = Math.max(range, minRange);
            }
            for (i = 0; i < splitNumber; i++) {
                levels.unshift({ start: min, end: min += range });
            }
            this.addUnitToSplitList(levels, unit);
            return { splitList: levels };
        },
        addUnitToSplitList: function (splitList, unit) {
            if (!splitList) {
                return this;
            }
            $.each(splitList, function (i, range) {
                // Add unit to label.
                if (!range.label && (unit || range.labelPrefix || range.labelSuffix)) {
                    if (range.end === undefined) {
                        range.label = strings.format('> {0}{1}', range.start, unit);
                    } else if (range.start === undefined) {
                        range.label = strings.format('< {0}{1}', range.end, unit);
                    } else if (range.start !== undefined && range.end !== undefined) {
                        range.label = strings.format('{0}{2} - {1}{2}', range.start, range.end, unit);
                    }
                    if (range.labelPrefix) {
                        range.label = range.labelPrefix + range.label;
                    }
                    if (range.labelSuffix) {
                        range.label =  range.label + range.labelSuffix;
                    }
                }
            });
        },
        isUnitMeaningful: function (unit) {
            return unit && unit != '个' && unit != '次';
        }
    };
});
