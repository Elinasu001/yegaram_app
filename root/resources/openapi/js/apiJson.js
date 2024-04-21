var apiInputData	= {
	'API_TrnSctrResv0300'	: {	  //예약이체등록
		'BT_NAME'	: 'API_TrnSctrResv0300',
		'PARAMS'	: {
			'JEX_BANKCODE': '101',
			'USER_ID_12'  : 'tlswlgns01',
			'WTCH_ACCO'   : '10161130045421',
			'ACCO_PWD'    : '1004',
			'IN_CNT'      : '1',
			'IN_REC'      : [
			                  {
			                    'TRNF_DSGT_DT'  : '20200810',
			                    'MNRC_BANK'     : '101',
			                    'MNRC_ACCO'     : '10161130007560',
			                    'AMT'           : '1234569',
			                    'RQPS_NM'       : '홍승승',
			                    'RECV_NM'       : '홍오성',
			                    'ACCO_FLAG'     : 'K',        // J:자주쓰는 입금계좌(계정계에서 검증함), K:그냥입력
			                    'WTCH_BNKB_MRK' : '홍오성',
			                    'CHK_ACCO_FLAG' : 'D'
			                  }
//			                  ,
//			                  {
//				                    'TRNF_DSGT_DT'  : '20200110',
//				                    'MNRC_BANK'     : '262',
//				                    'MNRC_ACCO'     : '2187539105',
//				                    'AMT'           : '69000',
//				                    'RQPS_NM'       : '나야나',
//				                    'RECV_NM'       : '홍오구',
//				                    'ACCO_FLAG'     : '',
//				                    'WTCH_BNKB_MRK' : 'common',
//				                    'CHK_ACCO_FLAG' : ''
//			                  }
//			                  ,
//			                  {
//				                    'TRNF_DSGT_DT'  : '20200113',
//				                    'MNRC_BANK'     : '262',
//				                    'MNRC_ACCO'     : '2292701211',
//				                    'AMT'           : '1700000',
//				                    'RQPS_NM'       : '나야나',
//				                    'RECV_NM'       : '홍위탁',
//				                    'ACCO_FLAG'     : '',
//				                    'WTCH_BNKB_MRK' : 'stock',
//				                    'CHK_ACCO_FLAG' : ''
//			                  }
//			                  ,
//			                  {
//				                    'TRNF_DSGT_DT'  : '20200114',
//				                    'MNRC_BANK'     : '262',
//				                    'MNRC_ACCO'     : '229271205',
//				                    'AMT'           : '69690',
//				                    'RQPS_NM'       : '홍배배',
//				                    'RECV_NM'       : '홍오성',
//				                    'ACCO_FLAG'     : 'K',        // J:자즈쓰는 입금계좌(계정계에서 검증함), K:그냥입력
//				                    'WTCH_BNKB_MRK' : '홍오성',
//				                    'CHK_ACCO_FLAG' : ''
//				                  }
//				                  ,
//				                  {
//					                    'TRNF_DSGT_DT'  : '20200114',
//					                    'MNRC_BANK'     : '262',
//					                    'MNRC_ACCO'     : '2031584205',
//					                    'AMT'           : '69000',
//					                    'RQPS_NM'       : '나야나',
//					                    'RECV_NM'       : '홍오구',
//					                    'ACCO_FLAG'     : '',
//					                    'WTCH_BNKB_MRK' : 'common',
//					                    'CHK_ACCO_FLAG' : ''
//				                  }
//				                  ,
//				                  {
//					                    'TRNF_DSGT_DT'  : '20200114',
//					                    'MNRC_BANK'     : '262',
//					                    'MNRC_ACCO'     : '2292701211',
//					                    'AMT'           : '1700000',
//					                    'RQPS_NM'       : '나야나',
//					                    'RECV_NM'       : '홍위탁',
//					                    'ACCO_FLAG'     : '',
//					                    'WTCH_BNKB_MRK' : 'stock',
//					                    'CHK_ACCO_FLAG' : ''
//				                  }
//				                  ,
//				                  {
//					                    'TRNF_DSGT_DT'  : '20200115',
//					                    'MNRC_BANK'     : '262',
//					                    'MNRC_ACCO'     : '2292701211',
//					                    'AMT'           : '1700000',
//					                    'RQPS_NM'       : '나야나',
//					                    'RECV_NM'       : '홍위탁',
//					                    'ACCO_FLAG'     : '',
//					                    'WTCH_BNKB_MRK' : 'stock',
//					                    'CHK_ACCO_FLAG' : ''
//				                  }
//				                  ,
//				                  {
//					                    'TRNF_DSGT_DT'  : '20200115',
//					                    'MNRC_BANK'     : '262',
//					                    'MNRC_ACCO'     : '229271205',
//					                    'AMT'           : '69690',
//					                    'RQPS_NM'       : '홍배배',
//					                    'RECV_NM'       : '홍오성',
//					                    'ACCO_FLAG'     : 'K',        // J:자즈쓰는 입금계좌(계정계에서 검증함), K:그냥입력
//					                    'WTCH_BNKB_MRK' : '홍오성',
//					                    'CHK_ACCO_FLAG' : ''
//					                  }
//					                  ,
//					                  {
//						                    'TRNF_DSGT_DT'  : '20200115',
//						                    'MNRC_BANK'     : '262',
//						                    'MNRC_ACCO'     : '2031584205',
//						                    'AMT'           : '69000',
//						                    'RQPS_NM'       : '나야나',
//						                    'RECV_NM'       : '홍오구',
//						                    'ACCO_FLAG'     : '',
//						                    'WTCH_BNKB_MRK' : 'common',
//						                    'CHK_ACCO_FLAG' : ''
//					                  }
//					                  ,
//					                  {
//						                    'TRNF_DSGT_DT'  : '20200115',
//						                    'MNRC_BANK'     : '262',
//						                    'MNRC_ACCO'     : '2292701211',
//						                    'AMT'           : '1700000',
//						                    'RQPS_NM'       : '나야나',
//						                    'RECV_NM'       : '홍위탁',
//						                    'ACCO_FLAG'     : '',
//						                    'WTCH_BNKB_MRK' : 'stock',
//						                    'CHK_ACCO_FLAG' : ''
//					                  }
			                ],
			'USR_ID_12'   : 'tlswlgns01',
			'TRTM_DVCD'   : '1',    // 1.등록 - 고정
			'MNRC_BANK'   : '101',
			'MNRC_ACCO'   : '10161130007560',
			'DEPR_NM_20'  : '홍오별',
			'ALS'         : 'FiveSTAR'  //'홍오성'   // 먼저 공란으로 테스트 - 체크여부
		}
	}
	,'API_TrnSctrRevo0300'	: {	// 예약이체등록취소
		'BT_NAME'	: 'API_TrnSctrRevo0300',
		'PARAMS'	: {
			'JEX_BANKCODE'	   :'101',
			'USR_ID_12'        : 'hsb9121',
			'RESR_TRNF_DT'     : '20200106',       // 틀린 입력 시 ECB00003,타행예약지연이체기본 오류입니다. 당일분도 취소 가능.(미실행 시에만 그럴 듯)
			'SEQ_6'            : '2',
			'WTCH_WB_ACNO_16'  : '10161130096256', // 틀린 입력 시 ECB00003,타행예약지연이체기본 오류입니다
			'MNRC_BKCD'        : '262',
			'MNRC_WB_ACNO_16'  : '2187539105',     // 틀린 입력 시 ECB00003,타행예약지연이체기본 오류입니다
			'MNRC_AMT_14'      : '80000',          // 틀린 입력 시 ECB00003,타행예약지연이체기본 오류입니다
			'WDPS_NM_20'       : '홍승배',     // 필수 - 텍스트 비교는 안함
			'RECV_NM_20'       : '홍오별'      // 필수 - 상동
		}
	}
	,'API_TrnMulpMutr0100'	: {	// 예약이체등록내역조회
		'BT_NAME'	: 'API_TrnMulpMutr0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'USER_ID_12'	:'hsb9121',      // 'hsb9121'
			'INQ_STDT'		:'20190701',
			'INQ_EDDT'		:'20200120',
			'SLCT_PAGE_CNT' : '1',
			'INQ_FLAG'		: '1'  // 1.예약등록내역 , 2.예약처리내역
		}
	}
	,'API_LogLogn0100_01'	: {	// ID/PW 로그인
		'BT_NAME'	: 'API_LogLogn0100_01',
		'PARAMS'	: {
			'USER_ID_12'	:'george75',      // 'hsb9121'
			'USR_PWD'		:'test3978!!',    // 'hong__0173',
			'JEX_BANKCODE'	:'101'
			//'REC'			:[{'BANK_CD':'101','USER_ID':'soonlhh21'}]
		}
	}
	,'API_LogLogn0100_02'	: {	// 공인증서 로그인
		'BT_NAME'	: 'API_LogLogn0100_02',
		'PARAMS'	: {
			'USER_ID_12'	:'hsb9121',      //'soonlhh31',
			'JEX_BANKCODE'	:'101'           //'101'
		}
	}
	,'API_LogLogn0100_03'	: {	// 로그인공통처리
		'BT_NAME'	: 'API_LogLogn0100_03',
		'PARAMS'	: {
   			'JEX_BANKCODE'		:'101',
			'INPT_DVCD'			:'1',
			'USER_ID_12'		:'kmj573',
			'INPT_DVCD_2'		:'01',
			'CSNO'				:'10104850450',
			'TRN_DVCD'			:'04',
			'INQ_KND_2'			:'02',
			'RNNO'				:'9001091209212',
			'STCD'				:'1',
			'MGR_NO'			:'9001',
			'SMT_BNK_YN'		:'N',
			'USER_ID'			:'kmj573',
			'CSNO_INQ'			:'10104850450',
			'BANKCODE'			:'101',
			'SBCD'				:'101',
			'SECU_MEDI_DVCD'	:'O',
			'OTP_VNDR_CD'		:'001',
			'SVBN_BOCD'			:'01',
			'INDV_CORP_DSTC_CD'	:'1'
		}
	}
	,'API_LogLogn0100_04'	: {	// 로그인세션 TTL연장/최초로그인체크
		'BT_NAME'	: 'API_LogLogn0100_04',
		'PARAMS'	: {
	         'SESSIONID'	      :'101Pvz3pD6C6Xo0JICVI1bTm9FI96iadoB6wskixhV5pQ4KemuiyxjkjtIzGxte51q3.ZGJzX2RkYnNhL2RzYnNwMTE=',
	         'FROMIP'	          :'223.1.1.9',
	         'FROMPORT'           :'443',
	         'DEVICETYPE'         :'M',
//	         'LOGINTIME'          :'curtime',
	         'USERID'			  :'hsb9121',    //'george75',
	         'BANKCODE'           :'101',
	         'TYPE'               :'insert'     //'select'
         }
	}
	,'API_ComLgcd0101_01'	: {	// 로그인시약관동의
		'BT_NAME'	: 'API_ComLgcd0101_01',
		'PARAMS'	: {
			'USER_ID_12'			:'soonlhh31',
			'ELFN_STPL_AGR_YN'		:'1',
			'CSNO'					:'10104848666',
			'CRIF_MRKN_COLT_UZ_MTR'	:'01',
			'CRIF_MRKN_OFR_MTR'		:'01',
			'SMS_YN'				:'Y',
			'EMAIL_YN'				:'Y',
			'TEL_YN'				:'Y',
			'DM_YN'					:'Y',
			'CRIF_MRKN_ALL_MTR'		:'Y',
			'JEX_BANKCODE'			:'101'
		}
	}
	,'API_LogLogn0200_01'	: {	// 로그아웃
		'BT_NAME'	: 'API_LogLogn0200_01',
		'PARAMS'	: {
			'USERID'	:'hsb9121',   //'soonlhh31',
			'SESSIONID'	:'101Pvz3pD6C6Xo0JICVI1bTm9FI96iadoB6wskixhV5pQ4KemuiyxjkjtIzGxte51q3.ZGJzX2RkYnNhL2RzYnNwMTE='
		}
	}
	,'API_ComFdsUtil'	: {	// FDS연계
		'BT_NAME'	: 'API_ComFdsUtil',
		'PARAMS'	: {
			'INCA_DTO_STR'	:'',
			'USER_ID_12':'test111',
			'CHANNEL'	:'AP',
			'UUID1'		:'',
			'UUID2'		:''
		}
	}
	,'API_PA_TokenIssue'	: {	// 사설인증토큰발급
		'BT_NAME'	: 'API_PA_TokenIssue',
		'PARAMS'	: {
			'TYPE'	:'D',
			'BKCD'	:'101',
			'CSNO'	:'10101284797',
			'KND'	:'10101284797',
			'UUID'	:'ffffffff-d76a-ec2d-3430-2b84745ebe65'
		}
	}
	,'API_PA_TxCreate'	: {	// 사설인증랜덤발급요청
		'BT_NAME'	: 'API_PA_TxCreate',
		'PARAMS'	: {}
	}
	,'API_PA_TxSign'	: {	// 사설인증서명검증
		'BT_NAME'	: 'API_PA_TxSign',
		'PARAMS'	: {
			'JEX_BANKCODE'  :  '049',
			'BKCD'		:'049',
			'ID'		:'8553d7cec0b03c44b0ecb7c657df884f3b0b09e3',
			'SIG'		:'4144242450243034396861313731373135612331312f3034393a38666637353261343330333138303838316266366132623963636265336539393135333630343733fff3836d0ce738f0a09633bd66dc6f4ddb326fcd86e3afeb8b6212c43878ab33472b3d46d514237408589915a3e979f0db73f06c33af0bdf6e8052fd1828904f3a4b01e6cc624716a70abf8abd640997b52afbc42d973714d4e5e1b150889ed52ecf63b59592ef733476c6c50648cfdb05b40cca1f59d9852403cf3950ba7d59e8a08c5db3218bc376ecfc3e58854728b755a600da8a25970286b9d93c9965ec3cb5a5096b1c212e0cad6e09ad8451d9cf404b0715ce15718dd010a9b63e5dc45c819c9e3dfe9d0b8cf21dae4f319b6f9c9fd7c7af7480b8d2082ff49002ff2a9fef4d7edee7c42206de73dc592d61ecae09d1e42974437d35505cbb8fb5f567046e756c6cc006e97fc66dc9d443d23e489613d7f87b653e48d8e61920bb4851aeda005ec2f36327491b18fa73bea745b086d1dbaa5cf0fcb35509c01af40a462e762e394acece11c6448eaa5a653bdc746a90fb3b388201b8576008b58a8d9bdc884b283f7a0678b3d3de674a00f40d302529e62bff925cc3aa4453cd8637407c273434d2c3f5f55471422dd02bbb6642717598d63c7b2a339ed013276f860da3c11aae0d793285e584101dbb5c1e320d5dc1ae7b713f7c005b82eb5226191d938579948a6f45d2dfa444e6a223a7f17e529f724675199fe5486ed36464226f87476c712f1c3ef5a656eacc1b47e7cb6119452e56b799d7bfe700b81dda77af053e45191f0b602f0d33a9a74debc0d718aef4aef963159a9fea0be3178c53b8856c9bc91550e30820d703809b1f4b4c25398971e6a612636f324f1fb4fa26f4ac7794973edcc178db01d308970c62ce38ab7d783a52b2bf06ccaa9e4ba4598f5fb09fe8857a88d512e2770774ccf93b340d0f53f6f4ee5881c13770f31ecef4e6ab00a924885b75a5ebfbca1b20cd2b93df668359bb9d4a3b8aa21d4fe471a25a039e70f5fb4e0002',
			'MSG'		:'1588571380296',
			'OTP_LEN'	:'0',
			'PA_TRN_TYPE'  :  '2',
			'USR_ID'       :  ''
		}
	}
	,'API_comCert0100_02'	: {	// 공인인증서정보조회
		'BT_NAME'	: 'API_comCert0100_02',
		'PARAMS'	: {
			'BANK_CD'			:'101',
			'JEX_BANKCODE'		:'101',
			'CERT_SERIAL'		:'629899657',
			'DN'				:'cn=홍승배()0020040200507157209785,ou=WOORI,ou=personal4IB,o=yessign,c=kr'
		}
	}
	,'API_comCert0100_07'	: {	// 공인인증서서명검증
		'BT_NAME'	: 'API_comCert0100_07',
		'PARAMS'	: {
 			'BANK_CD'			:'101',
			'JEX_BANKCODE'		:'101',
			'CERT_SERIAL'		:'629899657',  //'528291',
			'DN'				:'cn=홍승배()0020040200507157209785,ou=WOORI,ou=personal4IB,o=yessign,c=kr',  //'cn=이학현29,ou=테스트지점,ou=테스트회사,ou=테스트업종,o=SignKorea,c=KR',
		}
	}
	,'API_CerIssu0210'	: {	// 공인인증서조회
		'BT_NAME'	: 'API_CerIssu0210',
		'PARAMS'	: {
  			'BANK_CD'			:'101',  //'101',
			'JEX_BANKCODE'		:'101',  //'101',
			'USER_ID'			:'soonlhh31',  //'hsb9121',  //'soonlhh31',
			'DN'				:'cn=이학현29,ou=테스트지점,ou=테스트회사,ou=테스트업종,o=SignKorea,c=KR',  //'cn=홍승배()0020040200507157209785,ou=WOORI,ou=personal4IB,o=yessign,c=kr',
			'CERT_SERIAL'		:'528291',  // '629899657',  //'528291',
			'STCD'				:''
		}
	}
	,'API_SeuOotp0200_01'	: {	// OTP온라인타기관등록
		'BT_NAME'	: 'API_SeuOotp0200_01',
		'PARAMS'	: {
		    'JEX_BANKCODE'	:'101',
		    'USER_ID_12'	:'soonlhh11',
		    'RRNO'			:'3511011111121',
		    'SECU_MEDI'		:'M',
		    'OOBK_DVCD'		:'',
		    'OTP_VNDR_CD1'	:'001',
		    'OTP_SRNO1'		:'754990478',
		    'OTP_VNDR_CD2'	:'001',
		    'OTP_SRNO2'		:'754990478'
		}
	}
	,'API_CerIssu0200_01'	: {	// 공인인증서본인확인
		'BT_NAME'	: 'API_CerIssu0200_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',  //'101',
			'USER_ID'		:'hsb9121',  //'kinglst11',
			'PSWD_700'		:'hong__0173',
			'NRBRNO_INQ'	:'1012201403216',
			'ATSH_KNCD'		:'3',
			'RLTR_YN'		:'1'    // 1.전조회, 2.실거래
//			'KTB_UUID'		:'f8c3243b-5'
		}
	}
	,'API_CerIssu0200'	: {	// 공인인증서 등록
		'BT_NAME'	: 'API_CerIssu0200',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'SBCD'			:'101',
			'MESG_DVCD'		:'6',     // 1.발급,재발급, 2.검증, update - 이용자ID, 은행코드, DN에 해당하는 인증서 시리얼값 update
			                          // 3.갱신, update, 4.폐기, update - 이용자ID, 은행코드, DN에 해당하는 인증서 시리얼값 update
			                          // 5. 타기관인증서 등록 , 6. 타기관인증서 해지, update - 이용자ID, 은행코드, DN에 해당하는 공인인증서 상태코드 update
			'CNT_N2'		:'1',
			'REC'			:[
				{
					'BANK_CD'		:'101',
					'SBCD'			:'101',
					'USER_ID'		:'hsb9121',
					'DN'			:'cn=홍승배()0020040200507157209785,ou=WOORI,ou=personal4IB,o=yessign,c=kr',
					'OOBK_DIV'		:'2',          // 1.당행, 2.타행
					'STCD'			:'5',          // MESG_DVCD=6(타기관인증서 해지)시에는 5.미등록,  MESG_DVCD=5(타기관인증서 등록)시에는 0.유효
					'CERT_KIND'		:'SPB',
					'CUST_NM'		:'홍승배',
					'FARE_PAY_CD'	:'ETC',
					'CERT_ORG_CD'	:'04',
					'CERT_PLCY_ID'	:'',
					'CERT_SERIAL'	:'629899657',
					'REFNO'			:'',   //'428724',
					'AUTH_CODE'		:'',   // '63758598096527692673',
					'CSNO'			:'',
					'EMAD'			:''
				}
			]
		}
	}
	,'API_comSecu0200_02'	: {	// OTP인증요청
		'BT_NAME'	: 'API_comSecu0200_02',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'MESG_LEN'			:'134',
			'MESG_CLSC_CD'		:'0200',
			'MESG_DVCD'			:'200101',
			'BKCD'				:'101',
			'BO_NO'				:'1',
			'RRNO'				:'5238100012',
			'INDV_CORP_DSTC'	:'SCB',
			'RESP_CD'			:'',
			'TNRC_DSTC'			:'',
			'OTP_VNDR_CD1'		:'001',
			'OTP_SRNO1'			:'99209009',
			'OTP_VNDR_CD2'		:null,
			'OTP_SRNO2'			:null,
			'OTP_OTPT_VAL1'		:'985785',
			'OTP_OTPT_VAL2'		:null,
			'TX_KND'			:null,
			'GBPR_LMTD_DSTC'	:null,
			'UZ_REG_YN'			:null,
			'UZ_REG_INSTCD'		:null,
			'ERR_NTM'			:null,
			'GRNY_TERM_STDT'	:null,
			'GRNY_TERM_EDDT'	:null,
			'LCKN_RESP_VAL'		:null
		}
	}
	,'API_SeuOtprOtps0100'	: {	// OTP보정요청
		'BT_NAME'	: 'API_SeuOtprOtps0100',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'MESG_LEN'			:'0134',
			'MESG_CLSC_CD'		:'0200',
			'MESG_DVCD'			:'200401',
			'BKCD'				:'050',
			'BO_NO'				:'06',
			'RRNO'				:'3511011111121',
			'INDV_CORP_DSTC'	:'1',
			'RESP_CD'			:null,
			'TNRC_DSTC'			:'1',
			'OTP_VNDR_CD1'		:'001',
			'OTP_SRNO1'			:'754990478',
			'OTP_VNDR_CD2'		:null,
			'OTP_SRNO2'			:null,
			'OTP_OTPT_VAL1'		:'949437',
			'OTP_OTPT_VAL2'		:null,
			'TX_KND'			:'01',
			'GBPR_LMTD_DSTC'	:null,
			'UZ_REG_YN'			:null,
			'UZ_REG_INSTCD'		:null,
			'ERR_NTM'			:null,
			'GRNY_TERM_STDT'	:null,
			'GRNY_TERM_EDDT'	:null,
			'LCKN_RESP_VAL'		:null
		}
	}
	,'API_IbaDrcl0200_01'	: {	// 고객OTP정보조회
		'BT_NAME'	: 'API_IbaDrcl0200_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'USR_ID_12'			:'george75',
			'PROC_FLAG'			:'I',
			'RRNO'				:'7808152292933',
			'WTCH_ACNO'			:'10101130336529',
			'WTCH_ACCO_C700'	:''
		}
	}
	,'API_SeuOotp0100_02'	: {	// 고객별OTP원장조회
		'BT_NAME'	: 'API_SeuOotp0100_02',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'MESG_LEN'			:'099',
			'MESG_CLSC_CD'		:'1000',
			'MESG_DVCD'			:'100001',
			'BKCD'				:'101',
			'BO_NO'				:'01',
			'RRNO'				:'5903262218335',
			'INDV_CORP_DSTC'	:'1',
			'RESP_CD'			:null,
			'TNRC_DSTC'			:null,
			'REQT_STRN_LOC'		:'001',
			'WHL_CNT'			:null,
			'CNT_N2'			:null,
			'REC'				:null
		}
	}
	,'API_SeuOotp0100_03'	: {	// OTP기기별이용등록기관내역조회
		'BT_NAME'	: 'API_SeuOotp0100_03',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'MESG_LEN'			:'099',
			'MESG_CLSC_CD'		:'0200',
			'MESG_DVCD'			:'200504',
			'BKCD'				:'101',
			'BO_NO'				:'06',
			'RRNO'				:'3511011111121',
			'INDV_CORP_DSTC'	:'1',
			'RESP_CD'			:null,
			'TNRC_DSTC'			:null,
			'OTP_VNDR_CD2'		:'001',
			'OTP_SRNO2'			:'754990479',
			'OTP_STCD'			:null,
			'TRN_DT_FROM'		:'20010101',
			'TRN_DT_TO'			:'20990101',
			'REQT_STRN_LOC'		:'001',
			'WHL_CNT'			:null,
			'CNT_N2'			:null,
			'REC'				:null
		}
	}
	,'API_comSecu0200_03'	: {	// OTP거래인증
		'BT_NAME'	: 'API_comSecu0200_03',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'MESG_LEN'			:'198',
			'MESG_CLSC_CD'		:'0200',
			'MESG_DVCD'			:'200102',
			'BKCD'				:'101',
			'BO_NO'				:'06',
			'RRNO'				:'3511011111121',
			'INDV_CORP_DSTC'	:'1',
			'RESP_CD'			:'',
			'TNRC_DSTC'			:'',
			'OTP_VNDR_CD1'		:'001',
			'OTP_SRNO1'			:'754990479',
			'OTP_VNDR_CD2'		:null,
			'OTP_SRNO2'			:null,
			'OTP_OTPT_VAL1'		:'433165',
			'OTP_OTPT_VAL2'		:null,
			'TX_KND'			:null,
			'GBPR_LMTD_DSTC'	:null,
			'UZ_REG_YN'			:null,
			'UZ_REG_INSTCD'		:null,
			'ERR_NTM'			:null,
			'GRNY_TERM_STDT'	:null,
			'GRNY_TERM_EDDT'	:null,
			'LCKN_RESP_VAL'		:null,
			'TRN_INFO_HASH_VAL'	:'D0429CFF929F8C0EE9A2F2A446DC4324E84AE08D07BBCBBF64D4C6AC21A03FA7'
		}
	}
	,'API_comSecu0200_01'	: {	// OTP일회용PIN요청/응답
		'BT_NAME'	: 'API_comSecu0200_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'MESG_LEN'			:'150',
			'MESG_CLSC_CD'		:'0200',
			'MESG_DVCD'			:'200107',
			'BKCD'				:'101',
			'BO_NO'				:'01',
			'RRNO'				:'9311041234567',
			'INDV_CORP_DSTC'	:'1',
			'RESP_CD'			:'',
			'TNRC_DSTC'			:'',
			'OTP_VNDR_CD1'		:'301',
			'OTP_SRNO1'			:'99019837',
			'OPIN_NO'			:'',
			'PIN_RESP'			:'',
			'TRN_INFO_HASH_VAL'	:'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855',
			'USG_DVCD'			:''
		}
	}
	,'API_comSecu0200_04'	: {	// OTP거래정보전송
		'BT_NAME'	: 'API_comSecu0200_04',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'012',
			'MESG_CLSC_CD'		:'0200',
			'RESP_CD'			:'',
			'TRN_INFO'			:'1569907857176',
			'RRNO'				:'9110281216212',
			'MESG_DVCD'			:'200108',
			'TNRC_DSTC'			:'',
			'TRN_INFO_YN'		:'1',
			'TRN_INFO_HASH_VAL'	:'3944D939F0CE368038B73E960F3873501E153D2F49A6161D814A15666D078E01',
			'OTP_VNDR_CD1'		:'301',
			'BO_NO'				:'1',
			'BKCD'				:'012',
			'TRN_INFO_LEN'		:13,
			'INDV_CORP_DSTC'	:'1',
			'OTP_SRNO1'			:'99019839',
			'MESG_LEN'			:'1937'
		}
	}
	,'API_comSecu0200_05'	: {	// OTP기기상세조회
		'BT_NAME'	: 'API_comSecu0200_05',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'MESG_LEN'					:'264',
			'MESG_CLSC_CD'				:'0200',
			'MESG_DVCD'					:'200505',
			'BKCD'						:'101',
			'BO_NO'						:'06',
			'RRNO'						:'3511011111121',
			'INDV_CORP_DSTC'			:'1',
			'RESP_CD'					:null,
			'TNRC_DSTC'					:null,
			'OTP_VNDR_CD1'				:'001',
			'OTP_SRNO1'					:'99209008',
			'INQ_REQT_INSTCD'			:null,
			'GBPR_LMTD_DSTC'			:null,
			'BOCD'						:null,
			'GRNY_TERM_STDT'			:null,
			'GRNY_TERM_EDDT'			:null,
			'OTP_STCD'					:null,
			'ERR_NTM'					:null,
			'LST_ATHN_ERR_DTM'			:null,
			'LST_ERR_OCRN_INSTCD'		:null,
			'OTIN_ACDT_RCVR_YN'			:null,
			'ACDT_APLC_DTM'				:null,
			'UZ_REG_YN'					:null,
			'UZ_REG_DTM'				:null,
			'ISS_FIN_INSTCD'			:null,
			'ISS_DTM'					:null,
			'USER_IDNT_CD'				:null,
			'ADDT_USER_IDNT_CD'			:null,
			'ATMT_REG_DVCD'				:null,
			'OTIN_ATMT_REG_TRGT_CO_CD'	:null,
			'OTIN_ATMT_REG_OTP_SRNO'	:null
		}
	}
	,'API_SeuMotpSett0100'	: {	// mOTP관리
		'BT_NAME'	: 'API_SeuMotpSett0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'TRMN_TRN_DVCD'	:'01',
			'SBCD'			:'101',
			'CSNO'			:'10104848655',
			'TOKEN'			:'6444243331303034383438363535244d2430303030303030302d373431392d363437312d353237662d6436326137386362633934352331332f3331303a34356235636661383532383737353439613333393230643936396166313739643461666566373263c0817a6c5a63486f3d6af08e0b68723a4e3fb888cb67846561ddbdf13c64ee81c6812211a67c6c3abc05a5db10080b8c5f1897310e2ac82c8d43fdf1dfbf4a4ca1a5d2e433ac61ba9b70736d6cfe576c85f8be62e067aa9de8714f960beb8fb81e7cfdcf7c29a5f9fa26181b3d5d464d5490370bdac27d8fb6cc0b5b6cee6fd45112560ce5936372bb49db5df2a6566628164e5613c93e4cc13498bd5aec1f96114b832e455a0cbac678c8143af1fc8be2e6e36af8a6a1edd4289c47b483dd4919e410299e1d279d9589e8b7a2ea6db0d4e65596054957c529e21dc7ec53b740ad8640446941ff37c6d4d10bd5ad09eddb79df9fae4e4d8c8df992621204d9b779210e76d537bbd529e7580da9bba7f21259f8b09f80c29c21f3f5ae9027056c0cf576b5db4aa1a7c65ca484b608a9d36d94b3cce43cb9a84aff16d37ce8da5a2fb6182018519ebc9a64fdb63a1ee0aa37abec3f32cd72a7f89667d35998aba1d73eaf600232eca7fc9989d4af12961cb487cd5dce4f4376aa1545af6089365c3d31c4aa2b4211e904c1f8182114df2fa10530c2dd5f233e5c0d85ea7d37a39972af9b85f117179380314e4a7e40442519d20da2702dbd4ce2cde6aec52ea69d3a4123b93cb3b2a5481a4989710ae4597aa49aee782b7309b5a0ba788eda57b370e21de339c1dfbdd36c774ed45706e1af554d4dce2f8cb872004e5b962ae6e07c08c9af0002'
		}
	}
	,'API_LogIdfn0100_01'	: {	// 사용자ID조회
		'BT_NAME'	: 'API_LogIdfn0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'RNNO'				:'7808150000000',
			'WTCH_ACNO'			:'10101130354565',
			'WTCH_ACCO_C700'	:''
		}
	}
	,'API_CusIqmo0200'	: {	// 고객정보조회
		'BT_NAME'	: 'API_CusIqmo0200',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'PROC_FLAG'		:'01',
			'CSNO'			:'10104838388'
		}
	}
	,'API_CusIqmo0300'	: {	// 고객정보변경
		'BT_NAME'	: 'API_CusIqmo0300',
		'PARAMS'	: {
			'JEX_BANKCODE'					:'101',
			'CSNO'							:'10104851505',
			'DG2_CUST_MNG_CD2'				:'',
			'RPR_PRTB_TVNO'					:'',
			'HHLD_NM'						:'',
			'BZPL_EMPL_CNT'					:'0',
			'IRU_BLDG_MNGNO'				:'',
			'FAX_TSNO'						:'',
			'STLM_MN'						:'',
			'LSTN_YN'						:'',
			'HMPG_URL_ADDR'					:'',
			'ADDR_AREA_CD_NM2'				:'',
			'PSNT_RSDC_BSIC_ADDR'			:'서울 마포구 마포대로 167',
			'ADDR_AREA_CD'					:'*',
			'WHL_ENSN_ADDR'					:'',
			'DM_RTRN_YN'					:'N',
			'FAX_TFNO'						:'',
			'TRN_MTV_DVCD2'					:'',
			'CUST_MNG_CNTN'					:'',
			'SPS_BRDD'						:'',
			'ANL_SALE_AMT'					:'0',
			'RPR_TVNO'						:'',
			'CSNO'							:'10104851505',
			'WRST_DTAD'						:'',
			'EML_RCMS_YN'					:'N',
			'DM_SEND_DVCD'					:'10',
			'MRG_YN'						:'N',
			'SPS_NM'						:'',
			'WRST_ZPCD'						:'',
			'WHL_ENSN_ADDR2'				:'',
			'IRU_BSIC_ADDR'					:'',
			'CHLD_CNT_C2'					:'0',
			'TRN_MTV_DVCD'					:'90',
			'WORK_DEPT_NM'					:'',
			'ADDR_AREA_CD2'					:'',
			'ESNT_HNDL_ARTC_NM'				:'',
			'LCTN_TFNO'						:'',
			'PSNO_C13'						:'',
			'LNSL_DVCD'						:'*',
			'IRU_ZPCD'						:'',
			'HMPG_URL_ADDR2'				:'',
			'IRU_ADDR_LGT_CDN_VAL'			:'',
			'WRST_TFNO'						:'',
			'DG2_CUST_MNG_CD'				:'*',
			'LCTN_TVNO'						:'',
			'FAX_TVNO'						:'',
			'VIP_MSG_CUST_YN2'				:'',
			'SEX_DVCD'						:'1',
			'RPR_TFNO'						:'',
			'BLDG_AR_N21'					:'0.00000',
			'HHLD_NRID_C13'					:'',
			'IRU_REF_ITEM_NM'				:'',
			'WRST_TVNO'						:'',
			'DG1_CUST_MNG_CD'				:'*',
			'CUST_DTH_DT'					:'',
			'CUST_JBTT_CD'					:'*',
			'RPR_TSNO'						:'',
			'IRU_ZPCD_MNGNO'				:'',
			'CHCR_MBR_YN'					:'Y',
			'RPR_NM'						:'',
			'RPR_NRID_C13'					:'',
			'INVPE_YN2'						:'',
			'TOT_FAM_CNT_C2'				:'0',
			'ESTB_DT'						:'',
			'PRTB_TSNO'						:'010',
			'EML_HOLD_YN'					:'N',
			'PSNT_RSDC_REF_ITEM_NM'			:'(공덕동)',
			'WRST_NM'						:'',
			'CUST_CNTA_DVCD'				:'09',
			'LCTN_TSNO'						:'',
			'TTNPR_AMT'						:'0',
			'WRTG_YN'						:'N',
			'WRST_ZPCD_MNGNO'				:'',
			'PSNT_RSDC_ZPCD_MNGNO'			:'',
			'VHCL_CD'						:'*',
			'LSTN_DT'						:'',
			'NTNL_CD'						:'100',
			'TFNO'							:'',
			'DWL_FRMN_CD'					:'*',
			'PSNT_RSDC_BLDG_MNGNO'			:'1144021130010200016700000',
			'VIP_MSG_CUST_YN'				:'N',
			'MNG_CNTN'						:'',
			'IRU_DTAD'						:'',
			'CPTL_AMT'						:'0',
			'WRST_BLDG_MNGNO'				:'',
			'PRTB_TVNO'						:'7417',
			'EML_HOLD_YN2'					:'',
			'WRST_TSNO'						:'',
			'ENTP_SCL_CD'					:'',
			'DG1_CUST_MNG_NM2'				:'',
			'DG2_CUST_MNG_NM2'				:'',
			'ALTALK_RCMS_YN'				:'N',
			'PSNT_RSDC_DTAD'				:'래미안공덕5차 14',
			'TSNO'							:'',
			'PSNT_RSDC_ADDR_LGT_CDN_VAL'	:'',
			'WRST_ADDR_LTT_CDN_VAL'			:'',
			'NTNL_CD2'						:'',
			'SKCR_CD'						:'*',
			'PRTB_TFNO'						:'4560',
			'HSNG_PTRN_DVCD'				:'*',
			'WRST_BSIC_ADDR'				:'',
			'GRND_AR_N21'					:'0.00000',
			'IRU_ADDR_LTT_CDN_VAL'			:'',
			'DM_RTRN_YN2'					:'',
			'DG1_CUST_MNG_CD2'				:'',
			'SMS_RCMS_YN'					:'N',
			'RLGN_CD'						:'*',
			'PSNT_RSDC_ZPCD'				:'04131',
			'OCPT_CD'						:'22241',
			'INVPE_YN'						:'N',
			'RPR_PRTB_TSNO'					:'',
			'CORP_ESTB_PRPS_CNTN'			:'',
			'DG1_CUST_MNG_NM'				:'',
			'CORP_ABRV_NM'					:'',
			'BRDD'							:'19780812',
			'SPS_NRID_C13'					:'',
			'MRG_CMMR_DD'					:'',
			'LVTP_MNBD_DVCD'				:'0',
			'TOT_AST_AMT'					:'0',
			'MAX_SHLD_NM'					:'',
			'TVNO'							:'',
			'EMAD'							:'',
			'WRST_ADDR_REF_ITEM_NM'			:'',
			'VHCL_NO'						:'',
			'ADDR_AREA_CD_NM'				:'',
			'DG2_CUST_MNG_NM'				:'',
			'SIC_CD'						:'',
			'HOBY_CD'						:'*',
			'RPR_PRTB_TFNO'					:'',
			'PSNT_RSDC_ADDR_LTT_CDN_VAL'	:'',
			'WRST_ADDR_LGT_CDN_VAL'			:''
		}
	}
	,'API_LogFupw0100_01'	: {	// 최초 비밀번호 등록
		'BT_NAME'	: 'API_LogFupw0100_01',
		'PARAMS'	: {
	        'JEX_BANKCODE'	:'101',
	        'USER_ID_12'	:'soonlhh31',
	        'RNNO'			:'3511011111139',
	        'FRT_PWD'		:'',
	        'MESG_DSTC'		:'R',
	        'ACHN_PWD'		:''
        }
	}
	,'API_CusPwmo0200'	: {	// 비밀번호 변경
		'BT_NAME'	: 'API_CusPwmo0200',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'ID'			:'soonlhh26',
			'BCHN_PWD'		:'',
			'ACHN_PWD'		:''
		}
	}
	,'API_LogUrpw0200_01'	: {	// 비밀번호분실재등록
		'BT_NAME'	: 'API_LogUrpw0200_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'021',
			'USER_ID_12'	:'qkrtjdgh06',
			'NEW_USR_PWD'	:''
		}
	}
	,'API_LogUrpw0100_01'	: {	// 비밀번호분실재등록 선조회
		'BT_NAME'	: 'API_LogUrpw0100_01',
		'PARAMS'	: {
	        'JEX_BANKCODE'		:'021',
	        'USR_ID_12'			:'qkrtjdgh06',
	        'PROC_FLAG'			:'I',
	        'RRNO'				:'9006131273723',
	        'WTCH_ACNO'			:'02161130021717',
	        'WTCH_ACCO_C700'	:'',
        }
	}
	,'API_SeuDvdeJoin0200_01'	: {	// PC지정서비스가입여부조회
		'BT_NAME'	: 'API_SeuDvdeJoin0200_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'INBN_ID_C12'	:'hsb9121'
		}
	}
	,'API_SeuAdsvJoin0200_01'	: {	// 추가인증서비스가입  //고객정보
		'BT_NAME'	: 'API_SeuAdsvJoin0200_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'PROP_TLNO'			:'',
			'STS'				:'1',
			'ADDT_ATHN_MTH'		:'10',
			'INBN_ID_C12'		:'hsb9121',
			'ATHN_TRGT'			:'30'
		}
	}
	,'API_SeuDvdeJoin0200_02'	: {	// PC지정서비스가입
		'BT_NAME'	: 'API_SeuDvdeJoin0200_02',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'TMNL_NNM'			:'마이포코',
			'TMNL_TYPE'			:'21',            // 단말기 장치타입.  10:PC , 20:모바일, 고정값 : "20"
			'OS_ID'				:'Androiddd',
			'CPU_ID'			:'pocopocopopoco',
			'PC_DSGT_APL_TRGT'	:'30',
			'HDD_ID'			:'123456789999000',
			'MB_ID'				:'987654321000000',
			'INBN_ID_C12'		:'hsb9121',
			'BOOT_UUID'			:'bootboot'
		}
	}
	,'API_SeuDvdeJoin0200_03'	: {	// PC지정서비스가입해제
		'BT_NAME'	: 'API_SeuDvdeJoin0200_03',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'TMNL_NNM'			:'test',
			'STS'				:'2',
			'PC_DSGT_APL_TRGT'	:'30',
			'TMNL_ID'			:'12',
			'INBN_ID_C12'		:'qkrtjdgh01'
		}
	}
	,'API_CusIqmo0200_01'	: {	// 전자금융사기예방서비스가입내역조회
		'BT_NAME'	: 'API_CusIqmo0200_01',
		'PARAMS'	: {
            'JEX_BANKCODE'	:'101',
            'USER_ID'		:'george75'
        }
	}
	,'API_LogUrpwPhon0200'	: {	// ARS인증용전화번호조회
		'BT_NAME'	: 'API_LogUrpwPhon0200',
		'PARAMS'	: {
	        'JEX_BANKCODE'	:'101',
	        'USER_ID_12'	:'george75'
        }
	}
	,'API_IbaApwl0100'	: {	// 계좌비밀번호3회오류계좌목록조회
		'BT_NAME'	: 'API_IbaApwl0100',
		'PARAMS'	: {
	        'JEX_BANKCODE'	:'101',
	        'SBCD'			:'101',
	        'CSNO'			:'10104838388'
        }
	}
	,'API_IbaApwl0200'	: {	// 계좌비밀번호3회오류해제
		'BT_NAME'	: 'API_IbaApwl0200',
		'PARAMS'	: {
	        'JEX_BANKCODE'	:'101',
	        'SBCD'			:'101',
	        'CSNO'			:'10104838388',
	        'ACNO'			:'10161310011056',
	        'NEW_ACCO_PWD'	:''
        }
	}
	,'API_IbaAcpw0300'	: {	// 계좌비밀번호변경
		'BT_NAME'	: 'API_IbaAcpw0300',
		'PARAMS'	: {
	        'JEX_BANKCODE'	:'101',
	        'ACTNO'			:'10161130096256',
	        'TRN_DSTC'		:'2',     // 1:조회
	        'PSNT_PSWD'		:'',
	        'CHNG_PSWD'		:'',
	        'CNFR_PSWD'		:''
        }
	}
	,'API_InqOvvi0100_01'	: {	// 전계좌조회전계좌조회
		'BT_NAME'	: 'API_InqOvvi0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'SBCD'						:'101',
			'CSNO'						:'10101356649',      //'10100420969',
			'ACCO_KNCD'					:'1',
			'NEXT_DATA_REQT_KEY_VAL'	:'0'     // 최초는 0
		}
	}
	,'API_InqOvvi0200'	: {	// 계좌상세조회
		'BT_NAME'	: 'API_InqOvvi0200',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'ACNO'				:'10161130096256',
			'DEPO_TRN_KNCD_1'	:'1',
			'DVCD'				:'1',    // '1' or '2'
			'STDT'				:'',
			'EDDT'				:''
		}
	}
	,'API_InqTrhi0100_01'	: {	// 거래내역조회
		'BT_NAME'	: 'API_InqTrhi0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'049',
			'INQ_KND'					:'1',
			'ACNO'						:'04961130064177',
			'PWD'						:null,
			'STDT'						:'20200430',
			'EDDT'						:'20200507',
			'LNP_BASE'					:'2',
			'CNT'						:'0000',
			'IOMN_DVCD'					:null,
			'NEXT_DATA_REQT_KEY_VAL'	:'1'
		}
	}
	,'API_TrnImtrRigt0101_01'	: {	// 이체가능금액조회
		'BT_NAME'	: 'API_TrnImtrRigt0101_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'USR_ID'		:'hsb9121',
			'ACNO'			:'10161130096256'
		}
	}
	,'API_TrnImtrRigt0100_01'	: {	// 수취조회(당행)
		'BT_NAME'	: 'API_TrnImtrRigt0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'USER_ID_12'		:'test0075',
			'WTCH_ACNO_16'		:'10161210000593',
			'ACCO_PWD'			:'1005',
			'MNRC_BANK'			:'050',
			'MNRC_ACNO_16'		:'10161210000624',
			'MNRC_AMT_14'		:'50',
			'FEE_5'				:null,
			'MNRC_BNKB_MRK'		:'김민지',
			'ACCO_FLAG'			:'K',
			'USE_DVCD'			:'1',
			'USER_ID'			:'test0075',
			'NO2_ITEM_YN'		:'1',
			'KTB_UUID'			:'e20c243d-c',
			'B_CLOGID' : 'test0075',
			'B_GUBUN' : '1',
			'B_JKFLAG' : 'K',
			'B_TIAM' : '50',
			'B_TIBKCD':'050',
			'B_TICGAM':'0',
			'B_TIPANO':'10161130024058',
			'B_TISCNM':'김민이',
			'B_TISCNO':'1005',
			'B_BYEAR':'1991'
		}
	}
	,'API_TrnImtrRigt0100_02'	: {	// 수취조회(타행)
		'BT_NAME'	: 'API_TrnImtrRigt0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'USER_ID_12'		:'qkrtjdgh01',
			'WTCH_ACNO_16'		:'10161130002205',
			'ACCO_PWD'			:'1233',
			'MNRC_BANK'			:'004',
			'MNRC_ACNO_16'		:'87830101029642',
			'MNRC_AMT_14'		:'123',
			'FEE_5'				:null,
			'MNRC_BNKB_MRK'		:'옥해라(타행)',
			'ACCO_FLAG'			:'K',
			'USE_DVCD'			:'1',
			'USER_ID'			:'qkrtjdgh01',
			'NO2_ITEM_YN'		:'1',
			'KTB_UUID'			:'f8c3243b-5',
			'CSNO'				:'10104851505'
		}
	}
	,'API_TrnImtrRigt0100_03'	: {	// 수취조회(미통합)
		'BT_NAME'	: 'API_TrnImtrRigt0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'USER_ID_12'		:'qkrtjdgh01',
			'WTCH_ACNO_16'		:'10161130002205',
			'ACCO_PWD'			:'1233',
			'MNRC_BANK'			:'050',
			'MNRC_ACNO_16'		:'06601211722932',
			'MNRC_AMT_14'		:'123',
			'FEE_5'				:null,
			'MNRC_BNKB_MRK'		:'곽훈년(미통합)',
			'ACCO_FLAG'			:'K',
			'USE_DVCD'			:'1',
			'USER_ID'			:'qkrtjdgh01',
			'NO2_ITEM_YN'		:'1',
			'KTB_UUID'			:'f8c3243b-5'
		}
	}
	,'API_TrnImtrRigt0200_01'	: {	// 즉시이체_자주쓰는계좌등록(당행)
		'BT_NAME'	: 'API_TrnImtrRigt0200_01',
		'PARAMS'	: {
	        'JEX_BANKCODE'		:'101',
	        'USER_ID_12'		:'test111',
	        'WTCH_ACNO_16'		:'10161130024058',
	        'ACCO_PWD'			:'1004',
	        'RMTN_RQPS2'		:'김민이',
	        'MNRC_BANK'			:'050',
	        'MNRC_ACNO_16'		:'10161210000624',
	        'MNRC_AMT_14'		:'1',
	        'RECV'				:'김민지',
	        'FEE_5'				:'0',
	        'ACCO_FLAG'			:'K',
	        'WTCH_BNKB_MRK'		:'김민지',
	        'USR_ID_12'			:'test111',
	        'TRTM_DVCD'			:'1',
	        'MNRC_ACCO'			:'10161210000624',
	        'DEPR_NM_20'		:'김민지',
	        'ALS'				:'',
	        'DG2_EVPN'			:'J',
	        'PI_DVCD'			:'1'
        }
	}
	,'API_TrnImtrRigt0200_01_02'	: {	// 즉시이체_자주쓰는계좌등록(타행)
		'BT_NAME'	: 'API_TrnImtrRigt0200_01',
		'PARAMS'	: {
	        'JEX_BANKCODE'		:'101',
	        'USER_ID_12'		:'qkrtjdgh01',
	        'WTCH_ACNO_16'		:'10161130002205',
	        'ACCO_PWD'			:'',
	        'RMTN_RQPS2'		:'박성호',
	        'MNRC_BANK'			:'004',
	        'MNRC_ACNO_16'		:'87830101029642',
	        'MNRC_AMT_14'		:'234',
	        'RECV'				:'옥해라',
	        'FEE_5'				:'0',
	        'ACCO_FLAG'			:'K',
	        'WTCH_BNKB_MRK'		:'API(타행)',
	        'USR_ID_12'			:'qkrtjdgh01',
	        'TRTM_DVCD'			:'1',
	        'MNRC_ACCO'			:'87830101029642',
	        'DEPR_NM_20'		:'옥해라',
	        'ALS'				:'',
	        'DG2_EVPN'			:null,
	        'KTB_UUID'			:'f8c3243b-5',
	        'PI_DVCD'			:'1'
        }
	}
	,'API_TrnImtrRigt0200_01_03'	: {	// 즉시이체_자주쓰는계좌등록(미통합)
		'BT_NAME'	: 'API_TrnImtrRigt0200_01',
		'PARAMS'	: {
	        'JEX_BANKCODE'		:'101',
	        'USER_ID_12'		:'qkrtjdgh01',
	        'WTCH_ACNO_16'		:'10161130002205',
	        'ACCO_PWD'			:'',
	        'RMTN_RQPS2'		:'박성호',
	        'MNRC_BANK'			:'050',
	        'MNRC_ACNO_16'		:'06601211722932',
	        'MNRC_AMT_14'		:'345',
	        'RECV'				:'곽훈년',
	        'FEE_5'				:'0',
	        'ACCO_FLAG'			:'K',
	        'WTCH_BNKB_MRK'		:'API(미통합)',
	        'USR_ID_12'			:'qkrtjdgh01',
	        'TRTM_DVCD'			:'1',
	        'MNRC_ACCO'			:'06601211722932',
	        'DEPR_NM_20'		:'곽훈년',
	        'ALS'				:'',
	        'DG2_EVPN'			:null,
	        'KTB_UUID'			:'f8c3243b-5',
	        'PI_DVCD'			:'1'
        }
	}
	,'API_TrnImtrRigt0101_02'	: {	// 최근입금_자주쓰는계좌조회
		'BT_NAME'	: 'API_TrnImtrRigt0101_02',
		'PARAMS'	: {
	        'JEX_BANKCODE'	:'101',    // '101',
	        'USR_ID'		:'hsb9121',       // 'george75',
	        'TRTM_DVCD'		:'2',    // 1.등록, 2.조회, 3.삭제
	        'MNRC_BANK'		:'262',
	        'MNRC_ACCO'		:'2292701211',
	        'DEPR_NM'		:'홍오별',
	        'ALS'			:'너는너'
        }
	}
	,'API_IbaTlrd0100'	: {	// 이체한도감액신청
		'BT_NAME'	: 'API_IbaTlrd0100',
		'PARAMS'	: {
	        'JEX_BANKCODE'	:'101',
	        'PROCS_KND'		:'1',
	        'USER_ID_12'	:'qkrtjdgh06',
	        'TI1_TRNF_LMIT'	:'9000000',
	        'DD1_TRNF_LMIT'	:'49000000'
        }
	}
	,'API_IbaTlrdUpto0100'	: {	// 이체한도증액신청
		'BT_NAME'	: 'API_IbaTlrdUpto0100',
		'PARAMS'	: {
	        'JEX_BANKCODE'	:'101',
	        'PROCS_KND'		:'2',
	        'USER_ID_12'	:'qkrtjdgh06',
	        'TI1_TRNF_LMIT'	:'10000000',
	        'DD1_TRNF_LMIT'	:'50000000'
        }
	}
	,'API_DepDeauRegi0200_01'	: {	// 자동이체(당행)수취인조회
		'BT_NAME'	: 'API_DepDeauRegi0200_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'USER_ID_12'	:'tlswlgns01',
			'MNRC_BANK'		:'050',        //'262'하이투자증권 '050'저축은행
			'MNRC_ACNO_16'	:'10112131391594',   //'11101111111''2041576105'
			'CSNO'			:'10101014719'
		}
	}
	,'API_TrnAutrAuto0100_01'	: {	// 자동이체(타행)수취인조회
		'BT_NAME'	: 'API_TrnAutrAuto0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'USER_ID_12'	:'tlswlgns01',
			'WTCH_ACNO_16'	:'10161130045421',
			'ACCO_PWD'		:'2004',
			'MNRC_BANK'		:'004',
			'MNRC_ACNO_16'	:'87830101029642',
			'MNRC_AMT_14'	:'50000',
			'FEE_5'			:null,
			'MNRC_BNKB_MRK'	:'옥해라',
			'ACCO_FLAG'		:'R',
			'USE_DVCD'		:'1' //1:이체, 3:타행자동이체수수료조회, 2:그외, 4:신규업무, 고정값:"3"
		}
	}
	,'API_TrnAutrAuto0400'	: {	// 자동이체(당행)등록
		'BT_NAME'	: 'API_TrnAutrAuto0400',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'TRMN_TRN_DVCD'		: '01',
			'SBCD'				:'101',
			'INBN_ID_C12'		:'tlswlgns01',
			'WTCH_ACNO'			:'10161130045421',
			'ACCO_PWD'			:'2004',
			'MNRC_ACNO'			:'10112131391594',
			'TRNF_STRN_YM'		:'202007',
			'TRNF_END_YM'		:'202107',
			'TRNF_HOPE_DD_DVCD'	:'09',
			'TRNF_AMT_13'		:'100000',
			'LY_YN'				:'N',
			'MY_ACCO_DVCD'		:'R'
		}
	}
	,'API_TrnAutrAuto0400_01'	: {	// 자동이체(타행)등록
		'BT_NAME'	: 'API_TrnAutrAuto0400_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'USER_ID_12'		:'tlswlgns01',
			'TRN_DSTC'			:'1',
			'ATPAY_DSTC'		:'2',
			'PROP_DSTC_2'		:'01',
			'WTCH_ACNO_16'		:'10161130045421',
			'INQ_DVCD'			:'1',
			'DEPR_NM_20'		:'오용선',
			'GRNO'				:null,
			'PAYR_NO'			:null,
			'PAYR_OPEN_BO_CD'	:null,
			'APFT_ACPT_BOCD'	:null,
			'PAYM_HOPE_DD'		:'01',
			'PARE_KNCD'			:'00',
			'NRIDBRNO_13'		:null,
			'PAYR_TLNO'			:null,
			'PAYR_AMT_15'		:'10000',
			'FRST_OPNG_DT_4'	:'0000',
			'PAYR_MNRC_BKCD'	:'004',
			'PAYR_MNRC_ACNO'	:'87830101029642',
			'SELF_YN'			:'1',
			'SGSR'				:'100000',
			'FEE_7'				:null,
			'SRNO'				:'00000000',
			'PAYR_TRNF_OPNG_DT'	:'202008',
			'PAYR_TRNF_EPRT_DT'	:'202108',
			'PWD_16'			:null,
			'CAN_FLAG'			:'0',
			'RECV'				:'옥해라',
			'field1'			:null,
			'MNRC_BNKB_MRK'		:'옥해라(KB국민은행'

		}
	}
	,'API_TrnAutrRevo0100_01'	: {	// 자동이체(당타행)등록내역조회
		'BT_NAME'	: 'API_TrnAutrRevo0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'SBCD'			:'101',
			'USER_ID_12'	:'tlswlgns01',
			'WTCH_ACNO'		:'10161130045421',
			'TRN_DSTC'		:'4', // 고정값:'4'
			'ATPAY_DSTC'	:'2',
			'PROP_DSTC'		:'0',
			'WTCH_ACNO_16'	:'10161130045421',
			'INQ_DVCD'		:'1',
			'WTCH_ACNO_20'	:'10161130045421'
		}
	}
	,'API_TrnAutrRevo0500'	: {	// 자동이체(당타행)변경등록
		'BT_NAME'	: 'API_TrnAutrRevo0500',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'TRMN_TRN_DVCD'		:'02',
			'SBCD'				:'101',
			'INBN_ID_C12'		:'tlswlgns01',
			'WTCH_ACNO'			:'10161130045421',
			'ACCO_PWD'			:'2004',
			'MNRC_ACNO'			:'10112131391594',
			'TRNF_STRN_YM'		:'202008',
			'TRNF_END_YM'		:'202108',
			'TRNF_HOPE_DD_DVCD'	:'32',
			'TRNF_AMT_13'		:'100000',
			'LY_YN'				:'Y',
			'MY_ACCO_DVCD'		:'K'
		}
	}
	,'API_TrnAutrRevo0700'	: {	// 자동이체(당타행)해지등록
		'BT_NAME'	: 'API_TrnAutrRevo0700',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'USER_ID_12'		:'tlswlgns01',
			'INFO_DSTC_VAL'		:'', // 필수값아님. 당행:'당행'
			'TRMN_TRN_DVCD'		:'03',
			'SBCD'				:'101',
			'INBN_ID_C12'		:'tlswlgns01',
			'WTCH_ACNO'			:'10161130045421',
			'ACCO_PWD'			:'2004',
			'MNRC_ACNO'			:'10112131391594',
			'TRNF_STRN_YM'		:'202008',
			'TRNF_END_YM'		:'202108',
			'TRNF_HOPE_DD_DVCD'	:'07', //이체희망일구분코드'32'세팅할 경우, 말일여부 N/Y세팅
			'TRNF_AMT_13'		:'1000000',
			'LY_YN'				:'',
			'MY_ACCO_DVCD'		:'K',
			'TRN_DSTC'			:'2',
			'ATPAY_DSTC'		:'2',
			'PROP_DSTC_2'		:'03',
			'TRN_SRNO_10'		:'',
			'WTCH_ACNO_16'		:'10161130045421',
			'INQ_DVCD'			:'1',
			'DEPR'				:'오용선',
			'GRNO'				:'',
			'PAYR_NO'			:'',
			'PAYR_OPEN_BO_CD'	:'',
			'APFT_ACPT_BOCD'	:'',
			'PAYM_HOPE_DD'		:'07',
			'PARE_KNCD'			:'00',
			'NRBRNO_INQ'		:'',
			'PAYR_TLNO'			:'',
			'PAYR_AMT_15'		:'100000',
			'FRST_OPNG_DT_4'	:'0000',
			'PAYR_MNRC_BKCD'	:'101',
			'PAYR_MNRC_ACNO'	:'10112131391594',
			'SELF_YN'			:'1',
			'SGSR'				:'100000',
			'FEE_7'				:'',
			'PAYR_TRNF_OPNG_DT'	:'',
			'PAYR_TRNF_EPRT_DT'	:'',
			'PWD'				:'2004',
			'CAN_FLAG'			:'9',
			'RECV'				:'',
			'TRNF_CCNT'			:'1',
			'ATTR_DT'			:null,
			'MNRC_BANK'			:null,
			'MNRC_WB_ACNO'		:null
		}
	}
	,'API_TrnAutrTran0100_01'	: {	// 자동이체(당타행)이체결과조회
		'BT_NAME'	: 'API_TrnAutrTran0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'INQ_STRN_DT'	:'20180102',
			'INQ_LST_DT'	:'20200102',
			'WTCH_ACNO'		:'10161130045421'
		}
	}
	,'API_TrnAucmAuto0500'	: {	// 자동이체(CMS)타행출금관리
		'BT_NAME'	: 'API_TrnAucmAuto0500',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'CMP_HEADER'		:null,
			'TRMN_TRN_DVCD'		:'01', // 01:등록, 02:변경, 03:해제
			'SBCD'				:'101',
			'INBN_ID_C12'		:'tlswlgns01',
			'ACCO_PWD'			:'2004',
			'WTCH_BKCD'			:'101',
			'WTCH_ACNO'			:'10161130045421',
			'MNRC_BKCD'			:'004',
			'MNRC_ACNO'			:'87830101029642',
			'TRNF_STRN_YM'		:'202007',
			'TRNF_END_YM'		:'202207',
			'TRNF_HOPE_DD_DVCD'	:'32',
			'TRNF_AMT_13'		:'99999',
			'LY_YN'				:'Y'
		}
	}
	,'API_TrnAucmAuto0800'	: {	// 자동이체(CMS)저축은행출금등록
		'BT_NAME'	: 'API_TrnAucmAuto0800',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'TRMN_TRN_DVCD'		:'01', // 01:등록(고정값), 02:변경, 03:해제
			'SBCD'				:'101',
			'INBN_ID_C12'		:'tlswlgns01',
			'ACCO_PWD'			:'2004',
			'WTCH_BKCD'			:'101',
			'WTCH_ACNO'			:'10161130045421',
			'MNRC_BKCD'			:'101',
			'MNRC_ACNO'			:'10112131391594',
			'TRNF_STRN_YM'		:'202007',
			'TRNF_END_YM'		:'202207',
			'TRNF_HOPE_DD_DVCD'	:'23',
			'TRNF_AMT_13'		:'50000',
			'LY_YN'				:'N'
		}
	}
	,'API_TrnAucmRevo0100_01'	: {	// 자동이체(CMS)등록내역조회
		'BT_NAME'	: 'API_TrnAucmRevo0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'SBCD'			:'101',
			'SVBN_ACNO'		:'10161130045421'
		}
	}
	,'API_TrnAucmTran0100_01'	: {	// 자동이체(CMS)이체결과조회
		'BT_NAME'	: 'API_TrnAucmTran0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'SBCD'			:'101',
			'SVBN_ACNO'		:'10161130045421',
			'INQ_STDT'		:'20200101',
			'INQ_EDDT'		:'20200501'
		}
	}
	,'API_TrnImtrRigt0100'	: {	// 지연이체서비스 조회
		'BT_NAME'	: 'API_TrnImtrRigt0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO'			:'10104838388'
		}
	}
	,'API_TrnImtrRigt0106'	: {	// 장애은행조회
		'BT_NAME'	: 'API_TrnImtrRigt0106',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101'
		}
	}
	,'API_TrnImtrRigt0107'	: {	// 입금지정계좌조회/입금지정계좌보유여부조회
		'BT_NAME'	: 'API_TrnImtrRigt0107',
		'PARAMS'	: {
	        'JEX_BANKCODE'	:'101',
	        'CSNO'			:'10104848663',
	        'USR_ID'		:'soonlhh26'
        }
	}
	,'API_TrnDetrList0100_01'	: {	// 지연이체서비스가입여부조회
		'BT_NAME'	: 'API_TrnDetrList0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'049',
			'CSNO'				:'04900714945',
			'MNRC_BKCD'			:'050',
			'MNRC_BANK_ACNO'	:'04961130064135',
			'TRNF_AMT'			:'100000',
			'ACML_AMT'			:'100000'
		}
	}
	,'API_IbaDtrn0200'	: {	// 지연이체서비스관리
		'BT_NAME'	: 'API_IbaDtrn0200',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'IMMD_TRNF_ACCO_CNT'		:'1',
			'REC'						:[{'MNRC_BKCD':'004','MNRC_ACNO':'87830101029642','REG_DVCD':'Y'},{'MNRC_BKCD':'050','MNRC_ACNO':'06601211722932','REG_DVCD':'Y'}],
			'STAT'						:'1',
			'IMMD_TRNF_ACCO_REG_YN'		:'Y',
			'IMMD_TRNF_DD1_LMIT'		:'1000000',
			'CSNO'						:'10102459466'

		}
	}
	,'API_IbaDeptJore0200'	: {	// 입금지정계좌관리
		'BT_NAME'	: 'API_IbaDeptJore0200',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO'			:'10101284900',
			'USER_ID'		:'bsang21c',
			'USR_ID'		:'bsang21c',
			'REG_DVCD'		:'Y',
			'MNRC_BKCD'		:'101',
			'MNRC_ACNO'		:'10161130200257',
		}
	}
