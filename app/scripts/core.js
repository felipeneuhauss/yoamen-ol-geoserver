window.CoreView = {
    template : function(url) {
        var data = "<h1> failed to load url : " + url + "</h1>",
            r = new XMLHttpRequest();
        r.open("GET", url, false);
        r.onreadystatechange = function () {
            if (r.readyState != 4 || r.status != 200) return;
            data = r.responseText;
        };
        r.send()
        return data
    },
    get : function(url) {
        var data = false,
            r = new XMLHttpRequest();
        r.open("GET", url, false);
        r.onreadystatechange = function () {
            if (r.readyState != 4 || r.status != 200) return;
            data = r.responseText;
        };
        r.send()
        return data
    },
    plugin : function(url) {
        var data = "<h1> failed to load url : " + url + "</h1>";
        $.ajax({
            async: false,
            url: url,
            success: function(response) {
                data = response;
            }
        });
        return data;
    },
    load : function(url,parameters) {
        $.getScript(url)
    }
}
