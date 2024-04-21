var globalVariable	= {};

// json 파싱
var printObj = typeof JSON != "undefined" ? JSON.stringify : function(obj) {
	var arr = [];
	$.each(obj, function(key, val) {
		var next = key + ": ";
		next += $.isPlainObject(val) ? printObj(val) : val;
		arr.push( next );
	});
	return "{ " +  arr.join(", ") + " }";
};

//json 파싱
function globalVariableSet(obj) {
	$.each(obj, function(key, val) {
		if(!Array.isArray(val) && key != 'RESULT_MSG' && val != ''){
			globalVariable[key]	= $.isPlainObject(val) ? globalVariableSet(val) : val;
		}
	});
};

//json 파싱
function domDrow(obj) {
	var arr 	= [];
	var next	= '';
	var kNm		= '';

	if(Array.isArray(obj)){
		$.each(obj,function(k,v){
			next	= '<li><span class="link">Array['+k+']</span>';
			next 	+= $.isPlainObject(v) || Array.isArray(v)? domDrow(v) : v;
			next 	+= '</li>';
			arr.push(next);
		});
	}else{
		$.each(obj, function(key, val) {
			kNm			= enCdToKrNm[key];
			kNm			= kNm == null || kNm == '' ? key : kNm;
			next	= '<li><span class="link">'+kNm+"</span> : ";
			next 	+= $.isPlainObject(val) || Array.isArray(val)? domDrow(val) : val;
			next 	+= '</li>';
			arr.push(next);
		});
	}
	return "<ul>"+arr.join("")+"</ul>";
};

// 공통 아작스콜
function cmnAjaxCallFn(pramData){
	$.ajax({
		url			: pramData.url
		,data 		: JSON.stringify(pramData.data)
		,type		: "POST"
		,async		: false
		,dataType	: pramData.dataType
		,contentType: "application/json"
		//,contentType: "application/x-www-form-urlencoded; charset=UTF-8"
		,success	: function(data){
			if(data != null){
				pramData.success(data);
			}else{
				pramData.error();
			}
		}
		,error		: function(xhr, status, error){
			pramData.error(xhr, status, error);
		}
		,beforeSend : pramData.beforeSend
		,complete	: pramData.complete
	});
}

function convertJSON(data){
	var ret=null;
	if(typeof data =='object'){
		ret= data;
	}else{
		try{ret=jQuery.parseJSON(data);}catch(e){}
	}
	chkJSONNull(ret);
	return ret;
}



// 폼 생성 이벤트
function formMake(pramData){
	var defaultsOTP	= {
		'formId'	: 'tempForm'
		,'action'	: ''
		,'target'	: ''
		,'parent'	: 'body'
		,'input'	: {'defaultInput':''}
		,'submit'	: true
	};
	pramData = $.extend({}, defaultsOTP, pramData);
	$('#'+pramData.formId).remove();
	var $form	= $('<form>').attr({'id':pramData.formId,'method':'post','action':pramData.action}).appendTo(pramData.parent);
	if(pramData.target != ''){
		$form.attr('target',pramData.target);
	}
	inputMake({'input':pramData.input,'form':$form});
	if(pramData.submit && pramData.action != ''){
		$form.submit();
		setTimeout(function(){$form.remove()}, 100);
	}

	/* 예시
	formMake({
		'formId'	: 'tempForm'					// default:'tempForm'
		,'action'	: ''							// default:''
		,'target'	: ''							// default:''
		,'parent'	: 'body'						// default:body
		,'input'	: {'key1':'val1','key2':'val2'}	// default:{'defaultInput':''}
		,'submit'	: false							// default:true
	});
	*/
}


// 인풋 생성 이벤트
function inputMake(pramData){
	var $input;
	$.each(pramData.input,function(k,v){
		if(pramData.form.find('input').is('[name="'+k+'"]')){
			pramData.form.find('input[name="'+k+'"]').val(v);
		}else{
			$input	= $('<input type="hidden">').appendTo(pramData.form);
			$input.attr('name',k);
			$input.val(v);
		}
	});

	/* 예시
	inputMake({
		'input'	: {'key1':'val1','key2':'val2'}
		,'form'	: $('#cForm')
	});
	 */
}