/* ------------------------------------------------ [스마트출금] ------------------------------------------------ */
	,'API_TrnSmatAcmo0100' : {	// 스마트ATM 출금 계좌변경 전조회
		'BT_NAME'	: 'API_TrnSmatAcmo0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO_INQ'		:'10104838388'
		}
	}
	,'API_TrnSmatAcmo0200' : {	// 스마트ATM 출금 계좌변경 완료
		'BT_NAME'	: 'API_TrnSmatAcmo0200',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'TRN_DSTC'				:'3',
			'CSNO_INQ'				:'10104851505',
			'SM_ATM_WTCH_ACNO'		:'10161130022510',
			'ACCO_PWD'				:'',
			'BCHN_ACNO'				:'10161130002205',
			'BE_TI1_WTCH_LMIT_AMT'	:null,
			'BE_DD1_WTCH_LMIT_AMT'	:null,
			'AF_TI1_WTCH_LMIT_AMT'	:null,
			'AF_DD1_WTCH_LMIT_AMT'	:null
		}
	}
	,'API_TrnSmatAtsr0100' : {	// 가까운ATM 찾기
		'BT_NAME'	: 'API_TrnSmatAtsr0100',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'LISTLEN'			:'10',
			'LAT'				:'37.549093',
			'LON'				:'126.9540821',
			'DEF_DISTANCE'		:'2',
			'CUR_PAGE'			:'1'
		}
	}
	,'API_TrnSmatAtsr0200_01' : {	// 지역별ATM_광역/시/도 선택
		'BT_NAME'	: 'API_TrnSmatAtsr0200_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'TRL_NM'		:'경기'
		}
	}
	,'API_TrnSmatSmwt0100_01' : {	// 스마트ATM 출금 확인/취소
		'BT_NAME'	: 'API_TrnSmatSmwt0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'TRN_DSTC'			:'1',
			'SM_ATM_WTCH_ACNO'	:'10101130372111',
			'OTU_ATHN_NO'		:'980580',
			'WTCH_AMT'			:'10000'
		}
	}
	,'API_TrnSmatSmwt0100_02' : {	// 스마트ATM 출금 재신청
		'BT_NAME'	: 'API_TrnSmatSmwt0100_02',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'SM_ATM_WTCH_ACNO'	:'10101130372111',
			'OTU_ATHN_NO'		:'862934',
			'WTCH_AMT'			:'10000'
		}
	}
	,'API_TrnSmatSmwt0100' : {	// 스마트ATM 출금 정보 입력
		'BT_NAME'	: 'API_TrnSmatSmwt0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO_INQ'		:'10104838388'
		}
	}
	,'API_TrnSmatSmwt0101' : {	// 스마트ATM 출금 인증 번호 요청
		'BT_NAME'	: 'API_TrnSmatSmwt0101',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'SM_ATM_WTCH_ACNO'	:'10101130372111',
			'ACCO_PWD'			:'',
			'WTCH_AMT'			:'10000'
		}
	}
	,'API_TrnSmatSmwt0200' : {	// 스마트ATM 출금 완료
		'BT_NAME'	: 'API_TrnSmatSmwt0200',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'TRN_DSTC'			:'4',
			'SM_ATM_WTCH_ACNO'	:'10101130372111',
			'OTU_ATHN_NO'		:'301713',
			'WTCH_AMT'			:'10000'
		}
	}
	,'API_TrnSmatSvad0100' : {	// 스마트ATM 출금 서비스 등록
		'BT_NAME'	: 'API_TrnSmatSvad0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO_INQ'		:'10104838388'
		}
	}
	,'API_TrnSmatSvad0200' : {	// 스마트ATM 출금 서비스 등록 완료
		'BT_NAME'	: 'API_TrnSmatSvad0200',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'TRN_DSTC'				:'2',
			'CSNO_INQ'				:'10104838388',
			'SM_ATM_WTCH_ACNO'		:'10101130372111',
			'ACCO_PWD'				:'',
			'BCHN_ACNO'				:null,
			'BE_TI1_WTCH_LMIT_AMT'	:null,
			'BE_DD1_WTCH_LMIT_AMT'	:null,
			'AF_TI1_WTCH_LMIT_AMT'	:null,
			'AF_DD1_WTCH_LMIT_AMT'	:null
		}
	}
	,'API_TrnSmatSmwt0100_03' : {	// ATM스마트 출금 서비스 해지
		'BT_NAME'	: 'API_TrnSmatSmwt0100_03',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'TRN_DSTC'				:'4',
			'CSNO_INQ'				:'10104838388',
			'SM_ATM_WTCH_ACNO'		:'10101130372111',
			'ACCO_PWD'				:'',
			'BCHN_ACNO'				:null,
			'BE_TI1_WTCH_LMIT_AMT'	:null,
			'BE_DD1_WTCH_LMIT_AMT'	:null,
			'AF_TI1_WTCH_LMIT_AMT'	:null,
			'AF_DD1_WTCH_LMIT_AMT'	:null
		}
	}
