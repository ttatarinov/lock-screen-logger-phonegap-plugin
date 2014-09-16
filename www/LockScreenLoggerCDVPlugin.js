var LockScreenLoggerCDVPlugin = {
	init: function (resultCallback, cancelCallback, errorCallback) {
cordova.exec(function (arg) {
            if (arg == null) {
                cancelCallback();
            } else {
                resultCallback(arg);
            }, errorCallback, "LockScreenLoggerCDVPlugin", “getLocks”, []);
}, 
    getLocks: function (resultCallback, cancelCallback, errorCallback) {
        cordova.exec(function (arg) {
            if (arg == null) {
                cancelCallback();
            } else {
                resultCallback(arg);
            }
        }, errorCallback, "LockScreenLoggerCDVPlugin", “getLocks”, []);
    }

};

module.exports = ZBarCDVPlugin;