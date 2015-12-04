/**
 * @author Pengxuan Men
 */
define(['jquery', 'core/utils'], function () {
    return {
        repeat: function (ch, repeat) {
            var result = "",
                i;
            if ($.isString(ch) && repeat >= 0) {
                for (i = 0; i < repeat; i++) {
                    result += ch;
                }
            }
            return result;
        },
        format: function (format) {
            var len = arguments.length,
                data = [];
            if (len == 2 && $.isArray(arguments[1])) {
                data = arguments[1];
            } else {
                data = Array.prototype.slice.call(arguments, 1);
            }
            $.each(data, function (i, item) {
                format = format.replace(new RegExp('\\{' + i + '\\}', 'g'), item);
            });
            return format;
        },
        toHtmlUsingBr: function (text) {
            var html = "";
            if ($.isString(text)) {
                html = text.replace(/\r\n|\r|\n/g, "<br>");
            }
            return html;
        },
        toHtmlUsingP: function (text) {
            var html = "";
            if ($.isString(text)) {
                html = "<p>" + text.replace(/\r\n|\r|\n/g, "</p><p>") + "</p>";
            }
            return html;
        }
    };
});