/* ------------------------------------------------ [예적금] ------------------------------------------------ */
	,'API_DepDeindLst0400_01' : {	// 정기예금, 적금 신청 전조회
		'BT_NAME'	: 'API_DepDeindLst0400_01',
		'PARAMS'	: {
			'JEX_BANKCODE' 			:'101',
			'CSNO'					:'10100523388',
			'MNDP_KIND'				:'20',
			'CNPD_MNTH'				:'12',
			'CNPD_DAYS'				:'0',
			'CNTR_AMT_N15'			:'10000000',
			'MN_PI_AMT_N15'			:null,
			'INSM_CYCL_DVCD'		:null,
			'WTCH_ACNO_C20'			:'10161210000593',
			'WTCH_ACCO_C700'		:'',
			'TXTN_CD'				:'11',
			'PROD_KIND'				:'1',
			'ATTR_YN'				:'Y',
			'ATTR_DSGT_DT'			:'19',
			'ATPAY_CNTP_BKCD'		:'101',
			'ATPAY_CNTP_BK_ACNO'	:'10101130007986',
			'PDCD'					:'240001',
			'ATMT_EXPT_EXTS_YN'		:'0',
			'INTS_MNRC_BANK'		:null,
			'INTS_MNRC_ACNO_C20'	:''
		}
	}
	,'API_DepDeindLst0500_02' : {	// 정기예금 신규
		'BT_NAME'	: 'API_DepDeindLst0500_02',
		'PARAMS'	: {
			'JEX_BANKCODE'			: '101',
			'PROD_NM'				: null,
			'DEPR_NM'				: null,
			'CNPD_MNTH'				: '12',
			'CNPD_DAYS'				: '0',
			'EXPT_DT'				: null,
			'WTCH_ACCO_C20'			: '10101130007986',
			'DPSY_AMT_N15'			: '10000000',
			'INRT_N8'				: null,
			'TMDP_PWD_C700'			: '',
			'WTCH_ACCO_C700'		: '',
			'TXTN_CD'				: '11',
			'PROD_KIND_C2'			: null,
			'INTS_PRVS'				: '2',
			'ATTR_YN'				: '',
			'ATTR_DSGT_DT'			: '',
			'CSNO'					: '10104848640',
			'ATPAY_CNTP_BKCD'		: '',
			'ATPAY_CNTP_BK_ACNO'	: '10101130007986',
			'PDCD'					: '240002',
			'ATMT_EXPT_EXTS_YN'		: '0',
			'INTS_MNRC_BANK'		: '',
			'INTS_MNRC_ACNO_C20'	: '',
			'SGSR_NO'				: ''
		}
	}
	,'API_DepDeinIlst0600' : {	// 정기적금 신규
		'BT_NAME'	: 'API_DepDeinIlst0600',
		'PARAMS'	: {
			'JEX_BANKCODE'			: '101',
			'PROD_NM'				: null,
			'DEPR_NM'				: null,
			'WTCH_ACCO_C20'			: '10101130326136',
			'CNPD_N3'				: '6',
			'EXPT_DT'				: null,
			'PYMN_AMT_N15'			: '10000',
			'INRT_N8'				: '0',
			'WTCH_ACCO_C700'		: '',
			'INSV_ACNO_PWD_C700'	: '',
			'TXTN_CD'				: '11',
			'INSM_CYCL_DVCD'		: '01',
			'ATTR_YN'				: 'N',
			'ATTR_DSGT_DT'			: null,
			'CSNO'					: '10104848651',
			'CNTR_AMT_N15'			: '60315',
			'ATPAY_CNTP_BKCD'		: null,
			'ATPAY_CNTP_BK_ACNO'	: null,
			'PDCD'					: '101009',
			'SGST_USRNO'			: null
		}
	}
	,'API_DepDeindLst0401' : {	// 세금우대 한도조회
		'BT_NAME'	: 'API_DepDeindLst0401',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'NRBRNO_INQ'		:'8408082904217',
			'SVNG_KIND'			:'41',
			'INQ_KIND'			:'2'
		}
	}
	,'API_DepDeclTran0100' : {	// 해지가능계좌조회
		'BT_NAME'	: 'API_DepDeclTran0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO'			:'10100420969'
		}
	}
	,'API_DepDeclTran0200' : {	// 해지예상조회
		'BT_NAME'	: 'API_DepDeclTran0200',
		'PARAMS'	: {
			'JEX_BANKCODE' 		:'101',
			'ACNO'				:'10161240853669',
			'TRMT_CD'			:null,
			'TRMT_DT'			:'20191218',
			'TRMT_AMT_N15'		:''
		}
	}
	,'API_DepDeclRevo0300' : {	// 예적금 해지
		'BT_NAME'	: 'API_DepDeclRevo0300',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'INBN_ID_C12'		:'',
			'ACTNO'				:'10161240853669',
			'PSWD_700'			:'1013',
			'MNRC_ACNO'			:'10161130096256',
			'CUST_NM'			:'',
			'CSNO'				:'',
			'TRMT_AMT_N17'		:''
		}
	}
	,'API_DepDeclRevo0201' : {	// 예적금 해지 선조회
		'BT_NAME'	: 'API_DepDeclRevo0201',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'INBN_ID_C12'	:null,
			'ACTNO'			:'10161240853669',
			'PSWD_700'		:'1013',
			'MNRC_ACNO'		:'10161130096256',
			'TRMT_AMT_N17'	:''
		}
	}
	,'API_PrdInfoList0100' : {	// 예적금상품목록조회
		'BT_NAME'	: 'API_PrdInfoList0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'SBCD'			:'101',
			'STS_DVCD'		:'61,62,63,64',	// 적금:01  예금:02
			'STRN'			:'1',
			'EDRN'			:'11',
			'NEXT_DATA_REQT_KEY_VAL':'1'
		}
	}
	,'API_PrdInfoDtil0100' : {	// 정기예금상품상세조회
		'BT_NAME'	: 'API_PrdInfoDtil0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'049',
			'SBCD'			:'049',
			'CHNL_DVCD'		:'SMB',
			'PDCD'			:'101013',
			'STS_DVCD'		:'01',
		}
	}
	,'API_DepDeindLst0400_03' : {	// 권유사용자조회
		'BT_NAME'	: 'API_DepDeindLst0400_03',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'SGST_USRNO'	:'590747'
		}
	}
	,'API_RacCdacChek0100' : {	// 정기예금정보입력/체크카드번호조회
		'BT_NAME'	: 'API_RacCdacChek0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'SBCD'			:'101',
			'CSNO'			:'10104838388'
		}
	}
	,'API_DepDeindLst0500_01' : {	// 신용정보활용동의전조회
		'BT_NAME'	: 'API_DepDeindLst0500_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'INPT_DVCD_2'	:'01',
			'CSNO'			:'10104848640'
		}
	}
	,'API_DepDeindLst0500_03' : {	// 개인(신용)정보관련표준동의서조회
		'BT_NAME'	: 'API_DepDeindLst0500_03',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101'
		}
	}
	,'API_DepDeindLst0501' : {	// 신용정보활용동의본거래
		'BT_NAME'	: 'API_DepDeindLst0501',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'CSNO'					:'10104848666',
			'CRIF_MRKN_COLT_UZ_MTR'	:'01',
			'CRIF_MRKN_OFR_MTR'		:'01',
			'SMS_YN'				:'Y',
			'EMAIL_YN'				:'Y',
			'TEL_YN'				:'Y',
			'DM_YN'					:'Y'
		}
	}
	,'API_PrdInfoDtil0100_01' : {	// 정기적금상품확인
		'BT_NAME'	: 'API_PrdInfoDtil0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'SBCD'			:'101',
			'STS_DVCD'		:'01',	// 적금:01  예금:02
			'PDCD'			:'101009'
		}
	}
