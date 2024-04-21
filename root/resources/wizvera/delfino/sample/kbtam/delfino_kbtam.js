/**
 * KB 계좌통합 사용자 인터페이스 
 * @version 1.0.0.1
 * @since 2016. 08. 23.
 */

DelfinoConfig.useRecentModule = false;
if (Delfino.getModule() != "G3" && !DC_platformInfo.Mobile) Delfino.setModule("G3");

var delfinokbtam = {};
delfinokbtam.handler = delfinokbtam.handler || (function(jQuery) {
    var _handler = delfino.handler;
    _handler._cb = {};
    jQuery.support.cors = true;
    function commonFunc(cmd,data,ctx) {
        ctx = ctx || {};

        var encryptedData = false;
        var requireEncrypt = false;

        if(delfino.conf.handler.supportSync == true) {
            var syncMethod = ["listCertStore"];
            if(jQuery.inArray(cmd,syncMethod) >= 0)
                ctx.sync = true;
        }

        var encCmd = ["verifyKeyPair","deleteKeyPair","listCertInfo","issueKeyPair","envelop","convertWrapSeedList","makeRoamingData","resolveRoamingData"];
        if(jQuery.inArray(cmd,encCmd) >= 0)
            encryptedData = true;
        if(cmd == "getResult")
            requireEncrypt = true;


        if(encryptedData == true)
            data = delfino.handler.secure.enc(data);

        var data = {"cmd":cmd,"sid":_handler.getSid(),"encryptedData":encryptedData,"requireEncrypt":requireEncrypt,"data":data};

		DelfinoConfig.useDelfinoSession = DelfinoConfig.useDelfinoSession || false;
		if(DelfinoConfig.useDelfinoSession) {
			data.session = wiz.util.session.get();
		}

        ctx.data = data;
        return getCallbackCtx(ctx.data.cmd,ctx);
    };

    function getCallbackCtx(name,ctx) {
        var defCallback = _handler._cb[name];
        if(undefined == defCallback) {
            defCallback = {};
            defCallback.success = function(res){};
            defCallback.error = function(res){};
            defCallback.timeout = function(res){};
        }

        defCallback.onsuccess = function(cb) { this.success = cb; return this;};
        defCallback.onerror = function(cb) { this.error = cb; return this;};
        defCallback.ontimeout = function(cb) { this.timeout = cb; return this;};
        defCallback.invoke = function() { return delfino.handler.invoke(this);};

        ctx = jQuery.extend({},defCallback,ctx);
        return ctx;
    };

	_handler.deleteKeyPair = function(data, ctx) {
		return commonFunc("deleteKeyPair", data, ctx);
	};
	_handler.verifyKeyPair = function(data, ctx) {
		return commonFunc("verifyKeyPair", data, ctx);
	};
	_handler.issueKeyPair = function(data, ctx) {
		return commonFunc("issueKeyPair", data, ctx);
	};
	_handler.envelop = function(data, ctx) {
		return commonFunc("envelop", data, ctx);
	};
	_handler.convertWrapSeedList = function(data, ctx) {
		return commonFunc("convertWrapSeedList", data, ctx);
	};
	_handler.makeRoamingData = function(data, ctx) {
		return commonFunc("makeRoamingData", data, ctx);
	};
	_handler.resolveRoamingData = function(data, ctx) {
		return commonFunc("resolveRoamingData", data, ctx);
	};
	_handler.listCertStore = function(data, ctx) {
		return commonFunc("listCertStore", data, ctx);
	};
	_handler.listCertInfo = function(data, ctx) {
		return commonFunc("listCertInfo", data, ctx);
	};
    return _handler;
})(jQuery);



