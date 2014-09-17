(function(){
    var screenOn = function(){};
    var screenOff = function(){};

    function lockScreen(){
    }

    var p = lockScreen.prototype;

    p.start = function(screenOnCallback, screenOffCallback, errorCallback){
        screenOn = screenOnCallback;
        screenOff = screenOffCallback;
        !errorCallback && (errorCallback = function(){});

        cordova.exec(function (arg) {
        }, errorCallback, "LockScreenLoggerCDVPlugin", "init", []);
    };

    p.status = function(resultCallback, cancelCallback, errorCallback){
        cordova.exec(function (arg) {
            resultCallback(arg);
        }, errorCallback, "LockScreenLoggerCDVPlugin", "getScreenStatus", []);
    };

    p.screenon = function(data){
        screenOn && screenOn(data);
    };

    p.screenoff = function(data){
        screenOff && screenOff(data);
    };


    // define in cordova
    cordova.define("com.citronium.lockscreenloggerplugin.LockScreenLoggerCDVPlugin", function(require, exports, module) {

        var inst = new lockScreen();

        window['LockScreenLoggerCDVPlugin'] = inst;

        module.exports = inst;
    });
})();
