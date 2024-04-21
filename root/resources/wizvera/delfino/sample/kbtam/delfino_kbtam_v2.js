/**
 * KB 계좌통합 사용자 인터페이스
 * @version 1.0.0.1
 * @since 2016. 08. 23.
 */

DelfinoConfig.useRecentModule = false;
Delfino.setModule("G3");
DelfinoConfig.module_kbtam = Delfino.getModule();
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



Delfino.setModule("G4");
// DelfinoConfig.g4.enablePreload = DelfinoConfig.g5.enablePreload = DelfinoConfig.cg.enablePreload = true;
DCrypto.listCertStore = function(type, complete) {
	Delfino4Html.listCertStore(type, function(result) {
		complete(result);
	});
};
DCrypto.listCertInfo = function(handle, type, name, options) {
	Delfino4Html.listCertInfo(type, name, options, function(result) {
		Delfino_complete(handle, result);
	});
};
DCrypto.deleteKeyPair = function(handle, uid) {
	Delfino4Html.deleteKeyPair(uid, function(result) {
		Delfino_complete(handle, result);
	});
};
DCrypto.verifyKeyPair = function(handle, uid) {
	Delfino4Html.verifyKeyPair(uid, function(result) {
		Delfino_complete(handle, result);
	});
};
DCrypto.issueKeyPair = function(handle, uid, name, pinNumber) {
	Delfino4Html.issueKeyPair(uid, name, pinNumber, function(result) {
		Delfino_complete(handle, result);
	});
};
DCrypto.envelop = function(handle, data, uid, dataType, userPublicKey) {
	Delfino4Html.envelop(data, uid, dataType, userPublicKey, function(result) {
		Delfino_complete(handle, result);
	});
};
DCrypto.convertWrapSeedList = function(handle, serverPublicKey, wrapSeedList, uid, pinNumber) {
	Delfino4Html.convertWrapSeedList(serverPublicKey, wrapSeedList, uid, pinNumber, function(result) {
		Delfino_complete(handle, result);
	});
};
DCrypto.makeRoamingData = function(handle, uid, name, pinNumber) {
	Delfino4Html.makeRoamingData(uid, name, pinNumber, function(result) {
		Delfino_complete(handle, result);
	});
};
DCrypto.resolveRoamingData = function(handle, uid, name, pinNumber, roamingData) {
	Delfino4Html.resolveRoamingData(uid, name, pinNumber, roamingData, function(result) {
		Delfino_complete(handle, result);
	});
};

Delfino4Html.listCertStore = function(type, done) {
	this.service("listCertStore", {type: type}, done);
};
Delfino4Html.listCertInfo = function(type, name, options, done) {
	this.service("listCertInfo", {type: type, name: name, options: options}, done);
};
Delfino4Html.deleteKeyPair = function(uid, done) {
	this.service("deleteKeyPair", {uid: uid}, done);
};
Delfino4Html.verifyKeyPair = function(uid, done) {
	this.service("verifyKeyPair", {uid: uid}, done);
};
Delfino4Html.issueKeyPair = function(uid, name, pinNumber, done) {
	this.service("issueKeyPair", {uid: uid, name: name, pinNumber: pinNumber}, done);
};
Delfino4Html.envelop = function(data, uid, dataType, userPublicKey, done) {
	this.service("envelop", {data: data, uid: uid, dataType: dataType, userPublicKey: userPublicKey}, done);
};
Delfino4Html.convertWrapSeedList = function(serverPublicKey, wrapSeedList, uid, pinNumber, done) {
	this.service("convertWrapSeedList", {serverPublicKey: serverPublicKey, wrapSeedList: wrapSeedList, uid: uid, pinNumber: pinNumber}, done);
};
Delfino4Html.makeRoamingData = function(uid, name, pinNumber, done) {
	this.service("makeRoamingData", {uid: uid, name: name, pinNumber: pinNumber}, done);
};
Delfino4Html.resolveRoamingData = function(uid, name, pinNumber, roamingData, done) {
	this.service("resolveRoamingData", {uid: uid, name: name, pinNumber: pinNumber, roamingData: roamingData}, done);
};


