var LockScreenLoggerCDVPlugin = {
    screenOn: function(){},
    screenOff: function(){},


    start: function(screenOnCallback, screenOffCallback, errorCallback){
        screenOn = screenOnCallback;
        screenOff = screenOffCallback;
        !errorCallback && (errorCallback = function(){});

        cordova.exec(function (arg) {
        }, errorCallback, "LockScreenLoggerCDVPlugin", "init", []);
    },

    status: function(resultCallback, cancelCallback, errorCallback){
        cordova.exec(function (arg) {
            resultCallback(arg);
        }, errorCallback, "LockScreenLoggerCDVPlugin", "getScreenStatus", []);
    },

    screenon: function(data){
        screenOn && screenOn(data);
    },

    screenoff: function(data){
        screenOff && screenOff(data);
    }
};



module.exports = LockScreenLoggerCDVPlugin;