DCrypto.listCertStore = function(type, complete) {
	return delfinokbtam.handler.listCertStore({type: type},{success:complete}).invoke();
};
DCrypto.listCertInfo = function(handle, type, name, options) {
    if (typeof options === "string") options = jQuery.parseJSON(options);
    options = options || {};
    if (options.lang == null && DCrypto.lang != null) {
        if (DCrypto.settedLang != DCrypto.lang.name) {
            options.lang = DCrypto.lang;
        }
    }
    if (options.lang != null) DCrypto.settedLang = options.lang.name;
	handle = handle.toString();
	delfinokbtam.handler.listCertInfo({
		handle: handle,
		type: type,
		name: name,
		options: options
	}).onsuccess(this.successCheck).invoke();
	this.startGetResultTimer();
};
DCrypto.deleteKeyPair = function(handle, uid) {
	handle = handle.toString();
	delfinokbtam.handler.deleteKeyPair({
		handle: handle,
		uid: uid
	}).onsuccess(this.successCheck).invoke();
	this.startGetResultTimer();
};
DCrypto.verifyKeyPair = function(handle, uid) {
	handle = handle.toString();
	delfinokbtam.handler.verifyKeyPair({
		handle: handle,
		uid: uid
	}).onsuccess(this.successCheck).invoke();
	this.startGetResultTimer();
};
DCrypto.issueKeyPair = function(handle, uid, name, pinNumber) {
	handle = handle.toString();
	delfinokbtam.handler.issueKeyPair({
		handle: handle,
		uid: uid,
		name: name,
		pinNumber: pinNumber
	}).onsuccess(this.successCheck).invoke();
	this.startGetResultTimer();
};
DCrypto.envelop = function(handle, data, uid, dataType, userPublicKey) {
	handle = handle.toString();
	delfinokbtam.handler.envelop({
		handle: handle,
		data: data,
		uid: uid,
		dataType: dataType,
		userPublicKey: userPublicKey
	}).onsuccess(this.successCheck).invoke();
	this.startGetResultTimer();
};
DCrypto.convertWrapSeedList = function(handle, serverPublicKey, wrapSeedList, uid, pinNumber) {
	handle = handle.toString();
	delfinokbtam.handler.convertWrapSeedList({
		handle: handle,
		serverPublicKey: serverPublicKey,
		wrapSeedList: wrapSeedList,
		uid: uid,
		pinNumber: pinNumber
	}).onsuccess(this.successCheck).invoke();
	this.startGetResultTimer();
};
DCrypto.makeRoamingData = function(handle, uid, name, pinNumber) {
	handle = handle.toString();
	delfinokbtam.handler.makeRoamingData({
		handle: handle,
		uid: uid,
		name: name,
		pinNumber: pinNumber
	}).onsuccess(this.successCheck).invoke();
	this.startGetResultTimer();
};
DCrypto.resolveRoamingData = function(handle, uid, name, pinNumber, roamingData) {
	handle = handle.toString();
	delfinokbtam.handler.resolveRoamingData({
		handle: handle,
		uid: uid,
		name: name,
		pinNumber: pinNumber,
		roamingData: roamingData
	}).onsuccess(this.successCheck).invoke();
	this.startGetResultTimer();
};



var DelfinoKbtam = DelfinoKbtam || (function(jQuery){
    var _delfinokbtam = window.Delfino;
    _delfinokbtam.listCertStore = function(complete){
		this.initHandler({retryCount:0,execTimeout:1000,success:function(){
			DCrypto.listCertStore("2", complete);
        }});
		return false;
    };
	_delfinokbtam.listCertInfo = function(drive, options, complete)
    {
		options = options || {};
		options.resetCertificate = true;
		var handle = this.addComplete(complete);
		this.initHandler({retryCount:0,execTimeout:1000,success:function(){
			DCrypto.listCertInfo(handle, "2", drive, JSON.stringify(options));
		}});
		return false;
    };
    _delfinokbtam.issueKeyPair = function(uid, name, pinNumber, complete)
    {
		var handle = this.addComplete(complete);
		this.initHandler({retryCount:0,execTimeout:1000,success:function(){
			DCrypto.issueKeyPair(handle, uid, name, pinNumber);
		}});
		return false;
    };
    _delfinokbtam.envelop = function(data, uid, dataType, userPublicKey, complete)
    {
		var handle = this.addComplete(complete);
		this.initHandler({retryCount:0,execTimeout:1000,success:function(){
			DCrypto.envelop(handle, data, uid, dataType, userPublicKey);
		}});
		return false;
    };
    _delfinokbtam.convertWrapSeedList = function(serverPublicKey, wrapSeedList, uid, pinNumber, complete)
    {
		var handle = this.addComplete(complete);
		this.initHandler({retryCount:0,execTimeout:1000,success:function(){
			DCrypto.convertWrapSeedList(handle, serverPublicKey, wrapSeedList, uid, pinNumber);
		}});
		return false;
    };
    _delfinokbtam.deleteKeyPair = function(uid, complete)
    {
		var handle = this.addComplete(complete);
		this.initHandler({retryCount:0,execTimeout:1000,success:function(){
			DCrypto.deleteKeyPair(handle, uid);
		}});
		return false;
    };
    _delfinokbtam.verifyKeyPair = function(uid, complete)
    {
		var handle = this.addComplete(complete);
		this.initHandler({retryCount:0,execTimeout:1000,success:function(){
			DCrypto.verifyKeyPair(handle, uid);
		}});
		return false;
    };    
    _delfinokbtam.makeRoamingData = function(uid, name, pinNumber, complete)
    {
		var handle = this.addComplete(complete);
		this.initHandler({retryCount:0,execTimeout:1000,success:function(){
			DCrypto.makeRoamingData(handle, uid, name, pinNumber);
		}});
		return false;
    }; 
    _delfinokbtam.resolveRoamingData = function(uid, name, pinNumber, roamingData, complete)
    {
		var handle = this.addComplete(complete);
		this.initHandler({retryCount:0,execTimeout:1000,success:function(){
			DCrypto.resolveRoamingData(handle, uid, name, pinNumber, roamingData);
		}});
		return false;
    };
    return _delfinokbtam;
})(jQuery);