var DelfinoKbtam = DelfinoKbtam || (function(jQuery){
    var _delfinokbtamG4 = window.Delfino;

    _delfinokbtamG4.listCertStore = function(complete){
        DCrypto.listCertStore(0, complete);
		return false;
    };
	_delfinokbtamG4.listCertInfo = function(drive, options, complete)
    {
		options = options || {};
		options.resetCertificate = true;
		var handle = this.addComplete(complete);
		DCrypto.listCertInfo(handle, 0, drive, options);
		return false;
    };
    _delfinokbtamG4.issueKeyPair = function(uid, name, pinNumber, complete)
    {
		var handle = this.addComplete(complete);
		DCrypto.issueKeyPair(handle, uid, name, pinNumber);
		return false;
    };
    _delfinokbtamG4.envelop = function(data, uid, dataType, userPublicKey, complete)
    {
		var handle = this.addComplete(complete);
		DCrypto.envelop(handle, data, uid, dataType, userPublicKey);
		return false;
    };
    _delfinokbtamG4.convertWrapSeedList = function(serverPublicKey, wrapSeedList, uid, pinNumber, complete)
    {
		var handle = this.addComplete(complete);
		DCrypto.convertWrapSeedList(handle, serverPublicKey, wrapSeedList, uid, pinNumber);
		return false;
    };
    _delfinokbtamG4.deleteKeyPair = function(uid, complete)
    {
		var handle = this.addComplete(complete);
		DCrypto.deleteKeyPair(handle, uid);
		return false;
    };
    _delfinokbtamG4.verifyKeyPair = function(uid, complete)
    {
		var handle = this.addComplete(complete);
		DCrypto.verifyKeyPair(handle, uid);
		return false;
    };
    _delfinokbtamG4.makeRoamingData = function(uid, name, pinNumber, complete)
    {
		var handle = this.addComplete(complete);
		DCrypto.makeRoamingData(handle, uid, name, pinNumber);
		return false;
    };
    _delfinokbtamG4.resolveRoamingData = function(uid, name, pinNumber, roamingData, complete)
    {
		var handle = this.addComplete(complete);
		DCrypto.resolveRoamingData(handle, uid, name, pinNumber, roamingData);
		return false;
    };

    Delfino.setModule("G3");
    var _delfinokbtamG3 = window.Delfino;

    _delfinokbtamG3.listCertStore = function(complete){
        this.initHandler({retryCount:0,execTimeout:1000,success:function(){
            DCrypto.listCertStore("2", complete);
        }});
        return false;
    };
    _delfinokbtamG3.listCertInfo = function(drive, options, complete)
    {
        options = options || {};
        options.resetCertificate = true;
        var handle = this.addComplete(complete);
        this.initHandler({retryCount:0,execTimeout:1000,success:function(){
            DCrypto.listCertInfo(handle, "2", drive, JSON.stringify(options));
        }});
        return false;
    };
    _delfinokbtamG3.issueKeyPair = function(uid, name, pinNumber, complete)
    {
        var handle = this.addComplete(complete);
        this.initHandler({retryCount:0,execTimeout:1000,success:function(){
            DCrypto.issueKeyPair(handle, uid, name, pinNumber);
        }});
        return false;
    };
    _delfinokbtamG3.envelop = function(data, uid, dataType, userPublicKey, complete)
    {
        var handle = this.addComplete(complete);
        this.initHandler({retryCount:0,execTimeout:1000,success:function(){
            DCrypto.envelop(handle, data, uid, dataType, userPublicKey);
        }});
        return false;
    };
    _delfinokbtamG3.convertWrapSeedList = function(serverPublicKey, wrapSeedList, uid, pinNumber, complete)
    {
        var handle = this.addComplete(complete);
        this.initHandler({retryCount:0,execTimeout:1000,success:function(){
            DCrypto.convertWrapSeedList(handle, serverPublicKey, wrapSeedList, uid, pinNumber);
        }});
        return false;
    };
    _delfinokbtamG3.deleteKeyPair = function(uid, complete)
    {
        var handle = this.addComplete(complete);
        this.initHandler({retryCount:0,execTimeout:1000,success:function(){
            DCrypto.deleteKeyPair(handle, uid);
        }});
        return false;
    };
    _delfinokbtamG3.verifyKeyPair = function(uid, complete)
    {
        var handle = this.addComplete(complete);
        this.initHandler({retryCount:0,execTimeout:1000,success:function(){
            DCrypto.verifyKeyPair(handle, uid);
        }});
        return false;
    };
    _delfinokbtamG3.makeRoamingData = function(uid, name, pinNumber, complete)
    {
        var handle = this.addComplete(complete);
        this.initHandler({retryCount:0,execTimeout:1000,success:function(){
            DCrypto.makeRoamingData(handle, uid, name, pinNumber);
        }});
        return false;
    };
    _delfinokbtamG3.resolveRoamingData = function(uid, name, pinNumber, roamingData, complete)
    {
        var handle = this.addComplete(complete);
        this.initHandler({retryCount:0,execTimeout:1000,success:function(){
            DCrypto.resolveRoamingData(handle, uid, name, pinNumber, roamingData);
        }});
        return false;
    };
    
    Delfino.setModule(DelfinoConfig.module_kbtam);
    if (Delfino.getModule() != "G10" && Delfino.getModule() != "G4" && Delfino.getModule() != "G3" && !DC_platformInfo.Mobile) Delfino.setModule("G3");
    
    if (Delfino.getModule() == "G3" && !DC_platformInfo.Mobile) {
        return _delfinokbtamG3;
    } else {
        Delfino.setModule("G10");
        return _delfinokbtamG4;
    }
    
    /*
    if (DC_platformInfo.Mobile) {
        Delfino.setModule('G4');
        return _delfinokbtamG4;
    } else {
        Delfino.setModule("G3");
        return _delfinokbtamG3;
    } */
})(jQuery);