/* ------------------------------------------------ [대출] ------------------------------------------------ */
	,'API_LonInfoLoan0300' : {	// 예적금담보대출-계좌조회
		'BT_NAME'	: 'API_LonInfoLoan0300',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'CSNO'						:'10104838388',
			'NEXT_DATA_REQT_KEY_VAL'	:'1'
		}
	}
	,'API_LonInfoLoan0400' : {	// 예적금담보대출-원장등록
		'BT_NAME'	: 'API_LonInfoLoan0400',
		'PARAMS'	: {
			'JEX_BANKCODE'			: '101',
			'LTERM_N4'				:'12',
			'ATTR_REG_N1'			:'1',
			'SID_MORT_ACNO'			:'10161240853669',
			'ATTR_WTCH_ACNO_C14'	:'',  //'10161130000758',
			'TX_KND_N1'				:'1',   // 1.조회, 2.
			'CSNO'					:'10100420969',
			'MNRC_ACNO'				:'10161130096256',   // 요구불
			'LAMT'					:'5000000',
			'EXPT_DT'				:'',
			'ORD_TYPE'				:'1'
		}
	}
	,'API_LonInfoLoan0401' : {	// 예적금담보대출-대출고객본인확인
		'BT_NAME'	: 'API_LonInfoLoan0401',
		'PARAMS'	: {
			'JEX_BANKCODE'			: '101',
			'CNTA_KND_C1'			:'1',
			'LTERM_N5'				:'0',
			'RNNO_C13'				:'8712151789713',
			'PROP_LAMT_N17'			:'100000',
			'MNRC_ACNO'				:'10161130200265',
			'LOAN_INRT_C9'			:'4.45000',
			'ATTR_REG_N1'			:'1',
			'RLNM_ATHN_DSTC_C2'		:'02',
			'REG_ISS_DT_C8'			:'20170912',
			'ATTR_WTCH_ACNO_C14'	:'10161130200265',
			'DRVN_LCNS_CHK_NO'		:'S87P8E',
			'TX_KND'				:'1',
			'EXPT_DT'				:'20211114',
			'SID_ACNO'				:'10161244286266',
			'DRNO_C20'				:'22-10-034299-70',
			'ORD_TYPE'				:'1'
		}
	}
	,'API_LonInqyDtrn0200' : {	// 예적금담보대출결과조회
		'BT_NAME'	: 'API_LonInqyDtrn0200',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO'			:'10104848663'
		}
	}
	,'API_LonInfoLoan0701' : {	// 예적금담보대출-고객본인확인요청처리
		'BT_NAME'	: 'API_LonInfoLoan0701',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'TX_KND_N1'				:'1',
			'CSNO'					:'10104848663',
			'INBN_CUST_CNFR_SRNO'	:'1',
			'ORD_TYPE'				:'02'
		}
	}
	,'API_LonInfoLoan0702' : {	// 예적금담보대출-대출원장조회등록
		'BT_NAME'	: 'API_LonInfoLoan0702',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'LTERM_N4'				:'',
			'ATTR_REG_N1'			:'0',
			'SID_MORT_ACNO'			:'10161240711028',
			'ATTR_WTCH_ACNO_C14'	:'',
			'TX_KND_N1'				:'2',	// 1:조회, 2:등록
			'CSNO'					:'10101284905',
			'MNRC_ACNO'				:'10161240711028',
			'LAMT'					:'95000',
			'EXPT_DT'				:'20240706',
			'ORD_TYPE'				:'03'	// 01:예적금대출실행 , 02:종통대출실행
			,'GVCR_PROP_NO_N14'				:'10120002129863'
		}
	}
	,'API_LonInfoSail0300' : {	// SGI사잇돌대출-신청
		'BT_NAME'	: 'API_LonInfoSail0300',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'NRBRNO_INQ'		:'7808152292933',
			'CUSTNM_C50'		:'황동헌',
			'YR_LBR_INCM_AMT'	:'123000',
			'YR_BIZ_INCM_AMT'	:'456000',
			'YR_PNSN_INCM_AMT'	:'789000',
			'CNTA_TLNO_C13'		:'01011111234',
			'ADDR_TP'			:'0',
			'ZPCD'				:'04213',
			'ZPSR_C3'			:'',
			'BSIC_ADDR_C200'	:'서울 마포구 마포대로 지하 100 공덕역',
			'DTL_ADDR_C200'		:'12',
			'BLDG_MNGNO'		:'',
			'ADDR_REF_ITEM_NM'	:'',
			'REQT_BO'			:'01'
		}
	}
	,'API_LonRpifTran0200' : {	// 대출이자납입금액/대출상환 조회
		'BT_NAME'	: 'API_LonRpifTran0200',
		'PARAMS'	: {
			'JEX_BANKCODE'		: '101',
			'LOAN_BZWR_DVCD_5'	: '2',
			'LOAN_ACNO'			: '10101760028800',
			'PI_RND_5'			: null,
			'CMPY_YN'			: 'Y',
			'RPY_AMT'			: ''
		}
	}
	,'API_LonRpifPaym0100' : {	// 대출이자납입-상환계좌 조회
		'BT_NAME'	: 'API_LonRpifPaym0100',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'TRN_DSTC'					:'N',
			'CSNO'						:'10104838388',
			'NEXT_DATA_REQT_KEY_VAL'	:'1'
		}
	}
	,'API_LonRpifPaym0200' : {	// 대출이자납입/대출상환 수취인성명조회
		'BT_NAME'	: 'API_LonRpifPaym0200',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'MNRC_ACNO_16':'10161130000758',
			'MNRC_AMT_14':'10',
			'ACCO_PWD':'1233',
			'USER_ID_12':'george75',
			'MNRC_BANK':'050',
			'ACCO_FLAG':'K',
			'USE_DVCD':'2',
			'WTCH_ACNO_16':'10161130000758'
		}
	}
	,'API_LonRpifPaym0201' : {	// 대출이자납입/대출원금상환
		'BT_NAME'	: 'API_LonRpifPaym0201',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'LOAN_BZWR_DVCD_5'		:'1',
			'LOAN_ACNO'				:'10161760033774',
			'RPY_RND'				:'1',
			'BSDT'					:null,
			'CMPY_YN'				:'N',
			'RPY_AMT'				:'10000',
			'NT_BILN_PRNC_BLNK_18'	:null,
			'NT_BILN_INTS_SMAT_18'	:null,
			'NROM_INTS'				:null,
			'OVFE'					:null,
			'OVRD_INTS'				:null,
			'RPMT_INTS'				:null,
			'RPY_FEE'				:null,
			'WTCH_ACNO'				:'10101130324948',
			'ACCO_PWD'				:'1233'
		}
	}
	,'API_LonRpifRepy0201' : {	// 대출원리금상환-종통약정해제
		'BT_NAME'	: 'API_LonRpifRepy0201',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'TRN_DSTC'			:'1',
			'CMBB_ACNO'			:'10161130002205',
			'WTCH_ACNO'			:'10161130002205',
			'WTCH_ACCO_C700'	:''
		}
	}
	,'API_LonRpifRest0100' : {	// 예금담보대출상계-대상조회
		'BT_NAME'	: 'API_LonRpifRest0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO'			:'10104838388'
		}
	}
	,'API_LonRpifRest0200' : {	// 예적금담보대출상계-전조회
		'BT_NAME'	: 'API_LonRpifRest0200',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'SID_ACNO'			:'10161244286185',
			'REC_CNT_5'			:'1',
			'IN_REC'			:[{'LOAN_ACNO':'10161750020390'}]
		}
	}
	,'API_LonRpifRest0300' : {	// 예적금담보대출상계
		'BT_NAME'	: 'API_LonRpifRest0300',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'SID_ACNO'			:'10161240145622',
			'TRMT_AMT_N18'		:'20000000',
			'TRMT_INTS'			:'21952',
			'SPEL_INTS'			:'0',
			'INTX'				:'3070',
			'RSTX'				:'300',
			'NEA_TAX_N18'		:'0',
			'IMPR_ALTX_SUM_N18'	:'3370',
			'SBTR_PRVS_AMT_N18'	:'20018582',
			'REC_CNT_5'			:'1',
			'OUT_REC'		:[
					{
						'LOAN_ACNO':'10161750012412',
						'RPY_PRNC':'18000000',
						'NROM_INTS':'67511',
						'OVRD_INTS':'0',
						'OVFE':'0',
						'RPMT_INTS':'0',
						'NT_BILN_INTS_N18':'0',
						'AFRP_LOAN_BLNC':'0'
					}
			],
			'AFRP_SAMT_N18'		:'18067511',
			'CMMD_MNRC_AMT_N18'	:'1951071',
			'CMMD_ACNO'			:'10161130002205',
			'SID_PWD_C700'		:'',
		}
	}
	,'API_LonRpifTore0100' : {	// 한도증액/감액 - 대상계좌조회
		'BT_NAME'	: 'API_LonRpifTore0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'TRGB'			:'1',
			'CSNO'			:'10100555680'
		}
	}
	,'API_LonRpifTore0200' : {	// 한도증액/감액
		'BT_NAME'	: 'API_LonRpifTore0200',
		'PARAMS'	: {
			'JEX_BANKCODE'	: '101',
			'TRGB'			: '1',       // 1.감액 , 2.증액
			'AGRM_ACNO'		: '10104851505'  ,  // '10161130002205',
			'ACCO_PWD'		: '1234',
			'BCHN_LMIT_AMT'	: '43000000',   // 43000000
			'ACHN_LMIT_AMT'	: '44000000'    // 45000000
		}
	}

	,'API_LonRpifTore0200_01' : {	// 한도증액  - // 없음
		'BT_NAME'	: 'API_LonRpifTore0200',
		'PARAMS'	: {
			'JEX_BANKCODE'	: '101',
			'TRGB'			: '2',
			'AGRM_ACNO'		: '10161130002205',
			'ACCO_PWD'		: '',
			'BCHN_LMIT_AMT'	: '44000000',
			'ACHN_LMIT_AMT'	: '45000000'
		}
	}
	,'API_LonFdpcList0100' : {	// 대출만기도래현황
		'BT_NAME'	: 'API_LonFdpcList0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO'			:'10104848663'
		}
	}
	,'API_LonFdpcUpco0100' : {	// 대출이자납입기일도래현황
		'BT_NAME'	: 'API_LonFdpcUpco0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO'			:'10104848663'
		}
	}
	,'API_LonDdexList0100' : {	// 대출기한연장-전조회
		'BT_NAME'	: 'API_LonDdexList0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO'			:'10101374995'
		}
	}
	,'API_LonDdexList0201' : {	// 대출기한연장
		'BT_NAME'	: 'API_LonDdexList0201',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'ACNO'				:'10161750012632',
			'DLAY_EXPT_DT_C8'	:'20200920'
		}
	}
	,'API_LonDdexTran0100' : {	// 대출기한연장이력조회
		'BT_NAME'	: 'API_LonDdexTran0100',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'CSNO'						:'10104838388',
			'NEXT_DATA_REQT_KEY_VAL'	:null
		}
	}
	,'API_LonDdexTran0200' : {	// 대출기한연장이력조회-상세조회
		'BT_NAME'	: 'API_LonDdexTran0200',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'ACNO'			:'10161750012519'
		}
	}
	,'API_LonWileAppl0100' : {	// 대출철회및금리인하요구권신청전조회
		'BT_NAME'	: 'API_LonWileAppl0100',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'TRN_DSTC_2'				:'02',
			'CSNO'						:'10104838388',
			'NEXT_DATA_REQT_KEY_VAL'	:null
		}
	}
	,'API_LonWileAppl0200' : {	// 대출계약철회및금리인하요구권등록
		'BT_NAME'	: 'API_LonWileAppl0200',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'TRN_DSTC_2'		:'02',
			'CSNO'				:'10104838388',
			'ACNO'				:'10161750012519',
			'IRCL_PROP_RSCD'	:null
		}
	}
	,'API_LonWileCncl0100' : {	// 대출철회및금리인하요구권신청취소전조회
		'BT_NAME'	: 'API_LonWileCncl0100',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'TRN_DSTC_2'				:'02',
			'CSNO'						:'10104838388',
			'PROP_DT'					:'20180710',
			'PROP_EDDT'					:'20190710',
			'NEXT_DATA_REQT_KEY_VAL'	:'1'
		}
	}
	,'API_LonWileCncl0200' : {	// 대출계약철회및금리인하요구권등록취소
		'BT_NAME'	: 'API_LonWileCncl0200',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'TRN_DSTC_2': '01',
			'CSNO': '10104838388',
			'REG_TRN_NO': '201909191335500',
			'PROP_DT': '20190919'
		}
	}
	,'API_LonCaiq0100' : {	// 대출해지계좌조회
		'BT_NAME'	: 'API_LonCaiq0100',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'CSNO'						:'10104838388',
			'STDT'						:'20190723',
			'EDDT'						:'20190919',
			'NEXT_DATA_REQT_KEY_VAL'	:'1'
		}
	}
	,'API_LonWileAppl1000' : {	// 대출철회및금리인하요구권신청 - 비대면거래번호채번
		'BT_NAME'	: 'API_LonWileAppl1000',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101'
		}
	}
/* ------------------------------------------------ [사고신고] ------------------------------------------------ */
	,'API_RacScreList0100' : {	// 보안카드및OTP사고신고
		'BT_NAME'	: 'API_RacScreList0100',
		'PARAMS'	: {
			'JEX_BANKCODE'			: '101',
			'ACTNO'					: '10161130002213',
			'RRNO'					: '9710211158521',
			'TRN_KNCD'				: '1',
			'CLSC_CD'				: '2',
			'REG_CD'				: '44',
			'EXMT_CNT'				: null,
			'EXMT_CD'				: null,
			'SETP_AMT'				: null,
			'OUTL'					: null,
			'ACPT_DSTC1'			: '2',
			'MESG_LEN'				: '134',
			'MESG_CLSC_CD'			: '200',
			'MESG_DVCD'				: '200303',
			'BKCD'					: '506',
			'BO_NO'					: '01',
			'INDV_CORP_DSTC'		: '1',
			'RESP_CD'				: null,
			'TNRC_DSTC'				: null,
			'OTP_VNDR_CD1'			: '001',
			'OTP_SRNO1'				: '99209015',
			'OTP_VNDR_CD2'			: null,
			'OTP_SRNO2'				: null,
			'OTP_OTPT_VAL1'			: null,
			'OTP_OTPT_VAL2'			: null,
			'TX_KND'				: null,
			'GBPR_LMTD_DSTC'		: null,
			'UZ_REG_YN'				: null,
			'UZ_REG_INSTCD'			: null,
			'ERR_NTM'				: null,
			'GRNY_TERM_STDT'		: null,
			'GRNY_TERM_EDDT'		: null,
			'LCKN_RESP_VAL'			: null,
			'ACDT_DCL_CRCT_DSTC'	: null,
			'FILLER'				: null
		}
	}
	,'API_RacCdacChek0100_01' : {	// 체크카드사고신고선조회
		'BT_NAME'	: 'API_RacCdacChek0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'REG_TRMT_DSTC1'	:'2',
			'CANO'				:'9440953100001667',
			'CSNO'				:'10104848663',
			'SCSS_YN'			:'N'
		}
	}
	,'API_RacCdacChek0300' : {	// 체크카드사고신고
		'BT_NAME'	: 'API_RacCdacChek0300',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'REG_TRMT_DSTC1'			:'1',
			'CANO'						:'9440953100001626',
			'CSNO'						:'10104848667',
			'SCSS_YN'					:'N',
			'CHCR_ACDT_DCL_ACPT_NO'		:null,
			'INDV_ENTP_DVCD'			:'01',
			'PROP_CARD_DVCD'			:null,
			'ACTNO'						:'10161130001322',
			'VLD_DLN_YM'				:'202402',
			'CO_NO'						:null,
			'REGS_DT'					:'20190321',
			'REGS_TKTM'					:'150112',
			'RVCT_DT'					:null,
			'RVCT_TM'					:null,
			'BC_ACDT_CD'				:'111',
			'BC_ACDT_CD2'				:null,
			'BC_ACPT_NO'				:null,
			'BC_ACPT_DVCD'				:'07',
			'CUST_NM'					:'이정규',
			'ABR_LOS_RBR_YN_DVCD'		:'1',
			'CNTA_TLNO'					:'01034373405',
			'APLC_NM'					:'김희경',
			'LOS_AREA_ADDR'				:'',
			'RLT_NM'					:'본인',
			'LOS_DT'					:'20190321',
			'NRBR_NO'					:'8208291235318'
		}
	}
	,'API_RacCcacList0200' : {	// 자행수표사고신고
		'BT_NAME'	: 'API_RacCcacList0200',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'ATNT_ACDT_DSTC1'	:'01',
			'TRN_DSTC'			:'01',
			'CNT'				:'1',
			'ACDT_CHCK_CTBL'	:'19',
			'SCNT'				:'1',
			'CHCK_STRN_NO'		:'08501043',
			'CHCK_END_NO'		:'08501043',
			'CHCK_UNIT_AMT'		:'5000000',
			'CHCK_SAMT'			:'5000000',
			'HNDV_DT'			:'20190708',
			'HNDV_BO_N7'		:'503109',
			'APLC_NM'			:'김명준',
			'APLC_NRBRNO_INQ'	:'9001091209212',
			'APLC_TLNO1'		:'010',
			'APLC_TLNO2'		:'9847',
			'APLC_TLNO3'		:'8802',
			'ACDT_DCL_DETL'		:'인터넷뱅킹 수표사고신고',
			'ETC_INFO'			:null,
			'RCK_DT'			:null
		}
	}
	,'API_RacOtprOtps0100_01' : {	// OTP사고회복선거래
		'BT_NAME'	: 'API_RacOtprOtps0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'USR_ID_12'					:'dlwjdrb01',
			'PROC_FLAG'					:'I',
			'RRNO'						:'9710211158521',
			'WTCH_ACNO'					:'10161130002213',
			'WTCH_ACCO_C700'			:'',
			'MESG_LEN'					:'099',
			'MESG_CLSC_CD'				:'0200',
			'MESG_DVCD'					:'200505',
			'BKCD'						:'101',
			'BO_NO'						:'01',
			'INDV_CORP_DSTC'			:'1',
			'RESP_CD'					:null,
			'TNRC_DSTC'					:null,
			'OTP_VNDR_CD1'				:'001',
			'OTP_SRNO1'					:'99209015',
			'INQ_REQT_INSTCD'			:null,
			'GBPR_LMTD_DSTC'			:null,
			'BOCD'						:null,
			'GRNY_TERM_STDT'			:null,
			'GRNY_TERM_EDDT'			:null,
			'OTP_STCD'					:null,
			'ERR_NTM'					:null,
			'LST_ATHN_ERR_DTM'			:null,
			'LST_ERR_OCRN_INSTCD'		:null,
			'OTIN_ACDT_RCVR_YN'			:null,
			'ACDT_APLC_DTM'				:null,
			'UZ_REG_YN'					:null,
			'UZ_REG_DTM'				:null,
			'ISS_FIN_INSTCD'			:null,
			'ISS_DTM'					:null,
			'USER_IDNT_CD'				:null,
			'ADDT_USER_IDNT_CD'			:null,
			'ATMT_REG_DVCD'				:null,
			'OTIN_ATMT_REG_TRGT_CO_CD'	:null,
			'OTIN_ATMT_REG_OTP_SRNO'	:null
		}
	}
	,'API_RacOtprOtps0300' : {	// OTP사고회복본거래
		'BT_NAME'	: 'API_RacOtprOtps0300',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'MESG_LEN'			:'0134',
			'MESG_CLSC_CD'		:'0200',
			'MESG_DVCD'			:'200305',
			'BKCD'				:'101',
			'BO_NO'				:'01',
			'RRNO'				:'9710211158521',
			'INDV_CORP_DSTC'	:'2',
			'RESP_CD'			:null,
			'TNRC_DSTC'			:null,
			'OTP_VNDR_CD1'		:'001',
			'OTP_SRNO1'			:'99209015',
			'OTP_VNDR_CD2'		:null,
			'OTP_SRNO2'			:null,
			'OTP_OTPT_VAL1'		:null,
			'OTP_OTPT_VAL2'		:null,
			'TX_KND'			:null,
			'GBPR_LMTD_DSTC'	:null,
			'UZ_REG_YN'			:null,
			'UZ_REG_INSTCD'		:null,
			'ERR_NTM'			:null,
			'GRNY_TERM_STDT'	:null,
			'GRNY_TERM_EDDT'	:null,
			'LCKN_RESP_VAL'		:null
		}
	}
/* ------------------------------------------------ [실명확인] ------------------------------------------------ */
	,'API_ComMony0101_01' : {	// 비대면 인증정보 등록
		'BT_NAME'	: 'API_ComMony0101_01',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'RNNO'					:'8007251038012',
			'NECT_PROD_DTLS_KNCD'	:'10',
			'BZWR_UNQ_LTRS'			:'N10',
			'NECT_TLCL_ATHN_YN'		:'N',
			'NECT_OWON_ATHN_YN'		:'Y',
			'NECT_ATHN_TRGT_YN'		:'Y',
			'NECT_PIN_NO'			:'',
			'NECT_ATHN_BKCD'		:'295',
			'NECT_ATHN_ACNO'		:'11101111111',
			'MNRC_AMT'				:'',
			'CPNO'					:'01041779639',
			'MSG'					:'',
			'MNRC_ACNO'				:'',
			'CSNO'					:'10100523388',
			'NECT_TRN_NO'			:'202306270843747'
			//'HDPT_LEN'				:'490',
			//'MESG_DVCD'				:'Q',
			//'SBCD'					:'101',
			//'CSNO'					:'10100523396',
			//'CLPH_OS_DVCD'			:'AOS',
			//'MESG_UNNO'				:'202306270843747',
		}
	}
	,'API_NomAcco0900_03' : {	// 비대면 인증대상고객 조회
		'BT_NAME'	: 'API_NomAcco0900_03',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'RNNO'			:''
		}
	}
	,'API_ComAddr0101' : {	// 도로명주소 조회1
		'BT_NAME'	: 'API_ComAddr0101',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
//			'ADDR_DSTC'		:'02',
//			'TRL_DSTC'		:null,
//			'CCW_CD'		:null,
//			'ZPCD'			:'13981',
//			'INPT_ADDR'		:null,
//			'ZPCD_MNGNO'	:'602',
//			'ZPCD_ADDR'		:'경기 안양시 만안구 박달로497번길 57 한신휴플러스타운',
//			'DTAD'			:'206',
//			'FLAG'			:'2'
			'ADDR_DSTC'		:'03',
			'TRL_DSTC'		:null,
			'CCW_CD'		:null,
			'ZPCD'			:null,
			'INPT_ADDR'		:'박달로497번길 57',
			'ZPCD_MNGNO'	:null,
			'ZPCD_ADDR'		:null,
			'DTAD'			:null,
			'FLAG'			:'1'
		}
	}
	,'API_ComMony0100_01' : {	// 비대면 1원이체 인증
		'BT_NAME'	: 'API_ComMony0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'CSNO'				:'10100523396',
			'BZWR_UNQ_LTRS'		:'N10',
			'NECT_TRN_NO'		:'202306270843747',
			'RNNO'				:'8007251038012',
			'NECT_ATHN_BKCD'	:'295',
			'NECT_ATHN_ACNO'	:'11101111111',
			'TRNF_SCS_YN'		:'Y',
			'NECT_ATHN_STR'		:'SB0909',
			'NECT_CMPL_YN'		:null
		}
	}
	,'API_ComCert0200_01' : {	// 신분증진위확인
		'BT_NAME'	: 'API_ComCert0200_01',
		'PARAMS'	: {
			'JEX_BANKCODE':'101',
			'BZWR_UNQ_LTRS':'N10',
			'MCN_IDNT_ID_NO':'1234',
			'MCN_MODL_ID':'1234',
			'OS_KIND_VAL':'IOS',
			'TRN_UNNO':'',
			'IDC_DVCD':'02',
			'REVS_ITEM_DVCD':'01',
			'RNNO':'8007251038012',
			'IDC_NM':'최규현',
			'ISS_DT':'00000000',
			'LCNS_NO':'119961591570',
			'VTRN_NO':'000000000',
			'BOCD':'',
			'USRNO':'',
			'POTO_CHRC_VLTN_SCR':'',
			'NECT_DVCD':'10',
			'FILLER2':'',
			'FINGER_PR_CHRC_LEN':'0000',
			'FINGER_PR_CHRC':'',
			'POTO_INFO_LEN':'',
			'POTO_INFO':'',
			'NECT_TRN_NO':'202306270843747',
		}
	}
/* ------------------------------------------------ [고객] ------------------------------------------------ */
	,'API_NomAcco0400_02' : {	// 고객정보 조회
		'BT_NAME'	: 'API_NomAcco0400_02',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'NRID'						:'9107052075418',
			'NECT_PROD_DTLS_KNCD'		:'',
			'NECT_INTG_PDCD'			:'',
			'EXST_CUST_YN'				:null,
			'CUST_NM'					:null,
			'CUST_ENSN_NM'				:null,
			'CUST_CNTA_DVCD'			:null,
			'PSNT_RSDC_ZPCD'			:null,
			'PSNT_RSDC_BLDG_MNGNO'		:null,
			'PSNT_RSDC_ADDR'			:null,
			'PSNT_RSDC_REFAD'			:null,
			'PSNT_RSDC_DTAD'			:null,
			'DM_SEND_DVCD'				:null,
			'WRST_ZPCD'					:null,
			'WRST_BLDG_MNGNO'			:null,
			'WRST_ADDR'					:null,
			'WRST_REFAD'				:null,
			'WRST_DTAD'					:null,
			'SMS_RCMS_YN'				:null,
			'ALTALK_RCMS_YN'			:null,
			'PRTB_TSNO'					:null,
			'PRTB_TFNO'					:null,
			'PRTB_TVNO'					:null,
			'EML_RCMS_YN'				:null,
			'EMAD'						:null,
			'CRIF_UZ_DVCD'				:null,
			'CRIF_OFR_DVCD'				:null,
			'PROD_SCV_LTRS_YN'			:null,
			'PROD_SCV_EML_YN'			:null,
			'PROD_SCV_TEL_YN'			:null,
			'PROD_SCV_DM_YN'			:null,
			'INDV_STND_OCPT_CLCD'		:null,
			'CDD_REXC_DUE_DT'			:null,
			'PRE_EXIS_DMNB_ACCO_CCNT'	:null,
			'PRE_EXIS_DMNB_ACCO_1'		:null,
			'PRE_EXIS_DMNB_ACCO_2'		:null,
			'PRE_EXIS_DMNB_ACCO_3'		:null,
			'INBN_ID_PRE_EXIS_YN'		:null,
			'ELEC_FNTR_HSTR_STCD'		:null,
			'LVTP_MNBD_DVCD'			:null,
			'PRE_CNT'					:null,
			'PRE_NECT_TRN_NO'			:null,
			'PRE_NECT_PROD_DTLS_KNCD'	:null,
			'CSNO'						:''
		}
	}
	,'API_PhotoTest' : {	// 고객정보 이미지 테스트
		'BT_NAME'	: 'API_PhotoTest',
		'PARAMS'	: {
			'FRST_TRNM_CHNL_DVCD'               : 'API',
			'JEX_BANKCODE'						:'101',
			'PHOTO'								:'/9j/4AAQSkZJRgABAQAASABIAAD/4QBYRXhpZgAATU0AKgAAAAgAAgESAAMAAAAB\r\nAAEAAIdpAAQAAAABAAAAJgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAADuKAD\r\nAAQAAAABAAACWAAAAAD/7QA4UGhvdG9zaG9wIDMuMAA4QklNBAQAAAAAAAA4QklN\r\nBCUAAAAAABDUHYzZjwCyBOmACZjs+EJ+/8AAEQgCWAO4AwERAAIRAQMRAf/EAB8A\r\nAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAAB\r\nfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYn\r\nKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeI\r\niYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh\r\n4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYH\r\nCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRC\r\nkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZX\r\nWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKz\r\ntLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/bAEMA\r\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\r\nAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\r\nAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/dAAQAd//aAAwD\r\nAQACEQMRAD8A/rluI7Lb57NPC6qiskY3gk4Ct5QUNgElhhlJxlVOct864JxvG/e/\r\n/gKt0e60f52kj2r8yXMmnre1v+Gve99O21+WNTU9UNk0cMmm3l/bzxZW8s1Wa3Dm\r\n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\r\nGt6rFqsUNwI57eze',
			'MCN_IDNT_ID_NO'					:'d99cccb7-3b9d-4da4-8f32-21c483c45aca'  //'d99cccb7-3b9d-4da4-8f32-21c483c45aca'
		}
	}
	,'API_NomAcco0400_01' : {	// 고객정보 등록
		'BT_NAME'	: 'API_NomAcco0400_01',
		'PARAMS'	: {
			//'FRST_TRNM_CHNL_DVCD'               :'API',
			//'JEX_BANKCODE'						:'101',
			'PROD_GDNC_MTH_TWO_XN'				:'N',
			'PSNT_RSDC_REF_ITEM_NM'				:'(공덕동,서울신용보증재단)',
			'NECT_PROD_DTLS_KNCD'				:'10',
			'CUST_CNTA_DVCD'					:'09',
			'CRIF_UZ_DVCD'						:'02',
			'CDD_OCPT_DVCD'						:'3710',
			'CDD_IDT_CNFR_CERT_ISS_DT'			:'19991205',
			'ANIN_DVCD'							:'8010',
			'PSNT_RSDC_BLDG_MNGNO'				:'1144021130010200016300000',
			'NECT_IDC_KIND_DVCD'				:'2',
			//'PHOTO'								:'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',
			'PHOTO':'iVBORw0KGgoAAAANSUhEUgAAAGQAAAA2CAIAAAC+xqv/AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA4RpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQ1IDc5LjE2MzQ5OSwgMjAxOC8wOC8xMy0xNjo0MDoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo0MmFjMjNkNC02NTQ4LTA2NDktYjBjOC02ODcwODAzNzZhYjQiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NTk2OTlDOUI4MkVBMTFFQTkzQjdDNjAxMzIwMkUzRDkiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NTk2OTlDOUE4MkVBMTFFQTkzQjdDNjAxMzIwMkUzRDkiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTkgKFdpbmRvd3MpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6MDJhNWRhNGYtM2Q0MS1hMDQyLTlmZmEtODBkNGY4NjJiM2E2IiBzdFJlZjpkb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6Yjg3YzIxODEtNWMwOC1lOTQ5LWJkYjUt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',
			'PSNT_RSDC_BSIC_ADDR'				:'서울 마포구 마포대로 163',
			'PRTB_TVNO'							:'7417',
			'NECT_INTG_PDCD'					:'240070',
			'PSNT_RSDC_DTAD'					:'14',
			'ALTALK_RCMS_YN'					:'N',
			'PROD_GDNC_MTH_THR_XN'				:'N',
			'CDD_JBCF'							:'',
			'CUST_NM'							:'김민지',
			'INDV_TRN_CPT_ETC_CNTN'				:'',
			'CUST_REG_PRGS_YN'					:'Y',
			'PROD_GDNC_MTH_ONE_XN'				:'N',
			'CUST_ENSN_NM'						:'',
			'EML_RCMS_YN'						:'N',
			'DM_SEND_DVCD'						:'99',
			'PRTB_TFNO'							:'4560',
			'CDD_IDT_CNFR_CERT_ISS_INST'		:'**',
			'BZWR_UNQ_LTRS'						:'N20',
			'INDV_STND_OCPT_CLCD'				:'22129',
			'SMS_RCMS_YN'						:'N',
			'PSNT_RSDC_ZPCD'					:'04130',
			'EXST_CUST_YN'						:'Y',
			'CSNO'								:'10100523388',
			'RL_OWNR_YN'						:'Y',
			'INDV_NEW_TRN_PRPS_INPM_PAYM_YN'	:'N',
			'EKD_WRCN_ACPT_CCNT'				:'4',
			'IN_REC':[
						{'NECT_WRCN_KIND_NO'	:'101011011'},
						{'NECT_WRCN_KIND_NO'	:'101011001'},
						{'NECT_WRCN_KIND_NO'	:'101011003'},
						{'NECT_WRCN_KIND_NO'	:'101011002'}
			],//O049011011:Y,O049011001:Y,O049011003:Y,O049011002:Y
			'NECT_SBCD'							:'101',
			'INDV_NEW_TRN_PRPS_ETC_CNTN'		:'',
			'INDV_NEW_TRN_PRPS_DVCD'			:'3010',
			'INDV_NEW_TRN_PRPS_MNPB_PAYM_YN'	:'N',
			'MCN_IDNT_ID_NO'					:'201812pocof1',   //d99cccb7-3b9d-4da4-8f32-21c483c45aca',  //'d99cccb7-3b9d-4da4-8f32-21c483c45aca'
			'EMAD'								:'',
			'INDV_NEW_TRN_PRPS_PBTX_PAYM_YN'	:'N',
			'INDV_TRN_CPT_DVCD'					:'7010',
			'CDD_RSDN_DVCD'						:'Y',
			'CRIF_OFR_DVCD'						:'02',
			'TOT_AST_AMT_DVCD'					:'51',
			'PROD_GDNC_MTH_FUR_XN'				:'N',
			'CDD_OCPT_ETC'						:'',
			'CDD_IDT_CNFR_CERT_DVCD'			:'13020',
			'NRID'								:'9107052075418',
			'BOCD'								:'',
			'PRTB_TSNO'							:'01029824112'
		}
	}
	// NECT_WRCN_KIND_NO
