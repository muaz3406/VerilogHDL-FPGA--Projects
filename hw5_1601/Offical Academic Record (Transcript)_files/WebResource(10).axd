var WindowManager = {};

WindowManager.init = function(objectId) {
    this.m_objectId = objectId;
    this.m_modalWindow = null;
    this.m_lastModalResult = null;
    this.m_resultHandler = null;
    this.m_windowLeft = document.all ? "left" : "screenX";
    this.m_windowTop = document.all ? "top" : "screenY";
    this.m_windowSeed = 0;

    //	if(!window.onFocusAttached)
    //	{
    //		var _wm = this;
    //		window.suppressParentFocus = true;
    //		window.onfocus = function(e){return _wm.onWindowFocus(e);};
    //		window.onFocusAttached = true;
    //	}
};

WindowManager.openWindow = function(url, name, reload, params) {
    var _windowHost = window;
    if (window.dialogArguments)
        _windowHost = window.dialogArguments;

    var _window;
    if (params)
        _window = _windowHost.open("", name, params);
    else _window = _windowHost.open("", name);

    if (_window) {
        if (reload || _window.location.href == "about:blank")
            _window.location.href = url;

        _window.focus();
    }

    return _window;
};
WindowManager.openWindowWH = function(url, name, reload, width, height, center, params) {
    var _params = "width=" + width + ",height=" + height;

    if (center) {
        _params += "," + this.m_windowLeft + "=" + Math.floor((window.screen.width - width) / 2);
        _params += "," + this.m_windowTop + "=" + Math.floor((window.screen.height - height) / 2);
    }

    if (params)
        _params += "," + params;

    return this.openWindow(url, name, reload, _params);
};
WindowManager.getNextWindowName = function() {
    var _result = "_W_" + this.m_windowSeed++;

    if (window.name)
        return window.name + _result;
    else return _result + Math.random();
};
WindowManager.openDialog = function(url, arguments, features, resultHandler, addCurrentTimeToUrl) {
    try {
        this.m_lastModalResult = null;

        if (window.dialogArguments)
            arguments = window.dialogArguments;
        else arguments = window;


        if (resultHandler)
            this.m_resultHandler = resultHandler;
        else this.m_resultHandler = null;

        if (addCurrentTimeToUrl) {
            var _pos = url.indexOf("?");
            var _now = new Date();

            url += (_pos >= 0 ? "&t=" : "?t=") + encodeURIComponent("" + _now.getTime());
        }

        if (window.showModalDialog) {
            this.m_lastModalResult = window.showModalDialog(url, arguments, features);
            this.setModalResult(this.m_lastModalResult);
            return this.m_lastModalResult;
        } else {
            features = features.replace(/ /gi, '');

            var _features = features.split(";");
            var _params = "directories=0,menubar=0,titlebar=0,toolbar=0,modal=yes";
            var _height = 300;
            var _width = 400;

            for (key in _features) {
                var _feature = _features[key].split(":");
                var _featureName = _feature[0].toLowerCase();
                var _featureValue = _feature[1];

                switch (_featureName) {
                case "dialogheight":
                    _height = JsUtilities.getUnitAsPixel(_featureValue);
                    _params += ",height=" + _height;
                    break;
                case "dialogwidth":
                    _width = JsUtilities.getUnitAsPixel(_featureValue);
                    _params += ",width=" + _width;
                    break;
                case "dialogtop":
                    _params += "," + _windowTop + "=" + JsUtilities.getUnitAsPixel(_featureValue);
                    break;
                case "dialogleft":
                    _params += "," + _windowLeft + "=" + JsUtilities.getUnitAsPixel(_featureValue);
                    break;
                case "resizable":
                    _params += ",resizable=" + _featureValue;
                    break;
                case "status":
                    _params += ",status=" + _featureValue;
                    break;
                case "center":
                    if (_featureValue.toLowerCase() == "yes" || _featureValue == "1") {
                        _params += "," + this.m_windowLeft + "=" + Math.floor((window.screen.width - _width) / 2);
                        _params += "," + this.m_windowTop + "=" + Math.floor((window.screen.height - _height) / 2);
                    }
                    break;
                } //switch
            } //for

            this.m_modalWindow = window.open(url, "popupWindow", _params);

            if (this.m_modalWindow) {
                this.m_modalWindow.dialogArguments = arguments;
                this.m_modalWindow.isModal = true;
                this.m_modalWindow.suppressParentFocus = false;
            }
        } //else

    } catch (exception) {
        alert(exception.message);
    }
};
WindowManager.onWindowFocus = function(e) {
    try {
        if (typeof(window.suppressParentFocus) != "undefined"
            && !window.suppressParentFocus
            && window.isModal
            && window.opener
            && !window.opener.closed) {
            window.opener.suppressModalFocus = true;
            window.opener.focus();
            window.opener.suppressModalFocus = false;
            window.suppressParentFocus = true;
            window.focus();
            window.suppressParentFocus = false;
        }

        if (!window.suppressModalFocus
            && this.m_modalWindow) {
            if (this.m_modalWindow.closed)
                this.m_modalWindow = null;
            else this.m_modalWindow.focus();
        }
    } catch (exception) {
        this.m_modalWindow = null;
    }
};

WindowManager.getLastModalResult = function() {
    if (!this.m_lastModalResult) {
        if (this.m_modalWindow) {
            if (typeof(this.m_modalWindow.returnValue) != "undefined")
                this.m_lastModalResult = _modalWindow.returnValue;
        }
    }

    return this.m_lastModalResult;
};
WindowManager.setModalResultDelayed = function(result) {
    this.m_lastModalResult = result;
    var _wm = this;
    window.setTimeout(function() { _wm.setModalResult(_wm.m_lastModalResult); }, 100);
};
WindowManager.setModalResult = function(result) {
    this.m_lastModalResult = result;

    if (typeof(this.m_resultHandler) == "function")
        this.m_resultHandler(result);
};
WindowManager.closeWithResult = function(result) {
    debugger;
    window.returnValue = result;
    window.closedWithResult = false;

    if (window.opener && window.opener.WindowManager) {
        window.opener.WindowManager.setModalResultDelayed(result);
        window.opener.WindowManager.m_modalWindow = null;
    }

    window.setTimeout(function() { window.close(); }, 300);
};
WindowManager.close = function() {
    window.closedWithResult = false;

    if (window.opener
        && window.opener.WindowManager) {
        window.opener.WindowManager.m_modalWindow = null;
    }

    window.setTimeout(function() { window.close(); }, 300);
};

WindowManager.init("WindowManager");

