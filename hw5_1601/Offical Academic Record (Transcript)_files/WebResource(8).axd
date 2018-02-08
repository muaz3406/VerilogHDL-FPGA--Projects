var JsUtilities = {};

JsUtilities.attachEvent = function(element, eventName, handler, capture) {
    try {
        if (typeof (element) == "string")
            element = document.getElementById(element);

        if (element.addEventListener)
            element.addEventListener(eventName, handler, capture);
        else element.attachEvent('on' + eventName, handler);

        this.EventsCache[this.EventsCache.length] = new Array(element, eventName, handler, capture ? capture : true);
    }
    catch (e) { }

};
JsUtilities.detachEvent = function(element, eventName, handler, capture) {
    if (typeof (element) == "string")
        element = document.getElementById(element);

    if (element.removeEventListener)
        element.removeEventListener(eventName, handler, capture);
    else element.detachEvent('on' + eventName, handler);
};
JsUtilities.init = function() {
    if (!this.EventsCache) {
        this.EventsCache = new Array();
        this.ObjectsToBeDeleted = new Array();
        this.PostbackEvents = new Array();
    }
};
JsUtilities.addPostbackEventTarget = function(key, eventRef) {
    if (typeof (eventRef) == "string" && typeof (key) == "string")
        this.PostbackEvents[key] = eventRef;
};
JsUtilities.executePostback = function(key) {
    if (typeof (key) == "string" && this.PostbackEvents[key] != null)
        eval(this.PostbackEvents[key]);
};
JsUtilities.doGeneralPostback = function(elementID, arguments) {
    __doPostBack(elementID, arguments);
}
JsUtilities.attachEvent = function(element, eventName, handler, capture) {
    try {
        if (typeof (element) == "string")
            element = document.getElementById(element);

        if (element.addEventListener)
            element.addEventListener(eventName, handler, capture);
        else element.attachEvent('on' + eventName, handler);

        this.EventsCache[this.EventsCache.length] = new Array(element, eventName, handler, capture ? capture : true);
    }
    catch (e) { }

};
JsUtilities.detachEvent = function(element, eventName, handler, capture) {
    if (typeof (element) == "string")
        element = document.getElementById(element);

    if (element.removeEventListener)
        element.removeEventListener(eventName, handler, capture);
    else element.detachEvent('on' + eventName, handler);
};
JsUtilities.cleanupEventsCache = function() {
    try {
        for (var i = this.EventsCache.length - 1; i >= 0; i--) {
            this.detachEvent(this.EventsCache[i][0], this.EventsCache[i][1], this.EventsCache[i][2], this.EventsCache[i][3]);
            this.EventsCache[i] = null;
        }

        this.EventsCache = null;
    }
    catch (e) { }
};
JsUtilities.deleteOnUnload = function(obj) {
    this.ObjectsToBeDeleted.push(obj);
};
JsUtilities.deleteObjects = function(obj) {
    while (this.ObjectsToBeDeleted.length > 0) {
        var _obj = this.ObjectsToBeDeleted.pop();

        if (_obj && _obj != null) {
            if (_obj.dispose)
                _obj.dispose();
        }

    }
    //B.Emre Session temizleme denemesi
    //PageMethods.AbandonSession();
   // alert("Killing the session on the server!!");
};
JsUtilities.getUnitAsPixel = function(unit) {
    var _unit = unit.toLowerCase();
    var _result = parseInt(_unit);

    if (_unit.indexOf("px") > 0)
        _result = Math.round(parseFloat(_unit));
    else if (_unit.indexOf("em") > 0)
        _result = Math.round(parseFloat(_unit) * this.getUnitEm());

    return _result;
};

JsUtilities.init();

JsUtilities.attachEvent(window, "unload",function(){JsUtilities.cleanupEventsCache();JsUtilities.deleteObjects();}
, 
true);

//JsUtilities.attachEvent(window, "unload", function() { JsUtilities.cleanupEventsCache(); JsUtilities.HandleClose(); }, true);

FixPopupZIndex = function(sender, args) {
    // Fix for the date picker
    setTimeout(
           function() {
               var popup = document.getElementById(sender._element.id + "_DropDown");
               popup.style.zIndex = 200000;
               popup.parentNode.style.zIndex = 200000;
           }, 0);
};
function mngRequestStarted(ajaxManager, eventArgs) {
    var pos = 0;
    try {
        pos = eventArgs._eventTarget.indexOf("ExportTo");
        if (pos < 0)
            pos = eventArgs._eventArgument.indexOf("ExportTo");

        if (pos >= 0) {
            eventArgs.EnableAjax = false;
            return;
        }

        pos = eventArgs._eventArgument.indexOf("RowClick;tr1");
        if (pos >= 0)
            eventArgs._cancel = true;
    }
    catch (err) {
    }
};
function callServerMethod(handler, fn, paramArray, successFn, errorFn) {
    //Create list of parameters in the form:
    //{"paramName1":"paramValue1","paramName2":"paramValue2"}
    if (!errorFn || errorFn == null)
        errorFn = ajaxFailed;

    var paramList = '';
    if (paramArray.length > 0) {
        for (var i = 0; i < paramArray.length; i += 2) {
            if (paramList.length > 0) paramList += ',';
            paramList += '"' + paramArray[i] + '":"' + paramArray[i + 1] + '"';
        }
    }
    paramList = '{' + paramList + '}';
    //Call the page method  
    $.ajax({
        type: "POST",
        url: handler + "/" + fn,
        contentType: "application/json; charset=utf-8",
        data: paramList,
        dataType: "json",
        success: successFn,
        error: errorFn
    });
}
function callPageMethod(fn, paramArray, successFn, errorFn) {
    var pagePath = window.location.pathname;
    callServerMethod(pagePath, fn, paramArray, successFn, errorFn);
}
function ajaxFailed(result) {
}
// Array Remove - By John Resig (MIT Licensed)
Array.prototype.remove = function(from, to) {
    var rest = this.slice((to || from) + 1 || this.length);
    this.length = from < 0 ? this.length + from : from;
    return this.push.apply(this, rest);
};

function showInFrame(code) {
    var ifrm = $('<iframe/>').css({
        'border': '0px',
        'background-color': '#fff',
        'width': '90%',
        'left': '5%',
        'height': '90%',
        'top': '5%',
        'position': 'fixed',
        'z-index': '200001'
    }).appendTo(document.body);

    ifrm[0].contentDocument.write(code);

    $(document).bind('click.showInFrame', function () {
        ifrm.hide();
        $(document).unbind('click.showInFrame');
    });
}