/* ------------------------------------------------ [수신] ------------------------------------------------ */
	,'API_NomAcco0700_02' : {	// 비과세 한도조회
		'BT_NAME'	: 'API_NomAcco0700_02',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'SVNG_KIND'			:'41',
			'RNNO'				:'',
			'LVTP_MNBD_DVCD'	:'0',
			'ENTR_AMT'			:null,
			'UUSE_AMT'			:null
		}
	}
	,'API_NomAcco0700_03' : {	// 정기예금 신규상담조회
		'BT_NAME'	: 'API_NomAcco0700_03',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'PDCD'					:'240038',
			'SINT_CMIN_DVCD'		:'1',
			'CNTR_DVCD'				:'1',
			'CNPD_MMCO'				:'12',
			'CNPD_DCNT'				:'',
			'NEW_DT'				:'20190905',
			'EXPT_DT'				:'20200905',
			'TXTN_DVCD'				:'11',
			'CNTR_AMT'				:'1000000',
			'APL_INRT'				:null,
			'MN_PRVS_INTS'			:null,
			'REMN_DCNT_PRVS_INTS'	:null,
			'TOT_INTS'				:null,
			'TOT_RVN_ALTX'			:null,
			'SBTR_MN_INTS'			:null,
			'SBTR_REMN_DCNT_INTS'	:null,
			'SBTR_TOT_INTS'			:null,
			'APL_INRT2'				:null,
			'MN_PRVS_INTS2'			:null,
			'REMN_DCNT_PRVS_INTS2'	:null,
			'TOT_INTS2'				:null,
			'TOT_RVN_ALTX2'			:null,
			'SBTR_MN_INTS2'			:null,
			'SBTR_REMN_DCNT_INTS2'	:null,
			'SBTR_TOT_INTS2'		:null
		}
	}
	,'API_NomAcco0800_02' : {	// 적금 신규상담조회
		'BT_NAME'	: 'API_NomAcco0800_02',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'PDCD'				:'101002',
			'CALC_DVCD'			:'1',
			'CNTR_DVCD'			:'1',
			'CNPD_MMCO'			:'12',
			'CNPD_DCNT'			:'0',
			'NEW_DT'			:'20190704',
			'EXPT_DT'			:'',
			'TXTN_DVCD'			:'11',
			'CNTR_AMT'			:'',
			'MN_PYMN_AMT'		:'1000000',
			'CALC_CNTR_AMT'		:null,
			'CALC_MN_PYMN_AMT'	:null,
			'TOT_INSM_AMT'		:null,
			'PRVS_INTS'			:null,
			'SPEL_INTS'			:null,
			'APL_INRT'			:null,
			'SPEL_INRT'			:null,
			'RVN_ALTX'			:null,
			'SBTR_PRVS_AMT'		:null,
			'CALC_CNTR_AMT2'	:null,
			'CALC_MN_PYMN_AMT2'	:null,
			'TOT_INSM_AMT2'		:null,
			'PRVS_INTS2'		:null,
			'SPEL_INTS2'		:null,
			'APL_INRT2'			:null,
			'SPEL_INRT2'		:null,
			'RVN_ALTX2'			:null,
			'SBTR_PRVS_AMT2'	:null
		}
	}
	,'API_NomAcco0600_01' : {	// 예적금 신청
		'BT_NAME'	: 'API_NomAcco0600_01',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'SBCD'						:'101',
			'CSNO'						:'10100523396',
			'BZWR_UNQ_LTRS'				:'N10',
			'NECT_TRN_NO'				:'202306270843747',
			'RNNO'						:'8007251038012',
			'NECT_CMMD_NEW_DVCD'		:'Y',
			'NECT_CMMD_ACNO'			:null,
			'NECT_TMDP_NEW_YN'			:null,
			'NECT_INSV_NEW_YN'			:null,
			'NECT_ATTR_REG_YN'			:null,
			'NECT_CMS_REG_YN'			:null,
			'FILLER'					:null,
			'NECT_CMMD_PDCD'			:'130003',
			'NECT_CMMD_ACCO_PWD'		:'1004',
			'NECT_CMMD_MNRC_AMT'		:null,
			'NECT_TMDP_TXTN_DVCD'		:null,
			'NECT_TMDP_SINT_CMIN_DVCD'	:null,
			'NECT_TMDP_PDCD'			:null,
			'NECT_TMDP_ACCO_PWD'		:'',
			'NECT_TMDP_MNRC_AMT'		:null,
			'TMDP_NECT_CNPD_DVCD'		:null,
			'NECT_TMDP_CNPD_MMCO'		:null,
			'NECT_TMDP_CNPD_DCNT'		:null,
			'NECT_TMDP_EXPT_DT'			:null,
			'NECT_INSV_TXTN_DVCD'		:null,
			'NECT_INSV_PDCD'			:null,
			'NECT_INSV_ACCO_PWD'		:'',
			'NECT_INSV_MNRC_AMT'		:null,
			'INSV_NECT_CNPD_DVCD'		:null,
			'NECT_INSV_CNPD_MMCO'		:null,
			'NECT_INSV_CNPD_DCNT'		:null,
			'NECT_INSV_CNTR_AMT'		:null,
			'NECT_INSV_MN_PYMN_AMT'		:null,
			'NECT_CMS_ACNO'				:null,
			'NECT_CMS_BKCD'				:null,
			'NECT_WRCN_CCNT'			:null,
			'IN_REC'					:null
		}
	}
	,'API_NomChek0800_01' : {	// 체크카드 신청
		'BT_NAME'	: 'API_NomChek0800_01',
		'PARAMS'	: {
			'JEX_BANKCODE'					:'158',
			'NECT_SBCD'						:'158',
			'NECT_CSNO'						:'15802126948',
			'BZWR_UNQ_LTRS'					:'N40',
			'NECT_TRN_NO'					:'201907120006139',
			'NRID'							:'',
			'FRGN_DVCD'						:'2',
			'ENSN_NM'						:'LEEJAEHYOUNG',
			'CHCR_ALNC_CO_CD'				:'952637',
			'NECT_CMMD_USE_YN'				:'N',
			'ACNO'							:null,
			'PWD'							:'',
			'SMDD'							:'12',
			'CASH_CARD_FNCT_USE_DVCD'		:'1',
			'NECT_TRN_TI1_LMIT_AMT'			:'100',
			'NECT_TRN_DD1_LMIT_AMT'			:'100',
			'MN_BTWN_LMIT_AMT'				:'100',
			'BIL_SEND_MTH_DVCD'				:'1',
			'BLAD_ADDR_DVCD'				:'1',
			'BLAD_ZPCD'						:'',
			'BLAD_BSIC_ADDR'				:'',
			'BLAD_ADDR'						:'',
			'BLAD_ADDR_REF_CNTN'			:'',
			'BLAD_ADDR_PNU_VAL'				:'',
			'CMP_NM'						:'',
			'WORK_DEPT_NM'					:'',
			'WRST_TLNO1'					:'',
			'WRST_TLNO2'					:'',
			'WRST_TLNO3'					:'',
			'EML_ACCP_AGR_DVCD'				:'2',
			'EMAD'							:'',
			'BC_MBCD_PRIO_ISS_YN'			:'2',
			'UZ_SGST_TEL_AGR_NT_AGR_DVCD'	:'1',
			'UZ_SGST_SMS_AGR_NT_AGR_DVCD'	:'1',
			'UZ_SGST_INWT_AGR_NT_AGR_DVCD'	:'1',
			'UZ_SGST_EML_AGR_NT_AGR_DVCD'	:'1',
			'NECT_BC_SMS_PROP_DVCD'			:'2',
			'BC_BNKB_BLNC_MRK_YN_DVCD'		:'1',
			'FILLER'						:null,
			'BC_WRCN_ACPT_CNT'				:null,
			'IN_REC'						:null
		}
	}
	,'API_CarLotr0100' : {	// 롯데카드 신청
		'BT_NAME'	: 'API_CarLotr0100',
		'PARAMS'	: {
			'JEX_BANKCODE'					:'566',
			'TRN_DVCD'						:'01',
			'ACPT_DT'						:'20190903',
			'CUST_NM'						:'이학현11',
			'ENSN_NM'						:null,
			'CPNO'							:'01025803694',
			'DMFR_DVCD'						:'02',
			'CASH_CARD_FNCT_USE_DVCD'		:'1',
			'LTC_ALNC_PDCD'					:'C312374',
			'ACNO'							:'10101130318575',
			'PWD'							:'',
			'SGST_USRNO'					:'590734',
			'INDV_INFO_COLT_UZ_AGR_DVCD'	:'01',
			'INDV_INFO_OFR_AGR_DVCD'		:'01',
			'PROD_SVC_COLT_UZ_AGR_DVCD'		:'01',
			'PROD_SVC_INFO_OFR_AGR_DVCD'	:'01',
			'CASH_CARD_UZ_STPL_AGR_YN_DVCD'	:'01',
			'ELEC_FNTR_BSIC_STPL_AGR_DVCD'	:'01',
			'CARD_STMT_INST_BKCD'			:'050',
			'WB_ACNO'						:'10101130318575'
		}
	}
	,'API_NomBrea0900' : {	// 수신-카드상품 진행상태 조회
		'BT_NAME'	: 'API_NomBrea0900',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'566',
			'NRID'					:'',
			'NECT_TRN_NO'			:'201907180007528',
			'NECT_PIN_NO'			:'',
			'NECT_PROD_DTLS_KNCD'	:'20'
		}
	}
	,'API_NomBrea0700' : {	// 수신-카드상품 간략조회
		'BT_NAME'	: 'API_NomBrea0700',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'566',
			'NRID'			:'9301182179011',
			'CNT'			:'0'
		}
	}
	,'API_NomAcco0400_03' : {	// 수신-카드상품 신청취소
		'BT_NAME'	: 'API_NomAcco0400_03',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'566',
			'NECT_TRN_NO'				:'201912230025284',
			'NECT_PROD_DTLS_KNCD'		:'20',
			'NECT_CUST_REG_CAN_YN'		:'N'
		}
	}
/* ------------------------------------------------ [전자금융] ------------------------------------------------ */
	,'API_NomAcco0900_01' : {	// 전자금융 이용가능ID조회
		'BT_NAME'	: 'API_NomAcco0900_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'USER_ID'			:'test12345',
			'MESG'				:null,
		}
	}
	,'API_NomAcco0900_02' : {	// 전자금융 이용 신청
		'BT_NAME'	: 'API_NomAcco0900_02',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'SBCD'					:'101',
			'CSNO'					:'10101284797',
			'BZWR_UNQ_LTRS'			:'N10',
			'NECT_TRN_NO'			:'202307050848458',
			'RNNO'					:'',
			'USER_ID'				:'test12345',
			'TI1_TRNF_LMIT_AMT'		:'100000',
			'DD1_TRNF_LMIT_AMT'		:'1000000',
			'PWD'					:'chlrbgus1!',
			'OTP_VNDR_CD'			:'',
			'OTP_SRNO_VAL'			:'',
			'MBL_OTP_SRNO_VAL'		:''
		}
	}
/* ------------------------------------------------ [대출] ------------------------------------------------ */
	,'API_NomSign1200_01' : {	// 대출 신청
		'BT_NAME'	: 'API_NomSign1200_01',
		'PARAMS'	: {
			'JEX_BANKCODE'					: '101',
			'NRID'							: '',
			'CUST_NM'						: '정성인',
			'PRTB_TSNO'						: '010',
			'PRTB_TFNO'						: '5496',
			'PRTB_TVNO'						: '2324',
			'NECT_PROD_DTLS_KNCD'			: '60',
			'PDCD'							: '780002',
			'CPT_USG_DVCD'					: '3003',
			'LOAN_PROP_AMT'					: '10000000',
			'LOAN_TERM_DT'					: '12',
			'LOAN_PROP_OPNG_DT'				: '20190711',
			'PROP_RPY_TERM_MMCO'			: null,
			'LOAN_RMTN_BKCD'				: '296',
			'LOAN_RMTN_BANK_ACNO'			: '11101111111',
			'CMS_YN'						: 'Y',
			'CMS_BKCD'						: '296',
			'CMS_ACNO'						: '11101111111',
			'SCRG_APL_YN'					: 'N',
			'ENTR_CUST_DVCD'				: '1',
			'SGI_INSU_INCM_AMT_DVCD'		: '01',
			'BRNO'							: '1234567890',
			'INDV_BUSI_FRNM_NM'				: '재직회사상호',
			'WORK_KIND'						: '3750',
			'BUSI_KIND'						: 'A01121',
			'ENCM_DT'						: '20070101',
			'SCRG_ANL_INCM_AMT'				: null,
			'CUST_INPT_ANL_INCM_AMT'		: '20000000',
			'SGI_INSU_LOAN_DVCD'			: '1',
			'SGI_INSU_SLE_CHNL_DVCD'		: '21',
			'SGI_INSU_STDL_PROD_DVCD'		: '1',
			'CRIF_COLT_SLCT_AGR_YN'			: 'Y',
			'CRIF_INQ_AGR_YN'				: 'Y',
			'CRIF_OFR_MNDR_AGR_YN'			: 'Y',
			'DBTR_CUST_IDNT_INFO_AGR_YN'	: 'Y',
			'INDV_INFO_AGR_MTCD'			: '2',
			'SGST_USRNO'					: '',
			'CUST_REG_YN'					: null,
			'CUST_ADDR'						: null,
			'CUST_TLNO'						: null,
			'HLIN_SBSR_DVCD'				: null,
			'HLIN_QLFC_GNLS_ISS_NO'			: null,
			'HLIN_QLFC_GNLS_ISS_DT'			: null,
			'HLIN_BZPL_NM'					: null,
			'HLIN_SBSR_DSTC_CNTN'			: null,
			'HLIN_QLFC_ACQS_DT'				: null,
			'HLIN_QLFC_FRFT_DT'				: null,
			'HLIN_STDT'						: null,
			'HLIN_EDDT'						: null,
			'HLIN_PAYM_DETL_USE_PPCD'		: null,
			'HLIN_PAYM_DETL_DTLS_USG_DVCD'	: null,
			'HLIN_PAYM_DETL_ISS_NO'			: null,
			'HLIN_PAYR_NO'					: null,
			'HLIN_PAYM_ISS_DT'				: null,
			'HLIN_PAYT_SBSR_GB'				: null,
			'HLIN_YNTA_NTF_AMT'				: null,
			'HLIN_YNTA_PAYM_AMT'			: null,
			'NTS_SCRG_DTA_PPCD'				: null,
			'NTS_SCRG_DTA_PRPL_DVCD'		: null,
			'BUSI_REG_CERT_ISS_NO'			: null,
			'HLIN_LIST_CNT'					: null,
			'HLIN_LIST'						: null,
			'BUSI_LIST_CNT'					: null,
			'BUSI_LIST'						: null,
			'NECT_WRCN_CCNT'				: '02',
			'NECT_WRCN_LIST'				: [
				{'NECT_WRCN_KIND_NO': '031011021'},
				{'NECT_WRCN_KIND_NO': '031011022'}
			],
			'DENL_RSN_GDNC_YN'				: 'N',
			'DOC_CNT'						: '1',
			'ADDT_PROP'						: [
				{
					'NECT_LOAN_BILN_DOC_DVCD'	: '000',
					'BILN_DOC_ITEM_DVCD'		: '001',
					'BILN_DOC_ITEM_NM'			: '주거지자가여부',
					'BILN_DOC_ITEM_CNTN'		: '자가'
				}
			],
			'CNT'							: null,
			'IN_CNT'						: null,
			'CNT1'							: null,
			'IN_CNT1'						: null,
			'CNT2'							: null,
			'IN_CNT2'						: null,
			'NECT_SBCD'						: '325',
			'NECT_CSNO'						: '32501495648',
			'BZWR_UNQ_LTRS'					: 'N60',
			'NECT_TRN_NO'					: '201907110005781',
			'PADD'							: '11',
			'HSNG_OWN_DVCD'					: '2'
		}
	}
	,'API_NomSign1000' : {	// 대출 신청내역 조회
		'BT_NAME'	: 'API_NomSign1000',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'NRID'			:'',
			'INQ_CCNT'		:null,
			'IN_REC'		:null
		}
	}
	,'API_NomSign1001' : {	// 대출 신청취소
		'BT_NAME'	: 'API_NomSign1001',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'NECT_TRN_NO'				:'201907190008166',
			'NECT_PROD_KNCD'			:'70',
			'NECT_CUST_REG_CAN_YN'		:'N'
		}
	}
	,'API_NomKred0400' : {	// 햇살론 신청
		'BT_NAME'	: 'API_NomKred0400',
		'PARAMS'	: {
			'JEX_BANKCODE'					:'067',
			'CUST_NM'						:'정성인',
			'NRID'							:null,
			'SNLN_CMCM_DVCD'				:null,
			'CNPL'							:'01054962324',
			'SNLN_EMLM_DVCD'				:'01',
			'FILLER0'						:null,
			'CNSG_GRNY_OCPT_CLCD'			:'02',
			'FILLER1'						:null,
			'WRST_NM'						:'직장',
			'JBTT_NM'						:'직위',
			'CHRG_BZWR_NM'					:'담당',
			'WRST_TLNO'						:'01054962324',
			'FILLER2'						:null,
			'BRNO'							:'1234567890',
			'FILLER3'						:null,
			'RPR_NM'						:'대표',
			'WRST_ZPCD'						:'',
			'WRST_BLDG_MNGNO'				:'',
			'WRST_ADDR'						:null,
			'WRST_REFAD'					:'',
			'WRST_DTAD'						:'',
			'RFM_LNBR_ZPCD_SRNO'			:null,
			'ADDR_INQ_RESP_CD'				:null,
			'ENCM_DT'						:'달력선택',
			'SNLN_DWAR_OWN_DVCD'			:'02',
			'FILLER4'						:null,
			'CUST_INPT_ANL_INCM_AMT'		:'100',
			'CPT_USG_CNTN'					:'생계',
			'LOAN_PROP_AMT'					:'1000',
			'SNLN_LTERM_CD'					:'01',
			'FILLER5'						:null,
			'SNLN_INRT_CHG_CYCL_CD'			:'02',
			'FILLER6'						:null,
			'LOAN_RMTN_BKCD'				:'296',
			'FILLER7'						:null,
			'LOAN_RMTN_BANK_ACNO'			:'11101111111',
			'FILLER8'						:null,
			'DIMR_PRGS_STCD'				:null,
			'CRIF_COLT_MNDR_AGR_YN'			:null,
			'CRIF_INQ_AGR_YN'				:null,
			'CRIF_OFR_MNDR_AGR_YN'			:null,
			'UNQ_IDNT_INFO_AGR_YN'			:null,
			'INDV_INFO_COLT_UZ_AGR_YN'		:null,
			'CRFC_DN_VAL'					:null,
			'TRMN_IPAD'						:null,
			'ATSH_ISS_INST_VAL'				:null,
			'ATSH_MNGNO'					:null,
			'ATSH_ISS_DT'					:null,
			'ATSH_EDDT'						:null,
			'SGNR_CMPL_DDTM'				:null,
			'DENL_RSN_GDNC_YN'				:null,
			'SGST_USRNO'					:'',
			'SCRG_APL_YN'					:null,
			'SCRG_ANL_INCM_AMT'				:null,
			'HLIN_SBSR_DVCD'				:null,
			'HLIN_QLFC_GNLS_ISS_NO'			:null,
			'HLIN_QLFC_GNLS_ISS_DT'			:null,
			'HLIN_BZPL_NM'					:null,
			'HLIN_SBSR_DSTC_CNTN'			:null,
			'HLIN_QLFC_ACQS_DT'				:null,
			'HLIN_QLFC_FRFT_DT'				:null,
			'HLIN_STDT'						:null,
			'HLIN_EDDT'						:null,
			'HLIN_PAYM_DETL_USE_PPCD'		:null,
			'HLIN_PAYM_DETL_DTLS_USG_DVCD'	:null,
			'HLIN_PAYM_DETL_ISS_NO'			:null,
			'HLIN_PAYR_NO'					:null,
			'HLIN_PAYM_ISS_DT'				:null,
			'HLIN_PAYT_SBSR_GB'				:null,
			'HLIN_YNTA_NTF_AMT'				:null,
			'HLIN_YNTA_PAYM_AMT'			:null,
			'NTS_SCRG_DTA_PPCD'				:null,
			'NTS_SCRG_DTA_PRPL_DVCD'		:null,
			'BUSI_REG_CERT_ISS_NO'			:null,
			'QLFC_GNLS_CMP_NCNT'			:null,
			'FILLER9'						:null,
			'HLIN_LIST_CNT'					:null,
			'IN_REC1'						:null,
			'BUSI_LIST_CNT'					:null,
			'IN_REC2'						:null,
			'RRT_DOCU_CNFR_NO'				:null,
			'RRT_PROP_PS_NM'				:null,
			'RRT_PROP_PS_BRDD'				:null,
			'RRT_PROP_DT'					:null,
			'RRT_HHLD_NM'					:null,
			'RRT_HHLD_CMPS_RSN'				:null,
			'RRT_HHLD_CMPS_DT'				:null,
			'RRT_ADDR_HSTR_IFMY_CNT'		:null,
			'IN_REC3'						:null,
			'RRT_GNRT_CSTN_CNT'				:null,
			'IN_REC4'						:null,
			'RRT_ADDR_CHG_CNT'				:null,
			'IN_REC5'						:null
		}
	}
	,'API_NomSign2900_01' : {	// 종합통장대출 신청1
		'BT_NAME'	: 'API_NomSign2900_01',
		'PARAMS'	: {
			'JEX_BANKCODE'					:'101',
			'NRID'							:'',
			'CUST_NM'						:'정성인',
			'PRTB_TSNO'						:'010',
			'PRTB_TFNO'						:'5469',
			'PRTB_TVNO'						:'2324',
			'DENL_RSN_GDNC_YN'				:'Y',
			'NECT_PROD_DTLS_KNCD'			:'70',
			'PDCD'							:'780002',
			'SCRG_APL_YN'					:'Y',
			'ENTR_CUST_DVCD'				:'1',
			'CPT_USG_DVCD'					:'3002',
			'WRST_NM'						:null,
			'WRST_ZPCD'						:'13981',
			'WRST_BLDG_MNGNO'				:'4117143460910100005700000',
			'WRST_ZPCD_ADDR'				:'',
			'WRST_ADDR_REF_ITEM_NM'			:'',
			'WRST_DTAD'						:'206동1101호',
			'PSNT_RSDC_ZPCD'				:'13981',
			'PSNT_RSDC_BLDG_MNGNO'			:'4117143460910100005700000',
			'PSNT_RSDC_ADDR'				:null,
			'PSNT_RSDC_REF_ITEM_NM'			:'(박달동 한신휴플러스타운)',
			'PSNT_RSDC_DTAD'				:'206동1101호',
			'HSNG_OWN_DVCD'					:'2',
			'INCM_CMPTN_BSDT'				:'20170516',
			'SGST_USRNO'					:'',
			'CAN_SBCD'						:null,
			'CAN_NECT_TRN_NO'				:null,
			'CAN_POSB_STS_YN'				:null,
			'CAN_TRGT_PROP_DT'				:null,
			'CAN_TRGT_AMT'					:null,
			'CAN_TRGT_TSNO'					:null,
			'CAN_TRGT_TFNO'					:null,
			'CAN_TRGT_TVNO'					:null,
			'HLIN_SBSR_DVCD'				:'2',
			'HLIN_QLFC_GNLS_ISS_NO'			:'G201907090703852',
			'HLIN_QLFC_GNLS_ISS_DT'			:'20190709',
			'HLIN_BZPL_NM'					:'주식회사케이씨에스',
			'HLIN_SBSR_DSTC_CNTN'			:'직장가입자',
			'HLIN_QLFC_ACQS_DT'				:'20170516',
			'HLIN_QLFC_FRFT_DT'				:'',
			'HLIN_STDT'						:'201806',
			'HLIN_EDDT'						:'201912',
			'HLIN_PAYM_DETL_USE_PPCD'		:'2',
			'HLIN_PAYM_DETL_DTLS_USG_DVCD'	:'01',
			'HLIN_PAYM_DETL_ISS_NO'			:'11201907096058633',
			'HLIN_PAYR_NO'					:'80722196248',
			'HLIN_PAYM_ISS_DT'				:'20190709',
			'HLIN_PAYT_SBSR_GB'				:'5',
			'HLIN_YNTA_NTF_AMT'				:'237330',
			'HLIN_YNTA_PAYM_AMT'			:'17490',
			'NTS_SCRG_DTA_PPCD'				:null,
			'NTS_SCRG_DTA_PRPL_DVCD'		:null,
			'BUSI_REG_CERT_ISS_NO'			:null,
			'HLIN_LIST_CNT'					:'19',
			'HLIN_LIST'						:[
					{
						'HLIN_PAYM_YM'					: '2018201806',
						'HLTH_INPM_PAYM_NTF_AMT'		: '145140',
						'LNGT_INPM_PAYM_NTF_AMT'		: '10710',
						'HLTH_INPM_PAYM_DETL_PAYM_AMT'	: '145140',
						'LNGT_INPM_PAYM_DETL_PAYM_AMT'	: '10710',
						'HLTH_INPM_INCM_NTF_AMT'		: '0',
						'LNGT_INPM_INCM_NTF_AMT'		: '0',
						'HLTH_INPM_INCM_DETL_PAYM_AMT'	: '0',
						'LNGT_INPM_INCM_DETL_PAYM_AMT'	: '0',
						'HLTH_INPM_RT'					: '000.03120'
					},
					{
						'HLIN_PAYM_YM'					: '2018201807',
						'HLTH_INPM_PAYM_NTF_AMT'		: '145140',
						'LNGT_INPM_PAYM_NTF_AMT'		: '10710',
						'HLTH_INPM_PAYM_DETL_PAYM_AMT'	: '145140',
						'LNGT_INPM_PAYM_DETL_PAYM_AMT'	: '10710',
						'HLTH_INPM_INCM_NTF_AMT'		: '0',
						'LNGT_INPM_INCM_NTF_AMT'		: '0',
						'HLTH_INPM_INCM_DETL_PAYM_AMT'	: '0',
						'LNGT_INPM_INCM_DETL_PAYM_AMT'	: '0',
						'HLTH_INPM_RT'					: '000.03120'
					},
					{
						'HLIN_PAYM_YM'					: '2018201808',
						'HLTH_INPM_PAYM_NTF_AMT'		: '145140',
						'LNGT_INPM_PAYM_NTF_AMT'		: '10710',
						'HLTH_INPM_PAYM_DETL_PAYM_AMT'	: '145140',
						'LNGT_INPM_PAYM_DETL_PAYM_AMT'	: '10710',
						'HLTH_INPM_INCM_NTF_AMT'		: '0',
						'LNGT_INPM_INCM_NTF_AMT'		: '0',
						'HLTH_INPM_INCM_DETL_PAYM_AMT'	: '0',
						'LNGT_INPM_INCM_DETL_PAYM_AMT'	: '0',
						'HLTH_INPM_RT'					: '000.03120'
					},
					{
						'HLIN_PAYM_YM'					: '2018201809',
						'HLTH_INPM_PAYM_NTF_AMT'		: '145140',
						'LNGT_INPM_PAYM_NTF_AMT'		: '10710',
						'HLTH_INPM_PAYM_DETL_PAYM_AMT'	: '145140',
						'LNGT_INPM_PAYM_DETL_PAYM_AMT'	: '10710',
						'HLTH_INPM_INCM_NTF_AMT'		: '0',
						'LNGT_INPM_INCM_NTF_AMT'		: '0',
						'HLTH_INPM_INCM_DETL_PAYM_AMT'	: '0',
						'LNGT_INPM_INCM_DETL_PAYM_AMT'	: '0',
						'HLTH_INPM_RT'					: '000.03120'
					},
					{
						'HLIN_PAYM_YM'					: '2018201810',
						'HLTH_INPM_PAYM_NTF_AMT'		: '145140',
						'LNGT_INPM_PAYM_NTF_AMT'		: '10710',
						'HLTH_INPM_PAYM_DETL_PAYM_AMT'	: '145140',
						'LNGT_INPM_PAYM_DETL_PAYM_AMT'	: '10710',
						'HLTH_INPM_INCM_NTF_AMT'		: '0',
						'LNGT_INPM_INCM_NTF_AMT'		: '0',
						'HLTH_INPM_INCM_DETL_PAYM_AMT'	: '0',
						'LNGT_INPM_INCM_DETL_PAYM_AMT'	: '0',
						'HLTH_INPM_RT'					: '000.03120'
					},
					{
						'HLIN_PAYM_YM'					: '2018201811',
						'HLTH_INPM_PAYM_NTF_AMT'		: '145140',
						'LNGT_INPM_PAYM_NTF_AMT'		: '10710',
						'HLTH_INPM_PAYM_DETL_PAYM_AMT'	: '145140',
						'LNGT_INPM_PAYM_DETL_PAYM_AMT'	: '10710',
						'HLTH_INPM_INCM_NTF_AMT'		: '0',
						'LNGT_INPM_INCM_NTF_AMT'		: '0',
						'HLTH_INPM_INCM_DETL_PAYM_AMT'	: '0',
						'LNGT_INPM_INCM_DETL_PAYM_AMT'	: '0',
						'HLTH_INPM_RT'					: '000.03120'
					},
					{
						'HLIN_PAYM_YM'					: '2018201812',
						'HLTH_INPM_PAYM_NTF_AMT'		: '145140',
						'LNGT_INPM_PAYM_NTF_AMT'		: '10710',
						'HLTH_INPM_PAYM_DETL_PAYM_AMT'	: '145140',
						'LNGT_INPM_PAYM_DETL_PAYM_AMT'	: '10710',
						'HLTH_INPM_INCM_NTF_AMT'		: '0',
						'LNGT_INPM_INCM_NTF_AMT'		: '0',
						'HLTH_INPM_INCM_DETL_PAYM_AMT'	: '0',
						'LNGT_INPM_INCM_DETL_PAYM_AMT'	: '0',
						'HLTH_INPM_RT'					: '000.03120'
					}
				]
			,
			'BUSI_LIST_CNT'		:null,
			'BUSI_LIST'			:null,
			'NECT_WRCN_CCNT'	:'02',
			'NECT_WRCN'			:[
					{'NECT_WRCN_KIND_NO'	: '031011021'},
					{'NECT_WRCN_KIND_NO'	: '031011022'}
				]

		}
	}
	,'API_NomSign3700_01' : {	// 종합통장대출 신청2
		'BT_NAME'	: 'API_NomSign3700_01',
		'PARAMS'	: {
			'JEX_BANKCODE'					:'101',
			'LOAN_PROP_AMT'					:'1000000',
			'NECT_CMMD_NEW_DVCD'			:'Y',
			'NECT_CMMD_ACCO_PWD'			:'',
			'NECT_CMMD_ACNO'				:null,
			'WTCH_ACCO_REG_YN'				:'Y',
			'NECT_INBN_REG_YN'				:'Y',
			'NECT_CHCR_ISS_YN'				:'N',
			'USER_ID'						:'jsi2324',
			'TI1_TRNF_LMIT_AMT'				:'1000000',
			'DD1_TRNF_LMIT_AMT'				:'1000000',
			'CMPH_BNKB_PWD'					:'',
			'OTP_VNDR_CD'					:'',
			'OTP_SRNO_VAL'					:'',
			'FRGN_DVCD'						:null,
			'ENSN_NM'						:null,
			'CHCR_ALNC_CO_CD'				:null,
			'NECT_CMMD_USE_YN'				:null,
			'ACNO'							:null,
			'PWD'							:'',
			'SMDD'							:null,
			'CASH_CARD_FNCT_USE_DVCD'		:null,
			'NECT_TRN_TI1_LMIT_AMT'			:null,
			'NECT_TRN_DD1_LMIT_AMT'			:null,
			'MN_BTWN_LMIT_AMT'				:null,
			'BIL_SEND_MTH_DVCD'				:null,
			'BLAD_ADDR_DVCD'				:null,
			'BLAD_ZPCD'						:null,
			'BLAD_BSIC_ADDR'				:null,
			'BLAD_DTAD'						:null,
			'BLAD_ADDR_PNU_VAL'				:null,
			'BLAD_ADDR_REF_CNTN'			:null,
			'CMP_NM'						:null,
			'WORK_DEPT_NM'					:null,
			'WRST_TLNO1'					:null,
			'WRST_TLNO2'					:null,
			'WRST_TLNO3'					:null,
			'EML_ACCP_AGR_DVCD'				:null,
			'EMAD'							:null,
			'BC_MBCD_PRIO_ISS_YN'			:null,
			'UZ_SGST_TEL_AGR_NT_AGR_DVCD'	:null,
			'UZ_SGST_SMS_AGR_NT_AGR_DVCD'	:null,
			'UZ_SGST_INWT_AGR_NT_AGR_DVCD'	:null,
			'UZ_SGST_EML_AGR_NT_AGR_DVCD'	:null,
			'NECT_BC_SMS_PROP_DVCD'			:null,
			'BC_BNKB_BLNC_MRK_YN_DVCD'		:null,
			'NECT_WRCN_CCNT'				:'02',
			'IN_REC'						:[
				{'NECT_WRCN_KIND_NO'	:'031011021'},
				{'NECT_WRCN_KIND_NO'	:'031011022'}
			]

		}
	}
	,'API_NomDask0700' : {	// 종합통장대출 신청내역 조회
		'BT_NAME'	: 'API_NomDask0700',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'NRID'			:'',
			'INQ_CCNT'		:null
		}
	}
