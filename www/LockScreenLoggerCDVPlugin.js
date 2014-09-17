var LockScreenLoggerCDVPlugin = {
               m_screenOn: function () {
               },
               m_screenOff: function () {
               },
               
               
               start: function (screenOnCallback, screenOffCallback, errorCallback) {
               this.m_screenOn = screenOnCallback;
               this.m_screenOff = screenOffCallback;
               !errorCallback && (errorCallback = function () {
                                  });
               
               cordova.exec(function (arg) {
                            }, errorCallback, "LockScreenLoggerCDVPlugin", "init", []);
               },
               
               status: function (resultCallback, cancelCallback, errorCallback) {
               cordova.exec(function (arg) {
                            resultCallback(arg);
                            }, errorCallback, "LockScreenLoggerCDVPlugin", "getScreenStatus", []);
               },
               
               screenon: function (data) {
               this.m_screenOn(data);
               },
               
               screenoff: function (data) {
               this.m_screenOff(data);
               }
               };
               
               
               module.exports = LockScreenLoggerCDVPlugin;
