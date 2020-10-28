module.exports = {
    requestPermission: function (successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "IOSAppTracking", "requestPermission");
    }
};