/* ------------------------------------------------ [전자약정] ------------------------------------------------ */
	,'API_NomArrn0400' : {	// 전자약정 본인확인
		'BT_NAME'	: 'API_NomArrn0400',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'NRID'			:'',
			'CUST_NM'		:null,
			'INQ_DVCD'		:'A',
			'SBCD'			:'101'
		}
	}
	,'API_NomArrn0500' : {	// 전자약정 동의서
		'BT_NAME'	: 'API_NomArrn0500',
		'PARAMS'	: {
			'JEX_BANKCODE'					:'101',
			'SBCD'							:'101',
			'NECT_TRN_NO'					:'201907180007863',
			'PDCD'							:'760056',
			'SVBN_GVCR_TRN_STPL_AGR_YN'		:'Y',
			'LOAN_DOC_CNFR_OR_AGR_YN'		:'Y',
			'LOAN_DOC_STRG_OR_KEEP_AGR_YN'	:'Y',
			'FILLER'						:null,
			'CUST_EML_COLT_AGR_YN'			:'Y'
		}
	}
	,'API_NomArrn0500_01' : {	// 전자약정 작성완료
		'BT_NAME'	: 'API_NomArrn0500_01',
		'PARAMS'	: {
			'JEX_BANKCODE'					: '325',
			'SBCD'							: '325',
			'NECT_TRN_NO'					: '201907110005781',
			'PDCD'							: '760205',
			'SVBN_GVCR_TRN_STPL_AGR_YN'		: null,
			'LOAN_DOC_CNFR_OR_AGR_YN'		: null,
			'LOAN_DOC_STRG_OR_KEEP_AGR_YN'	: null,
			'FILLER'						: null,
			'CUST_EML_COLT_AGR_YN'			: null,
			'CMPL_STS'						: '01',
			'SGNR_CMPL_DDTM'				: '2019-07-11 02:37:45',
			'CUST_REG_EMAD'					: '',
			'INFO_COLT_AGR_NT_AGR_DVCD'		: '01',
			'INDV_INFO_LTRS_MSG_AGR_YN'		: 'Y',
			'INDV_INFO_EML_AGR_YN'			: 'Y',
			'INDV_INFO_TEL_AGR_YN'			: 'Y',
			'INDV_INFO_DM_AGR_YN'			: 'Y',
			'INFO_OFR_AGR_NT_AGR_DVCD'		: '01',
			'CMS_IOMN_INDV_INFO_AGR_YN'		: 'Y',
			'CMS_IOMN_UNQ_IDNT_INFO_AGR_YN'	: 'Y',
			'CMS_IOMN_THPR_UZ_AGR_YN'		: 'Y',
			'NECT_TRN_ELEC_CNTR_DVCD'		: '02',
			'FILE_DVCD'						: '21',
			'CMS_FILE_KND'					: 'PDF',
			'CMS_FILE_NM'					: '020_20190423_70112301001_100000000012_06_3.pdf',
			'CMS_AGPP_FILE_LEN'				: null,
			'CMS_FILE'						: null,
			'LOAN_PDCD'						: '760205',
			'OFCL_ELEC_DOCU_ARCH_STCD'		: '01',
			'EML_SEND_STCD'					: '01',
			'AGPP_FILE_STCD'				: '01',
			'NECT_SBCD'						: '325',
			'STRG_FILE_PATH_NM'				: '/dvl/app/approot/src/iform/iform1/iform/output/20190627/20190627204209388911/020_20190423_70112301001_100000000012_06_3.pdf',
			'BZWR_UNQ_LTRS'					: 'N',
			'FORMSEQNO'						: '201907110293',
			'SIGN_DATA'						: '',
			'INPUT_DATA'					: '\'signData\'',
			'NECT_ELEC_AGRM_CHNL_DVCD'		: '01',
			'SECURE_DTTM'					: '20190711023746'
		}
	}
/* ------------------------------------------------ [공통] ------------------------------------------------ */
	,'API_ComSecu0100' : {	// 보안카드지시번호요청
		'BT_NAME'	: 'API_ComSecu0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'USER_ID_12'	:'soonlhh9'
		}
	}
	,'API_ComSecu0200' : {	// 보안카드번호확인
		'BT_NAME'	: 'API_ComSecu0200',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'USER_ID_12'			:'soonlhh9',
			'SECU_CARD_INDC_NO1'	:'28',
			'SECU_CARD_PWD1_700'	:'',
			'SECU_CARD_INDC_NO2'	:'21',
			'SECU_CARD_PWD2_700'	:'',
			'ATSH_ISS_YN'			:null,
			'SECU_CARD_SRNO'		:''
		}
	}
/* ------------------------------------------------ [신규 추가] ------------------------------------------------ */
	,'API_NomAcco0200_01' : {	// 비대면수신상품정보조회
		'BT_NAME'	: 'API_NomAcco0200_01',
		'PARAMS'	: {
			'NECT_PROD_DTLS_KNCD'	:'10',
			'SINT_CMIN_DVCD'		:'',
			'SBCD'					:'101',
			'MONTH'					:'',
			'SPECIAL'				:null
		}
	}
	,'API_NomSign0400_01' : {	// 은행서비스정보조회
		'BT_NAME'	: 'API_NomSign0400_01',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'SBCD'					:'101',
			'NECT_PDCD'				:null,
			'NECT_PROD_DTLS_KNCD'	:'N20',    //10:보통예금, 20:정기예금, 30:적금, 40:BC카드, 41:롯데카드, 50:사잇돌, 60:신용, 70:종합통장, 80:햇살론
			'BASE_DT'				:'20191201',
			'HLDD_YN'				:null,
			'HLDD_DVCD'				:null,
			'HLIN_INCM_CMPTN_BSDT'	:null,
			'APL_DVCD'				:'Y'      // Y:상품서비스시간, X:장애일자, A:전자약정
		}
	}
	,'API_NomAcco0300_01' : {	// 비대면수신상품정보조회
		'BT_NAME'	: 'API_NomAcco0300_01',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'NECT_PROD_DTLS_KNCD'	:null,
			'SINT_CMIN_DVCD'		:null,
			'SBCD'					:'101',
			'PERIOD'				:null,
			'SEARCH'				:null,
			'NECT_PDCD'				:'',
			'ORDER'					:null,
			'NECT_PROD_DTLS_KNCD#1'	:'20',
			'RCMD_YN'				:null
		}
	}
	,'API_NomAcco1200' : {	// 비대면예적금금리정보
		'BT_NAME'	: 'API_NomAcco1200',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'162',
			'SBCD'			:'162',
			'NECT_PDCD'		:'240053'
		}
	}
	,'API_NomAcco1401_01' : {	// 전체직종 검색
		'BT_NAME'	: 'API_NomAcco1401_01',
		'PARAMS'	: {
			'WORKVAL': null,
			'TYPE': '1',
			'CODE': '27242'
		}
	}
	,'API_NomAcco1401_02' : {	// 하위직종 검색
		'BT_NAME'	: 'API_NomAcco1401_02',
		'PARAMS'	: {
			'TYPE': '1',
			'CODE': '52'
		}
	}
	,'API_NomAcco0700_01' : {	// 정기예금 신청
		'BT_NAME'	: 'API_NomAcco0700_01',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'CSNO'						:'10100523388',
			'BZWR_UNQ_LTRS'				:'N10',
			'MESG_UNNO'					:'202307120853961',
			'NECT_TRN_NO'				:'202307120853961',
			'RNNO'						:'9107052075418',
			'NECT_CMMD_NEW_DVCD'		:'Y',
			'NECT_ENTR_EXUS_ACCO_YN'	:'Y',
			'NECT_CMMD_ACNO'			:'',
			'NECT_TMDP_NEW_YN'			:'',
			'NECT_INSV_NEW_YN'			:null,
			'NECT_ATTR_REG_YN'			:'',
			'NECT_CMS_REG_YN'			:'',
			'FILLER'					:null,
			'NECT_CMMD_PDCD'			:'210002',
			'NECT_CMMD_ACCO_PWD'		:'1004',
			'NECT_CMMD_MNRC_AMT'		:null,
			'NECT_TMDP_TXTN_DVCD'		:'',
			'NECT_TMDP_SINT_CMIN_DVCD'	:'',
			'NECT_TMDP_PDCD'			:'',
			'NECT_TMDP_ACCO_PWD'		:'',
			'NECT_TMDP_MNRC_AMT'		:'',
			'TMDP_NECT_CNPD_DVCD'		:'',
			'NECT_TMDP_CNPD_MMCO'		:'',
			'NECT_TMDP_CNPD_DCNT'		:'',
			'NECT_TMDP_EXPT_DT'			:'',
			'NECT_INSV_TXTN_DVCD'		:null,
			'NECT_INSV_PDCD'			:null,
			'NECT_INSV_ACCO_PWD'		:'',
			'NECT_INSV_MNRC_AMT'		:null,
			'INSV_NECT_CNPD_DVCD'		:null,
			'NECT_INSV_CNPD_MMCO'		:null,
			'NECT_INSV_CNPD_DCNT'		:null,
			'NECT_INSV_CNTR_AMT'		:null,
			'NECT_INSV_MN_PYMN_AMT'		:null,
			'NECT_CMS_ACNO'				:'',
			'NECT_CMS_BKCD'				:'',
			'NECT_WRCN_CCNT'			:'3',
			'IN_REC'					:[
				{'NECT_WRCN_KIND_NO': '101011011'},
				{'NECT_WRCN_KIND_NO': '101011001'},
				{'NECT_WRCN_KIND_NO': '101011003'}
			]
		}
	}
	,'API_NomAcco0600_02' : {	// 정기예금 신규상담조회
		'BT_NAME'	: 'API_NomAcco0600_02',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'CSNO'					: '10101014722',
			'PDCD'					: '240068',
			'SINT_CMIN_DVCD'		: '2',
			'CNTR_DVCD'				: '1',
			'CNPD_MMCO'				: '36',
			'CNPD_DCNT'				: '0',
			'NEW_DT'				: '20191001',
			'EXPT_DT'				: '',
			'TXTN_DVCD'				: '11',
			'CNTR_AMT'				: '52000000',
		}
	}
	,'API_NomAcco0700_04' : {	// 비대면 실명확인조회
		'BT_NAME'	: 'API_NomAcco0700_04',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'ACNO'			:'11101111111',
			'RNNO'			:'1012201403216',
			'OPEN_BKCD'		:'296'
		}
	}
	,'API_NomAcco2000' : {	// 디지털뱅킹_비대면수신상품등록LOG
		'BT_NAME'	: 'API_NomAcco2000',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'162',
			'SBCD'					:'162',
			'NECT_PDCD'				:'240056',
			'NECT_PROD_DTLS_KNCD'	:'20',
			'NECT_PROD_NM'			:'SB톡톡 플러스 정기예금(단리)',
			'SINT_CMIN_DVCD'		:'1',
			'FRST_REG_GUID'			:null
		}
	}
	,'API_NomJoin0300_02' : {	// 비대면수신상품정보(전자금융개설)
		'BT_NAME'	: 'API_NomJoin0300_02',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'SBCD'       	:'101'
		}
	}
	,'API_NomChek0200_01' : {	// 비대면카드상품정보
		'BT_NAME'	: 'API_NomChek0200_01',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'NECT_PROD_DTLS_KNCD' 	:''
		}
	}
	,'API_NomLotr0300_01' : {	// 롯데카드신청
		'BT_NAME'	: 'API_NomLotr0300_01',
		'PARAMS'	: {
			'JEX_BANKCODE'					:'101',
			'TRN_DVCD'						:'01',
			'ACPT_DT'						:'20191022',
			'CUST_NM'						:'김현성',
			'ENSN_NM'						:null,
			'CPNO'							:'01023912100',
			'DMFR_DVCD'						:'01',
			'CASH_CARD_FNCT_USE_DVCD'		:'0',
			'LTC_ALNC_PDCD'					:'C312373',
			'ACNO'							:'',
			'PWD'							:'',
			'SGST_USRNO'					:'999999',
			'INDV_INFO_COLT_UZ_AGR_DVCD'	:'01',
			'INDV_INFO_OFR_AGR_DVCD'		:'01',
			'PROD_SVC_COLT_UZ_AGR_DVCD'		:'02',
			'PROD_SVC_INFO_OFR_AGR_DVCD'	:'02',
			'CASH_CARD_UZ_STPL_AGR_YN_DVCD'	:'',
			'ELEC_FNTR_BSIC_STPL_AGR_DVCD'	:'',
			'CARD_STMT_INST_BKCD'			:'088',
			'WB_ACNO'						:'110391184129'
		}
	}
	,'API_ComScra0100' : {	// 스크래핑사전데이타조회(휴일여부조회)
		'BT_NAME'	: 'API_ComScra0100',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'BASE_DT'				:'20200127',
			'HLDD_YN'				:null,
			'HLDD_DVCD'				:null,
			'HLIN_INCM_CMPTN_BSDT'	:null
		}
	}
	,'API_NomKred0200' : {	// 대출상품조회
		'BT_NAME'	: 'API_NomKred0200',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'SBCD'						:null,
			'NECT_PDCD'					:null,
			'NECT_PROD_DTLS_KNCD'		:'70',
			'NECT_LOAN_PROD_HNDL_DVCD'	:null
		}
	}
	,'API_NomSign0600' : {	// 신용대출신청/가입고객확인
		'BT_NAME'	: 'API_NomSign0600',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'162',
			'NRID'						:'8506201047016',
			'NECT_PROD_DTLS_KNCD'		:'10',
			'NECT_INTG_PDCD'			:'210002',
			'EXST_CUST_YN'				:'',
			'CUST_NM'					:'',
			'CUST_ENSN_NM'				:'',
			'CUST_CNTA_DVCD'			:'',
			'PSNT_RSDC_ZPCD'			:'',
			'PSNT_RSDC_BLDG_MNGNO'		:'',
			'PSNT_RSDC_ADDR'			:'',
			'PSNT_RSDC_REFAD'			:'',
			'PSNT_RSDC_DTAD'			:'',
			'DM_SEND_DVCD'				:'',
			'WRST_ZPCD'					:'',
			'WRST_BLDG_MNGNO'			:'',
			'WRST_ADDR'					:'',
			'WRST_REFAD'				:'',
			'WRST_DTAD'					:'',
			'SMS_RCMS_YN'				:'',
			'ALTALK_RCMS_YN'			:'',
			'PRTB_TSNO'					:'',
			'PRTB_TFNO'					:'',
			'PRTB_TVNO'					:'',
			'EML_RCMS_YN'				:'',
			'EMAD'						:'',
			'CRIF_UZ_DVCD'				:'',
			'CRIF_OFR_DVCD'				:'',
			'PROD_SCV_LTRS_YN'			:'',
			'PROD_SCV_EML_YN'			:'',
			'PROD_SCV_TEL_YN'			:'',
			'PROD_SCV_DM_YN'			:'',
			'INDV_STND_OCPT_CLCD'		:'',
			'CDD_REXC_DUE_DT'			:'',
			'PRE_EXIS_DMNB_ACCO_CCNT'	:'',
			'PRE_EXIS_DMNB_ACCO_1'		:'',
			'PRE_EXIS_DMNB_ACCO_2'		:'',
			'PRE_EXIS_DMNB_ACCO_3'		:'',
			'INBN_ID_PRE_EXIS_YN'		:'',
			'ELEC_FNTR_HSTR_STCD'		:'',
			'LVTP_MNBD_DVCD'			:''
		}
	}
	,'API_NomSign0100_01' : {	// 신분증이미지전송
		'BT_NAME'	: 'API_NomSign0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'PATH'			:'/328/201908/201908300013865_01066672433_19850620_30131658.enc'
		}
	}
	,'API_NomSign0601' : {	// 신용대출신청/고객정보저장
		'BT_NAME'	: 'API_NomSign0601',
		'PARAMS'	: {
			'JEX_BANKCODE'						:'101',
			'NECT_TRN_NO'						:'0',
			'NECT_IDC_KIND_DVCD'				:'1',
			'CUST_REG_PRGS_YN'					:'Y',
			'NECT_PROD_DTLS_KNCD'				:'20',
			'BZWR_UNQ_LTRS':'N20',
			'NECT_INTG_PDCD'					:'240033',
			'EXST_CUST_YN'						:'Y',
			'NRID'								:'8506201047016',
			'CUST_NM'							:'이재형',
			'CUST_ENSN_NM'						:'LEEJAEHYOUNG',
			'CUST_CNTA_DVCD'					:'06',
			'PSNT_RSDC_ZPCD'					:'14517',
			'PSNT_RSDC_BLDG_MNGNO'				:'4119043523200100002700000',
			'PSNT_RSDC_BSIC_ADDR'				:'경기 부천시 신흥로321번길 27',
			'PSNT_RSDC_REF_ITEM_NM'				:'(약대동현대아파트)',
			'PSNT_RSDC_DTAD'					:'2동 409호',
			'DM_SEND_DVCD'						:'10',
			'WRST_ZPCD'							:'',
			'WRST_BLDG_MNGNO'					:'',
			'WRST_BSIC_ADDR'					:'',
			'WRST_REF_ITEM_NM'					:'',
			'WRST_DTAD'							:'',
			'SMS_RCMS_YN'						:'Y',
			'ALTALK_RCMS_YN'					:'N',
			'PRTB_TSNO'							:'010',
			'PRTB_TFNO'							:'6667',
			'PRTB_TVNO'							:'2433',
			'EML_RCMS_YN'						:'N',
			'EMAD'								:'0',
			'CRIF_UZ_DVCD'						:'01',
			'CRIF_OFR_DVCD'						:'01',
			'PROD_GDNC_MTH_ONE_XN'				:'N',
			'PROD_GDNC_MTH_TWO_XN'				:'N',
			'PROD_GDNC_MTH_THR_XN'				:'Y',
			'PROD_GDNC_MTH_FUR_XN'				:'N',
			'CDD_RSDN_DVCD'						:'Y',
			'CDD_OCPT_DVCD'						:'3750',
			'CDD_OCPT_ETC'						:'0',
			'INDV_STND_OCPT_CLCD'				:'52129',
			'CDD_JBCF'							:'0',
			'CDD_IDT_CNFR_CERT_DVCD'			:'13010',
			'CDD_IDT_CNFR_CERT_ISS_INST'		:'경기도 부천시장',
			'CDD_IDT_CNFR_CERT_ISS_DT'			:'20021230',
			'RL_OWNR_YN'						:'Y',
			'INDV_NEW_TRN_PRPS_DVCD'			:'3060',
			'INDV_NEW_TRN_PRPS_ETC_CNTN'		:'0',
			'INDV_NEW_TRN_PRPS_INPM_PAYM_YN'	:'N',
			'INDV_NEW_TRN_PRPS_PBTX_PAYM_YN'	:'N',
			'INDV_NEW_TRN_PRPS_MNPB_PAYM_YN'	:'N',
			'INDV_TRN_CPT_DVCD'					:'7020',
			'INDV_TRN_CPT_ETC_CNTN'				:'0',
			'TOT_AST_AMT_DVCD'					:'',
			'ANIN_DVCD'							:'',
			'EKD_WRCN_ACPT_CCNT'				:'4',
			'IN_REC'							:[
			    {'NECT_WRCN_KIND_NO'	:'101011011'},
			    {'NECT_WRCN_KIND_NO'	:'101011001'},
			    {'NECT_WRCN_KIND_NO'	:'101011003'},
			    {'NECT_WRCN_KIND_NO'	:'101011002'}
			],
			'PHOTO'								:''
		}
	}
	,'API_NomSign0704' : {	// 입금계좌수취인조회
		'BT_NAME'	: 'API_NomSign0704',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'ACNO'			:'1016130011056',
			'RNNO'			:'7808152292933',
			'OPEN_BKCD'		:'101'
		}
	}
	,'API_RacReacList0100_01' : {	// 사고신고가능계좌조회
		'BT_NAME'	: 'API_RacReacList0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO'			:'10104850450'
		}
	}
	,'API_RacReacList0100' : {	// 디지털뱅킹 사고신고
		'BT_NAME'	: 'API_RacReacList0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'ACTNO'			:'10101130059242',
			'RRNO'			:'7808152292933',
			'TRN_KNCD'		:'1',
			'CLSC_CD'		:'2',
			'REG_CD'		:'41',
			'EXMT_CNT'		:null,
			'EXMT_CD'		:null,
			'SETP_AMT'		:null,
			'OUTL'			:null,
			'ACPT_DSTC1'	:'2'
		}
	}
	,'API_RacCdacList0100' : {	// 디지털뱅킹 IC카드 사고신고
		'BT_NAME'	: 'API_RacCdacList0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'DSTC1'			:'4',
			'CSNO'			:'10104838388',
			'REC_CNT_5'		:null,
			'IN_REC'		:null
		}
	}
	,'API_RacCcacList0100' : {	// 자기앞수표신고
		'BT_NAME'	: 'API_RacCcacList0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO'			:'10104850450'
		}
	}
	,'API_RacCcacTran0200' : {	// 자기앞수표사고신고_사고신고내역조회
		'BT_NAME'	: 'API_RacCcacTran0200',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'INQ_FLAG_2'		:'',
			'INQ_STDT'			:'',
			'INQ_EDDT'			:'',
			'APLC_NRBRNO_INQ'	:'',
			'ACDT_CHCK_STRN_NO'	:'',
			'ACDT_CHCK_END_NO'	:''
		}
	}
	,'API_LonInfoInfo1200' : {	// 인터넷대출신청
		'BT_NAME'	: 'API_LonInfoInfo1200',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CMP_HEADER'	: null,
			'CUSTNM_C20'	: '황동헌',
			'CSNO'	: '10104838388',
			'PWD_C700'	: '',
			'LOAN_PROP_AMT_N17'	: '10000',
			'LOAN_DSTC'	: '05',
			'LOAN_USG_C2'	: '01',
			'BRDD_C13'	: '780815000000',
			'MVMN_TLNO'	: '01092216284',
			'ONHM_TLNO'	: '',
			'ONHM_ADDR_ZPCD_C6'	: '',
			'ONHM_ADDR_DTL_C100'	: '',
			'WRST_NM_C50'	: '',
			'WRST_TLNO'	: '',
			'EML_C50'	: 'Smart@naver.com'
		}
	}
	,'API_LonInfoSail0200' : {	// SGI사잇돌대출-지점조회
		'BT_NAME'	: 'API_LonInfoSail0200',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'SBCD'			:'101'
		}
	}
	,'API_LonInqyTran0200' : {	// 인터넷대출신청결과조회
		'BT_NAME'	: 'API_LonInqyTran0200',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'BRDD_C13'					:'780815000000',
			'CSNO'						:'10104838388',
			'CUSTNM_C20'				:'황동헌',
			'LOAN_PROP_PWD_C700'		:'',
			'NEXT_DATA_REQT_KEY_VAL'	:null

		}
	}
	,'API_DepDeindLst0400_04' : {	// 과세구분코드 조회
		'BT_NAME'	: 'API_DepDeindLst0400_04',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO'			:'10104838388',
			'MNDP_KIND'		:'20',
			'PDCD'			:'240001'
		}
	}
	,'API_DepDeindLst0401_01' : {	// 비과세종합저축 한도조회
		'BT_NAME'	: 'API_DepDeindLst0401_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'NRBRNO_INQ'	:'8408082904217',
			'SVNG_KIND'		:'41',
			'INQ_KIND'		:'2'
		}
	}
	,'API_DepDeinIlst0502' : {	// 예적금상품 상품확인
		'BT_NAME'	: 'API_DepDeinIlst0502',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'CSNO'					:'',
			'MNDP_KIND'				:'',
			'CNPD_MNTH'				:'',
			'CNPD_DAYS'				:'',
			'CNTR_AMT_N15'			:'',
			'MN_PI_AMT_N15'			:'',
			'INSM_CYCL_DVCD'		:'',
			'WTCH_ACNO_C20'			:'',
			'WTCH_ACCO_C700'		:'',
			'TXTN_CD'				:'',
			'PROD_KIND'				:'',
			'ATTR_YN'				:'',
			'ATTR_DSGT_DT'			:'',
			'ATPAY_CNTP_BKCD'		:'',
			'ATPAY_CNTP_BK_ACNO'	:'',
			'PDCD'					:'',
			'ATMT_EXPT_EXTS_YN'		:'',
			'INTS_MNRC_BANK'		:'',
			'INTS_MNRC_ACNO_C20'	:''
		}
	}
	,'API_DepDeclRevo0101' : {	// 해지 가능계좌 조회
		'BT_NAME'	: 'API_DepDeclRevo0101',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO'			:'10100420969'
		}
	}
	,'API_DepDeclRevo0100' : {	// 전자금융사기예방 조회
		'BT_NAME'	: 'API_DepDeclRevo0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'USER_ID'		:'george75'
		}
	}
	,'API_DepDeclRevo0200' : {	// 예적금 해지_선거래(고객연락처 조회)
		'BT_NAME'	: 'API_DepDeclRevo0200',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'USER_ID_12'	:'george75'
		}
	}
	,'API_DepTran0100_1' : {	// 예적금 해지 계좌 조회
		'BT_NAME'	: 'API_DepTran0100_1',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'CSNO'				:'10104838388',
			'INQ_STDT'			:'20181018',
			'INQ_EDDT'			:'20191018',
			'DEPO_SUBJ_CLCD'	:'10'
		}
	}
	,'API_DepDech0100' : {	// 적금 납입일변경 가능 계좌 조회
		'BT_NAME'	: 'API_DepDech0100',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'NRBRNO_INQ'				:'8601281545917',
			'NEXT_DATA_REQT_KEY_VAL'	:null

		}
	}
	,'API_DepDech0200' : {	// 적금 납입일 변경 선조회
		'BT_NAME'	: 'API_DepDech0200',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'ACTNO'			:'10161310166150',
			'ACHN_PI_DT_N2'	:'',
			'TRTM_DVCD'		:'0' // 처리구분 0:조회 , 1: 변경
		}
	}
	,'API_DepDech0300' : {	// 적금 납입일 변경 처리
		'BT_NAME'	: 'API_DepDech0300',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'ACTNO'			:'10161310055440',
			'ACHN_PI_DT_N2'	:'15',
			'TRTM_DVCD'		:'1' // 처리구분 0:조회 , 1: 변경
		}
	}
	,'API_DepDeauRegi0100_01' : {	// 자동만기연장 등록 - 등록처리
		'BT_NAME'	: 'API_DepDeauRegi0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'NRBRNO_INQ'	:'7511201721917'
		}
	}
	,'API_DepDeauRegi0200' : {	// 만기자동재예치 선조회
		'BT_NAME'	: 'API_DepDeauRegi0200',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
	        'ACTNO'			:'10101242522909',
	        'TRN_DSTC'		:'2'
		}
	}
	,'API_DepDeauRegi0400' : {	// 자동만기연장 등록 - 등록처리
		'BT_NAME'	: 'API_DepDeauRegi0400',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'ACTNO' 				:'',
			'TRN_DSTC'				:'',
			'BANK_TRNF_STS_DVCD'	:'',
			'TRNF_ACNO' 			:'',
			'BKCD' 					:'',
			'CNTP_BANK_ACNO'		:''
		}
	}
	,'API_TrnSmatAtsr0200' : {	// 지역별ATM목록
		'BT_NAME'	: 'API_TrnSmatAtsr0200',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'LISTLEN'	: '10',
			'TRL_NM'	: '경기',
			'CCW_NM'	: '광명시',
			'CUR_PAGE'	: '1'
		}
	}
	,'API_TrnImtrRigt0100_04' : {	// 간편이체시작 DB조회및 업데이트(스뱅)
		'BT_NAME'	: 'API_TrnImtrRigt0100_04',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',    //'101',
			'TRN_USER_ID'	:'hsb9121', //'george75',
			'TRN_BNK_CD'	:'101',
			'TRN_AMOUNT'	:''
		}
	}
	,'API_TrnImtrRigt0100_05' : {	// 혼합형적금계좌 체크
		'BT_NAME'	: 'API_TrnImtrRigt0100_05',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'050',
			'MNRC_BANK'		:'050',
			'MNRC_ACNO_16'	:'02161130021741'
		}
	}
	,'API_TrnImtrRigt0105_01' : {	// 보이스피싱정보 수집
		'BT_NAME'	: 'API_TrnImtrRigt0105_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'SBCD'				:'101',
			'CSNO'				:'10101356656',
			'USER_ID'			:'naya3091',
			'USR_ID'			:'naya3091',
			'IPAD'				:'172.17.135.116',
			'TMNL_TP'			:'20',
			'OS_ID_VAL'			:'WINDOW',
			'HDD_ID'			:'9E6B-5C28',
			'MB_ID'				:'9E6B-5C28',
			'CPU_ID'			:'i5-2450M',
			'BOOT_UUID'			:'123',
			'ATM_MODL_TP_NM'	:'RV520',
			'APPL'				:'win7',
			'OS'				:'win7',
			'TMNL_NNM'			:'win77601',
			'CNT_3'				:'1',
			'IN_REC'			:[{'SVBN_WTCH_ACNO':'10161130200508', 'MNRC_BANK':'', 'MNRC_ACNO':'', 'TRN_AMT':'0'}]
		}
	}
	,'API_TrnImtrRigt0200_02' : {	// 간편이체완료 DB업데이트
		'BT_NAME'	: 'API_TrnImtrRigt0200_02',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'TRN_USER_ID'	:'hsb9121',
			'TRN_BNK_CD'	:'101',
			'TRN_AMOUNT'	:'1500000',
			'TRN_USER_ID1'	:'',
			'TRN_BNK_CD1'	:''
		}
	}
	,'API_TrnImtrTran0100_01' : {	// 즉시이체 (당/타행)거래내역조회
		'BT_NAME'	: 'API_TrnImtrTran0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'WTCH_WB_ACCO'				:'10101130372111',
			'INQ_STDT'					:'20190418',
			'INQ_EDDT'					:'20191018',
			'REQT_CCNT'					:'50',
			'NEXT_DATA_REQT_KEY_VAL'	:'1'
		}
	}
	,'API_TrnAutrRevo0300_01' : {	// 당/타행 비밀번호 확인
		'BT_NAME'	: 'API_TrnAutrRevo0300_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'ACTNO'			:'10161130000758',
			'TRN_DSTC'		:'1',
			'PSNT_PSWD'		:'',
			'CHNG_PSWD'		:'',
			'CNFR_PSWD'		:''
		}
	}
	,'API_comCert0100_03' : {	// 전자서명 db저장 및 출금동의 증빙자료
		'BT_NAME'	: 'API_comCert0100_03',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'008',
			'SBCD'				:'008',
			'SIGN_DATA'			:'',
			'REG_ID'			:'kdi3991',
			'CMS_DIVISION'		:'3',
	    	'WTCH_BKCD'			:'050',
	    	'WTCH_BANK_ACNO'	:'60761130000816',
	    	'MNRC_BKCD'			:'050',
	    	'MNRC_BANK_ACNO'	:'10161130002205',
		}
	}
	,'API_comCert0100_04'	: {	// 자동이체(CMS)타행출금동의자료등록
		'BT_NAME'	: 'API_comCert0100_04',
		'PARAMS'	: {
	        'JEX_BANKCODE'		:'101',
	        'CERT_MODE'			:'3',
	        'TRN_DSTC_4'		:'0365',
	    	'WTCH_BANK_ACNO'	:'60761130000816',
	    	'SBCD'				:'101',
	    	'FILLER_10'			:'TrnAucmAuto0500',
	    	'MNRC_BKCD'			:'050',
	    	'MNRC_BANK_ACNO'	:'10161130002205',
	    	'TRN_SRNO_28'		:'2019090611221031061130002205.pkcs',
	    	'WTCH_BKCD'			:'050'
        }
	}
	,'API_IbaDtrn0100' : {	// 지연이체서비스조회
		'BT_NAME'	: 'API_IbaDtrn0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO'			:'10104850450'
		}
	}
	,'API_TrnDetrList0100_02' : {	// 수취조회 및 이체가능금액 조회
		'BT_NAME'	: 'API_TrnDetrList0100_02',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'049',
			'USER_ID_12'	:'mikyungkim',
			'WTCH_ACNO_16'	:'04961130064177',
			'ACCO_PWD'		:'1357',
			'MNRC_BANK'		:'050',
			'MNRC_ACNO_16'	:'04961130064135',
			'MNRC_AMT_14'	:'100000',
			'FEE_5'			:null,
			'MNRC_BNKB_MRK'	:'이학현11(부림저축',
			'ACCO_FLAG'		:'R',
			'USE_DVCD'		:'1',
			'USER_ID'		:'mikyungkim',
			'NO2_ITEM_YN'	:'0',
			'B_CLOGID'		:null,
			'B_GUBUN'		:null,
			'B_JKFLAG'		:null,
			'B_TIAM'		:null,
			'B_TIBKCD'		:'저축은행',
			'B_TICGAM'		:null,
			'B_TIPANO'		:null,
			'B_TIRANO'		:null,
			'B_TISCNM'		:'이학현11',
			'B_TISCNO'		:null,
			'SEQNO'			:null,
			'SESSIONKEY'	:null
		}
	}
	,'API_TrnDetrList0200_01' : {	// 이체 실행 및 자주쓰는계좌 등록
		'BT_NAME'	: 'API_TrnDetrList0200_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'049',
			'USER_ID_12'	:'mikyungkim',
			'WTCH_ACNO_16'	:'04961130064177',
			'ACCO_PWD'		:'1357',
			'RMTN_RQPS2'	:'김미경',
			'MNRC_BANK'		:'050',
			'MNRC_ACNO_16'	:'04961130064135',
			'MNRC_AMT_14'	:'50000',
			'RECV'			:'이이슬',
			'FEE_5'			:'0',
			'ACCO_FLAG'		:'K',
			'WTCH_BNKB_MRK'	:'aaa',
			'USR_ID_12'		:'mikyungkim',
			'TRTM_DVCD'		:'',
			'MNRC_ACCO'		:'',
			'DEPR_NM_20'	:'',
			'ALS'			:'',
			'DG2_EVPN'		:'',
			'PI_DVCD'		:'',
			'CSNO'			:'04900714945'
		}
	}
	,'API_TrnDetrList0200_02' : {	// 지연이체서비스 본인인증등록
		'BT_NAME'	: 'API_TrnDetrList0200_02',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'049',
			'CSNO'			:'04900714945',
			'MESG_NO'		:'302',
			'SELF_YN'		:'Y',
			'WTCH_ACNO'		:'04961130064177',
			'MNRC_BKCD'		:'050',
			'MNRC_ACNO'		:'04961130064135',
			'MNRC_AMT_17'	:'50000'
		}
	}
	,'API_TrnDetrList0300_01' : {	// 자주쓰는계좌 등록
		'BT_NAME'	: 'API_TrnDetrList0300_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'USR_ID_12'		:'hsb9121',
			'TRTM_DVCD'		:'1',   // 1.등록, 3.삭제 - X, 9.변경 - X
			'MNRC_BANK'		:'262',
			'MNRC_ACCO'		:'2041576105',
			'DEPR_NM_20'	:'홍오성이',
			'ALS'			:'홍징루이'
		}
	}
	,'API_TrnDetrCncl0100' : {	// 지연이체처리내역조회
		'BT_NAME'	: 'API_TrnDetrCncl0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CUSTNO'		:'10104850450'
		}
	}
	,'API_TrnDetrCncl0200_01' : {	// 지연이체처리취소
		'BT_NAME'	: 'API_TrnDetrCncl0200_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CUSTNO'		:'',
			'USR_ID'		:'tlswlgns01',
			'LIST_CNT'		:'1',
			'IN_REC'		:[
	    		{
					'SEQ'			:'',
					'REQ_TIME'		:'',
					'EXCUT_TIME'	:'',
					'MEDIA_CD'		:'',
					'OUTAMT_ACTNO'	:'',
					'RCPT_BANKCD'	:'',
					'RCPT_ACTNO'	:'',
					'RCPT_AMT'		:''
				}
			]
		}
	}
	,'API_IbaDeptJore0100' : {	// 입금지정계좌목록조회
		'BT_NAME'	: 'API_IbaDeptJore0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'CSNO'			:'10104850450',
			'USR_ID'		:'kmj573'
		}
	}
	,'API_LogIdfn0300_01' : {	// 아이디찾기 선조회 (아이디찾기->전화번호찾기)
		'BT_NAME'	: 'API_LogIdfn0300_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'RNNO'				:'7808150000000',
			'WTCH_ACNO'			:'10101130354565',
			'WTCH_ACCO_C700'	:'1233',
			'INDV_CORP_DSTC'	:'SCB'
		}
	}
	,'API_LogIdfn0200' : {	// 아이디찾기 ARS인증용 연락처조회
		'BT_NAME'	: 'API_LogIdfn0200',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'USER_ID_12'	:'kmj573'
		}
	}
	,'API_LogUpwl0100_01' : {	// 사용자비밀번호 5회 오류 해체(선조회 / 본거래)
		'BT_NAME'	: 'API_LogUpwl0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'WTCH_ACCO_C700'	:'',
			'USER_ID_12'		:'',
			'CMPH_BNKB_PWD'		:'',
			'TRTM_DSTC'			:'I',
			'RNNO'				:'',
			'WTCH_ACNO'			:''
		}
	}
	,'API_SeuAdsvJoin0200_02' : {	// 추가인증서비스(ARS인증, 스마트앱인증) 가입정보를 조회
		'BT_NAME'	: 'API_SeuAdsvJoin0200_02',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'USER_ID'		:'hsb9121'
		}
	}
	,'API_SeuOotp0100_01' : {	// 고객OTP정보조회
		'BT_NAME'	: 'API_SeuOotp0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'USR_ID_12'			:'soonlhh11',
			'PROC_FLAG'			:'I',
			'RRNO'				:'3511011111121',
			'WTCH_ACNO'			:'10101130318575',
			'WTCH_ACCO_C700'	:''
		}
	}
	,'API_PA_OtpTxCreate' : {	// 사설인증 Otp비교용 트랜잭션 생성
		'BT_NAME'	: 'API_PA_OtpTxCreate',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
		}
	}
	,'API_PA_OtpTxSign' : {	// 사설인증 Otp비교용 서명검증
		'BT_NAME'	: 'API_PA_OtpTxSign',
		'PARAMS'	: {
			'BKCD'		:'101',
			'ID'		:'37b997a76e6f1cd082fa8ad91f3706e89c5af698',
			'SIG'		:'634424333130303438343836353724502466666666666666662d663337372d633738362d626166312d63306537303033336335383723362f3331303a30326637316564373837353031316438626637393737656565353434353266396363356435643637ffde838b99a1b28e859e3b6a7793dc0df85fd88b0bf67c9c2a538578c533279e69c67eef16df6eb0c86d6744c1d0039a5c9e6210f9202ef6455e1919114d0a98a70b7e1e5b18f693488fd49ea1507d33f9978bbd2d8150db0da449c221b5969fee7b0cab6160c733d592c366d2396e16ac514f4a2929c8d70fcaf04094876ee8cee9a941bb98c6646334cd4930d5a8624e42ee57cd8597df45cf01815c06522321a395d52727bd4d129bed693e603c6b8bd7c39e83051dcbd92867371b58555ee90fdde1c9ffb59d4bed41d7bf02e57545bd31e0c65a52330751bdd0bc7998cacf78e472b013f0f3582395d2106e9c21d7e218092955b4a8916bcc1d99f2c8a62833376239393761373665366631636430383266613861643931663337303665383963356166363938c03d10c0f845408380ea68e997c13afc3f5fdb35b4db661f4ab452b3ac34b96c04abe484c170cc7fd94f0fb30d9a49075b1b6afaa9000bbd9838bfcc71a22a7d5c168cd3e5af0a1db944120d1e1764ed770c82cb01b61ae43d8b330b7c2b39bd30aaa75c1216e8b8d84cac32858090d182bbac4d9736e26e252a7fb52126e1aa01e72e2a739da3700cf917ac0855b8088ef017386123db6148993d08098ffab16f22384e0d49245376f18d115ae31c527fa78a57a8c29cc9896a9d741a561d0448552b48dd34ec22ddd27864101b685be78dd9ce32d4ac1ae5e1e67efc8bc10dc97c66e12cced28ec53a66f8880fb50cdf2fc50ee54f44311ae395fc79255bf2b5603f3c7e7d34e9261f66bfbd729641e9ec223f1fa8dc394a8a9414c078218380ea384d9c82a17439145843668c2aa68815c267a6dad821b609985e3173222e97a8fbb05ac76720615ba8954e8e178695d38850f2cd9368e1ae1fd6fc8eef76827e69b95c146c2af04e6ef098839f3c9cc5cc4711bc3e84952f012eea1ce18eac434b18a5c8d06e80884411454f03226389a31ff2cd930d08fe65bc4a46ed4f5d5c0002',
			'MSG'		:'37b997a76e6f1cd082fa8ad91f3706e89c5af698',
			'OTP_LEN'	:null,
		}
	}
	,'API_SeuPinnPinn0100' : {	// 사설인증관리정보를 처리(핀, 지문, 패턴)
		'BT_NAME'	: 'API_SeuPinnPinn0100',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'TRMN_TRN_DVCD'		:'01',
			'RNNO'				:'7808152292933',
			'UUID'				:'ffffffff-dec1-8764-fed2-c5a304d57a55',
			'OS_ID'				:'Android',
			'MB_ID'				:'4100a5eac8a7b14fSMN910S',
			'CPU_ID'			:'SM-N910S',
			'BOOT_UUID'			:'354678064745453trelteskt',
			'CSNO'				:'10104838388',
			'PIN_USE_YN'		:'Y',
			'BIO_ATHN_USE_YN'	:'N',
			'FRMN_ATHN_USE_YN'	:'Y'
		}
	}
	,'API_CerIssu0200_02' : {	// 공인인증서 PC지정여부 확인
		'BT_NAME'	: 'API_CerIssu0200_02',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'USER_ID'		:'hsb9121',
			'TMNL_TP'		:'20',
			'OS_ID'			:'Androiddd',
			'HDD_ID'		:'123456789999000',
			'MB_ID'			:'987654321000000',
			'CPU_ID'		:'pocopocopopoco',
			'BOOT_UUID'		:'bootboot'
		}
	}
	,'API_ComGetRegiBank' : {	// 응답결과 세션 저장
		'BT_NAME'	: 'API_ComGetRegiBank',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'INQ_DVCD'			:'2',
			'CRFC_DN_VAL'		:'',
			'CRFC_SERL_VAL'		:'',
			'GBPR_UNQ_VAL'		:'ffffffff-dec1-8764-fed2-c5a304d57a55',
			'PRV_CERT_DVCD'		:'3',
			'LNP_BASE'			:'1',
			'ELFN_CHNL_DVCD'	:'01'
		}
	}
	,'API_LogIdfn0400' : {	// 디지털뱅킹 전자금융 ID조회 (OpenAPI)
		'BT_NAME'	: 'API_LogIdfn0400',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'SBCD'			:'101',
			'RNNO'			:'3511011111135'
		}
	}
	,'API_NomSign0100' : {	// 대출상품서비스은행조회
		'BT_NAME'	: 'API_NomSign0100',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'SBCD'					:'101',
			'NECT_PDCD'				:'',
			'PROVINCE_NAME'			:'',
			'ALPHABET_INDEX'		:'',
			'NECT_PROD_DTLS_KNCD'	:''
		}
	}
	,'API_LonInfoLoan0700' : {	// 예적금담보대출실행
		'BT_NAME'	: 'API_LonInfoLoan0700',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			'ACNO'						:'',
			'TRN_DSTC'					:'',
			'GVCR_PROP_NO_N14'			:'',
			'GVCR_ACNO'					:'',
			'CSNO'						:'',
			'LAMT'						:'',
			'PADD'						:'',
			'TRNF_DSGT_BKCD'			:'',
			'WB_ACNO'					:'',
			'DEPR_NM'					:'',
			'BANK_ACCO_RNNO'			:'',
			'WTCH_AGR_EVDN_DTA_DVCD'	:'',
			'HNDL_FEE'					:'',
			'ITSL_FEE_N18'				:'',
			'BLCL_FEE_N18'				:'',
			'CRMN_IVFE_N18'				:'',
			'STMF_AMT'					:'',
			'RMS_FEE_N18'				:'',
			'ETC_VCOST_N18'				:'',
			'ETC_VCOST_DVCD_C2'			:'',
			'NTFE_N18'					:'',
			'NTFE_ALTR_YN_C1'			:'',
			'NTFE_ACNO_C14'				:'',
			'FRIS_AMT_N18'				:'',
			'FRIS_AMT_ALTR_YN_C1'		:'',
			'FRIS_ACNO_C14'				:'',
			'EXTR_ESPR_N18'				:'',
			'EXTR_ESPR_ALTR_YN_C1'		:'',
			'EXTR_ESPR_ACNO_C14'		:'',
			'FXDT_AMT_N18'				:'',
			'FXDT_AMT_ALTR_YN_C1'		:'',
			'FXDT_AMT_ACNO_C14'			:'',
			'JDSR_COST_N18'				:'',
			'JDSR_COST_ALTR_YN_C1'		:'',
			'JDSR_COST_ACNO_C14'		:'',
			'MVIN_GNRT_INVT_AMT_N18'	:'',
			'MVIN_GNRT_INVT_ALTR_YN_C1'	:'',
			'MVIN_GNRT_INVT_ACNO_C14'	:'',
			'TOT_DEBT_RPY_RATE_N9'		:'',
			'LTV_APL_RATE_N9'			:'',
			'GVCR_PAYM_DVCD'			:'',
			'BNKB_ISUE_YN_C2'			:'',
			'LOAN_BNKB_NO_C11'			:'',
			'FEE_SAMT_N18'				:'',
			'MN_PYMN_AMT'				:'',
			'PYMN_CMTL_AMT_N18'			:'',
			'MNTH_ISTS_SAMT_N18'		:'',
			'CASH_AMT'					:'',
			'OTBR_AMT'					:'',
			'ALTR_AMT'					:'',
			'MORT_MNRC_BKCD_C3'			:'',
			'MORT_MNRC_ACNO_C14'		:'',
			'FSB_FILD_N18'				:''
		}
	}
	,'API_NomArrn0400_01' : {	// 전자약정/동의서
		'BT_NAME'	: 'API_NomArrn0400_01',
		'PARAMS'	: {
			'JEX_BANKCODE'					:'101',
			'SBCD'							:'',
			'NECT_TRN_NO'					:'',
			'PDCD'							:'',
			'SVBN_GVCR_TRN_STPL_AGR_YN'		:'',
			'LOAN_DOC_CNFR_OR_AGR_YN'		:'',
			'LOAN_DOC_STRG_OR_KEEP_AGR_YN'	:'',
			'FILLER'						:'',
			'CUST_EML_COLT_AGR_YN'			:'',
			'RES_CD'						:'',
			'BZWR_UNQ_LTRS'					:'',
			'NECT_ELEC_AGRM_CHNL_DVCD'		:''
		}
	}
	,'API_NomSign1100_01' : {	// 대출신청/고객정보입력(신용대출/사잇돌)저장
		'BT_NAME'	: 'API_NomSign1100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'						:'101',
			'NECT_TRN_NO'						:'',
			'NECT_IDC_KIND_DVCD'				:'',
			'CUST_REG_PRGS_YN'					:'',
			'NECT_PROD_DTLS_KNCD'				:'',
			'NECT_INTG_PDCD'					:'',
			'EXST_CUST_YN'						:'',
			'NRID'								:'',
			'CUST_NM'							:'',
			'CUST_ENSN_NM'						:'',
			'CUST_CNTA_DVCD'					:'',
			'PSNT_RSDC_ZPCD'					:'',
			'PSNT_RSDC_BLDG_MNGNO'				:'',
			'PSNT_RSDC_BSIC_ADDR'				:'',
			'PSNT_RSDC_REF_ITEM_NM'				:'',
			'PSNT_RSDC_DTAD'					:'',
			'DM_SEND_DVCD'						:'',
			'WRST_ZPCD'							:'',
			'WRST_BLDG_MNGNO'					:'',
			'WRST_BSIC_ADDR'					:'',
			'WRST_REF_ITEM_NM'					:'',
			'WRST_DTAD'							:'',
			'SMS_RCMS_YN'						:'',
			'ALTALK_RCMS_YN'					:'',
			'PRTB_TSNO'							:'',
			'PRTB_TFNO'							:'',
			'PRTB_TVNO'							:'',
			'EML_RCMS_YN'						:'',
			'EMAD'								:'',
			'CRIF_UZ_DVCD'						:'',
			'CRIF_OFR_DVCD'						:'',
			'PROD_GDNC_MTH_ONE_XN'				:'',
			'PROD_GDNC_MTH_TWO_XN'				:'',
			'PROD_GDNC_MTH_THR_XN'				:'',
			'PROD_GDNC_MTH_FUR_XN'				:'',
			'CDD_RSDN_DVCD'						:'',
			'CDD_OCPT_DVCD'						:'',
			'CDD_OCPT_ETC'						:'',
			'INDV_STND_OCPT_CLCD'				:'',
			'CDD_JBCF'							:'',
			'CDD_IDT_CNFR_CERT_DVCD'			:'',
			'CDD_IDT_CNFR_CERT_ISS_INST'		:'',
			'CDD_IDT_CNFR_CERT_ISS_DT'			:'',
			'RL_OWNR_YN'						:'',
			'INDV_NEW_TRN_PRPS_DVCD'			:'',
			'INDV_NEW_TRN_PRPS_ETC_CNTN'		:'',
			'INDV_NEW_TRN_PRPS_INPM_PAYM_YN'	:'',
			'INDV_NEW_TRN_PRPS_PBTX_PAYM_YN'	:'',
			'INDV_NEW_TRN_PRPS_MNPB_PAYM_YN'	:'',
			'INDV_TRN_CPT_DVCD'					:'',
			'INDV_TRN_CPT_ETC_CNTN'				:'',
			'TOT_AST_AMT_DVCD'					:'',
			'ANIN_DVCD'							:'',
			'EKD_WRCN_ACPT_CCNT'				:'1',
			'IN_REC'							:[{'NECT_WRCN_KIND_NO'	:''}],
			'PHOTO'								:'',
			'NECT_SBCD'							:'',
			'ATSH_DN_VAL'						:'',
			'BANK_NM'							:'',
			'PROD_NM'							:'',
			'MOBILE_OS_TYPE'					:'',
			'MCN_IDNT_ID_NO'					:''
		}
	}
	,'API_NomSign1100' : {	// 대출신청/고객정보입력(신용대출/사잇돌)/가입고객확인
		'BT_NAME'	: 'API_NomSign1100',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'',
			'NRID'						:'',
			'NECT_PROD_DTLS_KNCD'		:'',
			'NECT_INTG_PDCD'			:'',
			'EXST_CUST_YN'				:'',
			'CUST_NM'					:'',
			'CUST_ENSN_NM'				:'',
			'CUST_CNTA_DVCD'			:'',
			'PSNT_RSDC_ZPCD'			:'',
			'PSNT_RSDC_BLDG_MNGNO'		:'',
			'PSNT_RSDC_ADDR'			:'',
			'PSNT_RSDC_REFAD'			:'',
			'PSNT_RSDC_DTAD'			:'',
			'DM_SEND_DVCD'				:'',
			'WRST_ZPCD'					:'',
			'WRST_BLDG_MNGNO'			:'',
			'WRST_ADDR'					:'',
			'WRST_REFAD'				:'',
			'WRST_DTAD'					:'',
			'SMS_RCMS_YN'				:'',
			'ALTALK_RCMS_YN'			:'',
			'PRTB_TSNO'					:'',
			'PRTB_TFNO'					:'',
			'PRTB_TVNO'					:'',
			'EML_RCMS_YN'				:'',
			'EMAD'						:'',
			'CRIF_UZ_DVCD'				:'',
			'CRIF_OFR_DVCD'				:'',
			'PROD_SCV_LTRS_YN'			:'',
			'PROD_SCV_EML_YN'			:'',
			'PROD_SCV_TEL_YN'			:'',
			'PROD_SCV_DM_YN'			:'',
			'INDV_STND_OCPT_CLCD'		:'',
			'CDD_REXC_DUE_DT'			:'',
			'PRE_EXIS_DMNB_ACCO_CCNT'	:'',
			'PRE_EXIS_DMNB_ACCO_1'		:'',
			'PRE_EXIS_DMNB_ACCO_2'		:'',
			'PRE_EXIS_DMNB_ACCO_3'		:'',
			'INBN_ID_PRE_EXIS_YN'		:'',
			'ELEC_FNTR_HSTR_STCD'		:'',
			'LVTP_MNBD_DVCD'			:''
		}
	}
	,'API_CusCertDebt0200' : {	// 부채잔액증명서 조회및발급
		'BT_NAME'	: 'API_CusCertDebt0200',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'',
			'TRN_DSTC'				:'',
			'CSNO'					:'',
			'ISS_BSDT'				:'',
			'INTG_MCF_USE_USG_CNTN'	:'',
			'INTG_MCF_PRPL_NM'		:'',
			'FEE'					:'',
			'WTCH_ACNO'				:'',
			'WTCH_ACCO_C700'		:'',
			'LOAN_BLNC_SUM'			:''
		}
	}
	,'API_CusCertFine0200' : {	// 금융거래확인서 조회및발급
		'BT_NAME'	: 'API_CusCertFine0200',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'',
			'TRN_DSTC'				:'',
			'CSNO'					:'',
			'ISS_BSDT'				:'',
			'INTG_MCF_USE_USG_CNTN'	:'',
			'FEE'					:'',
			'WTCH_ACNO'				:'',
			'WTCH_ACCO_C700'		:'',
			'LOAN_BLNC_SUM'			:''
		}
	}
	,'API_CusCertColl0100' : {	// 원천징수영수증 조회및발급
		'BT_NAME'	: 'API_CusCertColl0100',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'021',
			'INQ_STDT'		:'20190416',
			'TRN_DSTC'		:'1',
			'ACNO'			:'02161130021709',
			'INQ_EDDT'		:'20191016'
		}
	}
	,'API_ComSerc0100' : {	// 추천인조회
		'BT_NAME'	: 'API_ComSerc0100',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'360',
			'SRCH_NM'				:'김명준',
			'NECT_PROD_DTLS_KNCD'	:'41',
			'SRCH_DVCD'				:'01',
			'CNT'					:null
		}
	}
/*	,'API_TrnImtrKaka0100_01' : {	// 카카오이체1단계-송금전조회 및 간편이체가능여부 조회
		'BT_NAME'	: 'API_TrnImtrKaka0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'506',
			'CSNO'				:'50606578712',
			'WTCH_ACNO'			:'50661130001918',
			'WTCH_ACCO_C700'	:'8034',
			'TRNF_AMT'			:'1',
			'RECV_NM'			:'지광훈',
			'TRN_USER_ID'		:'easybizman',	// 같은 값 둘다입력
			'USR_ID'			:'easybizman',	// 같은 값 둘다입력
			'TRN_BNK_CD'		:'506',
			'TRN_AMOUNT'		:'3000000'
		}
	}*/
	,'API_TrnImtrKaka0100_01' : {	// 카카오이체1단계-송금전조회 및 간편이체가능여부 조회
		'BT_NAME'	: 'API_TrnImtrKaka0100_01',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'101',
			'CSNO'				:'10100429927',
			'WTCH_ACNO'			:'10161130096523',
			'WTCH_ACCO_C700'	:'0405',
			'TRNF_AMT'			:'1000',
			'RECV_NM'			:'전호근',
			'TRN_USER_ID'		:'opkl0423',	// 같은 값 둘다입력
			'USR_ID'			:'opkl0423',	// 같은 값 둘다입력
			'TRN_BNK_CD'		:'101',
			'TRN_AMOUNT'		:'3000000'
		}
	}
	,'API_TrnImtrKaka0100_02' : {	// 카카오이체1단계-송금등록
		'BT_NAME'	: 'API_TrnImtrKaka0100_02',
		'PARAMS'	: {
			'JEX_BANKCODE'		:'506',
			'CSNO'				:'50606578712',
			'WTCH_ACNO'			:'50661130001918',
			'USR_ID'			:'easybizman',
			'WTCH_ACCO_C700'	:'8034',
			'TRNF_AMT'			:'1',
			'RECV_NM'			:'서윤석'
		}
	}
	,'API_TrnImtrKaka0100_03' : {	// 카카오이체1단계-송금등록(채널)
		'BT_NAME'	: 'API_TrnImtrKaka0100_03',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'506',
			'RMTN_REG_GUID'	:'20191113204741336DSMB50601010357',
			'VLD_EDDTM'		:'20191114204742',
			'TRNF_STS'		:'10',
			'CLOT_COUNT'	:'0',
			'SBCD'			:'506',
			'SEND_NM'		:'지광훈',
			'CSNO'			:'50606578712',
			'USER_ID_12'	:'easybizman',
			'TRNF_AMT'		:'1',
			'TRN_USER_ID'	:'easybizman',
			'TRN_BNK_CD'	:'506',
			'TRN_AMOUNT'	:'1'
		}
	}
	,'API_TrnImtrKaka0300' : {	// 카카오이체3단계-송금등록조회 및 접속정보업데이트
		'BT_NAME'	: 'API_TrnImtrKaka0300',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'506',
			'PRCS_KEY'		:'201911132000345'
		}
	}
	,'API_TrnImtrKaka0300_01' : {	// 카카오이체3단계-송금등록조회 및 수취조회
		'BT_NAME'	: 'API_TrnImtrKaka0300_01',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'506',
			'PRCS_KEY'		:'201911142000010',
			'SBCD'			:'506',
			'MNRC_BANK'		:'021',
			'MNRC_ACNO_16'	:'02161130021709'
		}
	}
	,'API_TrnImtrKaka0300_02' : {	// 카카오이체3단계-수취처리 및 이체정보업데이트
		'BT_NAME'	: 'API_TrnImtrKaka0300_02',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'506',
			'SBCD'			:'506',
			'RMTN_REG_GUID'	:'20191113205455050PSMB02101010187',
			'MNRC_BKCD'		:'021',
			'RMTN_ACTNO'	:'02161130021709',
			'PRCS_KEY'		:'201911132000345'
		}
	}
	,'API_InqTrhi0100_02' : {  // 기간별대출거래내역
		'BT_NAME'	: 'API_InqTrhi0100_02',
		'PARAMS'	: {
	        'JEX_BANKCODE'           : '',   // 은행코드
	        'DVCD'                   : '',   // 구분코드
	        'ACNO'                   : '',   // 계좌번호
	        'STDT'                   : '',   // 시작일자
	        'EDDT'                   : '',   // 종료일자
	        'NEXT_DATA_REQT_KEY_VAL' : ''    // 다음데이터요청키값
		}
	},
	'API_NomAcco0401_064' : {	// 고객정보 등록(OK)
		'BT_NAME'	: 'API_NomAcco0401_064',
		'PARAMS'	: {
			'JEX_BANKCODE'						:'101',
			'PROD_GDNC_MTH_TWO_XN'				:'N',
			'PSNT_RSDC_REF_ITEM_NM'				:'(공덕동,서울신용보증재단)',
			'NECT_PROD_DTLS_KNCD'				:'20',
			'CUST_CNTA_DVCD'					:'09',
			'CRIF_UZ_DVCD'						:'02',
			'CDD_OCPT_DVCD'						:'3710',
			'ANIN_DVCD'							:'8010',
			'PSNT_RSDC_BLDG_MNGNO'				:'1144021130010200016300000',
			'PHOTO'								:'1231231234',
			'PSNT_RSDC_BSIC_ADDR'				:'서울 마포구 마포대로 163',
			'PRTB_TVNO'							:'7417',
			'NECT_INTG_PDCD'					:'240070',
			'PSNT_RSDC_DTAD'					:'14',
			'ALTALK_RCMS_YN'					:'N',
			'PROD_GDNC_MTH_THR_XN'				:'N',
			'CDD_JBCF'							:'',
			'CUST_NM'							:'서윤석',
			'INDV_TRN_CPT_ETC_CNTN'				:'',
			'CUST_REG_PRGS_YN'					:'Y',
			'PROD_GDNC_MTH_ONE_XN'				:'N',
			'CUST_ENSN_NM'						:'',
			'EML_RCMS_YN'						:'N',
			'DM_SEND_DVCD'						:'99',
			'PRTB_TFNO'							:'4560',
			'BZWR_UNQ_LTRS'						:'N20',
			'INDV_STND_OCPT_CLCD'				:'22129',
			'SMS_RCMS_YN'						:'N',
			'PSNT_RSDC_ZPCD'					:'04130',
			'EXST_CUST_YN'						:'Y',
			'RL_OWNR_YN'						:'Y',
			'INDV_NEW_TRN_PRPS_INPM_PAYM_YN'	:'N',
			'EKD_WRCN_ACPT_CCNT'				:'3',
			'IN_REC':[
						{'NECT_WRCN_KIND_NO'	:'332011011'},
						{'NECT_WRCN_KIND_NO'	:'332011001'},
						{'NECT_WRCN_KIND_NO'	:'332011003'}
			],
			'NECT_SBCD'							:'101',
			'INDV_NEW_TRN_PRPS_ETC_CNTN'		:'',
			'INDV_NEW_TRN_PRPS_DVCD'			:'3010',
			'INDV_NEW_TRN_PRPS_MNPB_PAYM_YN'	:'N',
			'MCN_IDNT_ID_NO'					:'comtec',   //d99cccb7-3b9d-4da4-8f32-21c483c45aca',  //'d99cccb7-3b9d-4da4-8f32-21c483c45aca'
			'EMAD'								:'',
			'INDV_NEW_TRN_PRPS_PBTX_PAYM_YN'	:'N',
			'INDV_TRN_CPT_DVCD'					:'7010',
			'CDD_RSDN_DVCD'						:'Y',
			'CRIF_OFR_DVCD'						:'02',
			'TOT_AST_AMT_DVCD'					:'51',
			'PROD_GDNC_MTH_FUR_XN'				:'N',
			'CDD_OCPT_ETC'						:'',
			'NRID'								:'9005011158222',
			'PRTB_TSNO'							:'01037679029'
		}
	},
	'API_NomAcco0402_064' : {	// 신분증 등록(OK)
		'BT_NAME'	: 'API_NomAcco0402_064',
		'PARAMS'	: {
			'JEX_BANKCODE'						:'101',
			'NECT_TRN_NO'						:'202003090028260', 	//비대면거래번호
			'NECT_PROD_DTLS_KNCD'				:'20', 	// 업무구분코드
			'NECT_IDC_KIND_DVCD'				:'2',
			'CDD_IDT_CNFR_CERT_DVCD'			:'13020',
			'CDD_IDT_CNFR_CERT_ISS_INST'		:'**',
			'CDD_IDT_CNFR_CERT_ISS_DT'			:'20160310',
			'CUST_NM'							:'서윤석',
			'PRTB_TSNO'							:'010',
			'PRTB_TFNO'							:'3767',
			'PRTB_TVNO'							:'9029',
			'NRID'								:'9005011158222',
			'PHOTO'								:'1111111111111111111111111111'
		}
	}
	,'API_ComPushAddUser' : {	// 푸시 사용자 등록 - 20200218 추가
		'BT_NAME'	: 'API_ComPushAddUser',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'506',
			'UUID'			:'ffffffff-d1bb-c651-0033-c5870033c587',
			'TOKEN'			:'fq1YDjyfdyw:APA91bGT55mR-C7NM2roSY0LxWERwCisz43dlf5R1dXYDCUrE9i2ZdA-0v8ehzRGbIkJcEs3_dU1saknz0hDD5aW6NXbhVRAVSi6fA0lugkymEApjhWtKsnNPH06VPn1pMxyxY8NKs5M',
			'RCV_NO'		:'API1|650aycomfy4',
			'TYPE'			:'A',
			'MS_CODE' 		:'IBK1'
		}
	}
	,'API_CusCertColl0300' : {	// 비과세증빙자료 제출 - 20200305 추가
		'BT_NAME'	: 'API_CusCertColl0300',
		'PARAMS'	: {
			'JEX_BANKCODE'	:'101',
			'USR_ID'	:'yjjjjung',
			'CUST_NM'		:'정연중',
			'CSNO'			:'10101374955',
			'SBCD'			:'101',
			'IMG'			:'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',
			'LVTP_MNBD_DVCD' : '1'

		}
	}
	,'API_CusCertDepo0200' : {	// 예금잔액증명서_발급신청
		'BT_NAME'	: 'API_CusCertDepo0200',
		'PARAMS'	: {
			'JEX_BANKCODE'				:'101',
			"TRN_DSTC"					:"2",		// 1:조회 , 2:발급
			"CSNO"						:"31004838388",
			"ISS_BSDT"					:"20200310",
			"BLNC_PRF_ISS_PRPS_DVCD"	:"01",		// 01.결산용, 02.회사제출용, 03.관공서제출용, 04.회계감사용  05.잔액확인용, 06.비자발급용, 07.공직자재산등록용 08.감사용, 09.제출용, 10.확인용, 99.직접입력
			"FEE"						:"0",		// 0 고정
			"WTCH_ACNO"					:"31001130059242",
			"WTCH_ACCO_C700"			:"1004",
			"INDV_CORP_DSTC_CD"			:"1",		// 1:개인, 2:법인
			"EML_C50"					:"khji@kci.co.kr",
			"CNT": "1",
			"REC_INPUT":[
			{
				"ACNO": "31001130059242",
				"PROD_NM": "보통예금",
				"MNDP_BLNC": "12125",
				"UNSM_OTBR_AMT": "0",
				"LAMT": "0",
				"PRVS_STPG_YN": "N",
				"MORT_OFR_YN": "N",
				"NEW_TRN_DT": "19940407",
				"EXPT_DT": ""
			}
			]
		}
	}
	,'API_CusCertColl0200' : {	// 금융소득종합과세 조회및발급
		'BT_NAME'	: 'API_CusCertColl0200',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'TRN_DSTC'				:'2',		// 1:조회 , 2:발급
			'CSNO'					:'10104838388',
			'RVRS_YR'				:'2020',
			"INDV_CORP_DSTC_CD"		:"1",		// 1:개인, 2:법인
			"EML_C50"				:"isys123@comtec.co.kr",
			"RNNO_C13"				:"7808152292933"
		}
	}
	,'API_CusCertColl0100' : {	// 원천징수영수증 조회및발급
		'BT_NAME'	: 'API_CusCertColl0100',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'TRN_DSTC'				:'2',		// 1:조회 , 2:발급
			'INQ_STDT'				:'20200110',
			'INQ_EDDT'				:'20200310',
			'ACNO'					:'10101130059242',
			"INDV_CORP_DSTC_CD"		:"1",		// 1:개인, 2:법인
			"EML_C50"				:"khji@kci.co.kr",
			"RNNO_C13"				:"7808152292933"
		}
	}
	,'API_CusCertFine0200' : {	// 금융거래확인서 조회및발급
		'BT_NAME'	: 'API_CusCertFine0200',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			"TRN_DSTC"				:"2",		// 1:조회 , 2:발급
			"CSNO"					:"31004838388",
			"ISS_BSDT"				:"20200527",
			"INTG_MCF_USE_USG_CNTN"	:"회사제출용",
			"FEE"					:"1000",	// 수수료
			"WTCH_ACNO"				:"31061130025021",
			"WTCH_ACCO_C700"		:"1004",
			"LOAN_BLNC_SUM"			:"2254702",
			"INDV_CORP_DSTC_CD"		:"1",		// 1:개인, 2:법인
			"EML_C50"				:"isys123@comtec.co.kr",
			"RNNO_C13"				:"7808152292933"
		}
	}
	,'API_CusCertDebt0200' : {	// 부채잔액증명서 조회및발급
		'BT_NAME'	: 'API_CusCertDebt0200',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'TRN_DSTC'				:'2',			// 1:조회 , 2:발급
			'CSNO'					:'10104838388',
		    'ISS_BSDT'				:'20200310',
		    'INTG_MCF_USE_USG_CNTN'	:'회사제출용',
		    'INTG_MCF_PRPL_NM'		:'은행',
		    'FEE'					:'1000',			// 수수료
		    'WTCH_ACNO'				:'10161130025021',
		    'WTCH_ACCO_C700'		:'1004',
		    "LOAN_BLNC_SUM"			:"2254702",
			"INDV_CORP_DSTC_CD"		:"1",		// 1:개인, 2:법인
			"EML_C50"				:"khji@kci.co.kr",
			"RNNO_C13"				:"7808152292933"
		}
	}
	,'API_IbaSuadStad0100' : {	// 거래중지계좌관리 - 재개신청 대상조회
		'BT_NAME'	: 'API_IbaSuadStad0100',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'CSNO'					:'10104838388',
		}
	}
	,'API_IbaSuadStad0200' : {	// 거래중지계좌관리 - 재개신청 전조회
		'BT_NAME'	: 'API_IbaSuadStad0200',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'ACNO'					:'10161130025021',
		}
	}
	,'API_IbaSuadStad0300' : {	// 거래중지계좌관리 - 재개신청
		'BT_NAME'	: 'API_IbaSuadStad0300',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'ACNO'					:'10161130025021',
		}
	}
	,'API_IbaSuadStad0400' : {	// 거래중지계좌관리 - 해지신청 전조회
		'BT_NAME'	: 'API_IbaSuadStad0400',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'ACNO'					:'10161130025021',
		}
	}
	,'API_IbaSuadStad0500' : {	// 거래중지계좌관리 - 해지신청 본인확인
		'BT_NAME'	: 'API_IbaSuadStad0500',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'ACNO'					:'10161130025021',
			'RNNO'					:'8506201047016',
			'OPEN_BKCD'				:'101'
		}
	}
	,'API_IbaSuadStad0600' : {	// 거래중지계좌관리 - 해지신청
		'BT_NAME'	: 'API_IbaSuadStad0600',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'049',
//			'ACNO'					:'10161130025021',
//			'ACCO_PWD'				:'',
//			'RMTN_BKCD'				:'296',
//			'RMTN_ACTNO'			:'02161130021709',
//			'CSNO'					:'10104838388'
			"ACNO": "04961130064169",
			"ACCO_PWD": "1357",
			"RMTN_BKCD": "049",
			"RMTN_ACTNO": "04961130064258"
		}
	}
	,'API_IbaSuadStad0700' : {	// 거래중지계좌관리 - 계좌목록조회
		'BT_NAME'	: 'API_IbaSuadStad0700',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'CSNO'					:'10104838388'
		}
	}
	,'API_IbaDrcl0100' : {	// 출금계좌 등록변경
		'BT_NAME'	: 'API_IbaDrcl0100',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'CSNO'					:'',
			'USER_ID_12'			:'',
			'REG_DVCD'				:'',
			'WTCH_ACNO'				:''
		}
	}
	,'API_stampPublicKey' : {	// QR공개키요청
		'BT_NAME'	: 'API_stampPublicKey',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101'
		}
	}
	,'API_ComMail' : {	// QR공개키요청
		'BT_NAME'	: 'API_ComMail',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
				"STRG_FILE_PATH_NM": "",
				"INET_ATFL_PATH_NM": "/terms/temp01.pdf",
				"RCMS_EMAD": "isys123@comtec.co.kr",
//				"RCMS_EMAD": "kmj@fsb.or.kr",
				"EML_TTL_NM": "금융거래목적확인서",
				"BANK_CUST_NM": "김명준",
				"SVBN_KRN_NM": "부림",
				"TMPL_FILE_NM": "sb_commail_0101.html",
				"FAX": "031-443-3693"
		}
	}
	
	,'API_CusUaca0500' : {	// 자주쓰는계좌관리 - 삭제완료
		'BT_NAME'	: 'API_CusUaca0500',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'USR_ID_12'				:'',
			'TRTM_DVCD'				:'3',
			'MNRC_BANK'				:'',
			'MNRC_ACCO'				:'',
			'DEPR_NM_20'			:'',
			'ALS'					:''
		}
	}
	
	,'API_CusUaca0100' : {	// 자주쓰는계좌관리 - 목록조회
		'BT_NAME'	: 'API_CusUaca0100',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'USR_ID'				:'',
			'TRTM_DVCD'				:'2',
			'MNRC_BANK'				:'',
			'MNRC_ACCO'				:'',
			'DEPR_NM'				:'',
			'ALS'					:''
		}
	}
	
	,'API_CusUaca0300' : {	// 자주쓰는계좌관리 - 등록
		'BT_NAME'	: 'API_CusUaca0300',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'USR_ID_12'				:'',
			'TRTM_DVCD'				:'1',
			'MNRC_BANK'				:'',
			'MNRC_ACCO'				:'',
			'DEPR_NM_20'			:'',
			'ALS'					:''
		}
	}
	
	,'API_CusUaca0200_01' : {	// 자주쓰는계좌관리 - 단순수취인조회
		'BT_NAME'	: 'API_CusUaca0200_01',
		'PARAMS'	: {
			'JEX_BANKCODE'			:'101',
			'USER_ID_12'				:'',
			'MNRC_BANK'				:'',
			'MNRC_ACNO_16'			:'',
			'CSNO'					:'',
		}
	}

};