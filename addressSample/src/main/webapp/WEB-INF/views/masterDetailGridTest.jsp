<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf8" />
<link
	href='http://cdn.sencha.io/ext/gpl/4.2.1/resources/css/ext-all.css'
	rel='stylesheet' />
<script src='http://cdn.sencha.io/ext/gpl/4.2.1/ext-all.js'></script>
<script>
	Ext.onReady(function() {
		//모델 정의  -->ok
		//스토어 정의  -->ok
		// 폼 패널 정의  -->ok
		// 그리드 정의  -->ok
		//마스터 디테일 패널 정의 
		//마스터 디테일 패널에 그리드 패널과 폼패널 연결 하기
		//툴바 생성하기
		//CRUD 테스트 하기 

		Ext.define("address", {
			extend : "Ext.data.Model",
			idProperty : "id",
			fields : [ {
				name : "id",
				type : "int"
			}, {
				name : "name",
				type : "string"
			}, {
				name : "address",
				type : "string"
			}, {
				name : "tel",
				type : "string"
			} ],
		});

		var addressStore = Ext.create("Ext.data.Store", {
			autoLoad : true,
			autoSync : true,
			model : "address",
			proxy : {
				type : "ajax",
				api : {
					read : "list.json",
					update : "update.json",
					create : "insert.json",
					destroy : "delete.json"
				},
				reader : {
					type : "json",
					root : "address",
					successProperty : "success"
				},
				writer : {
					type : "json",
					writeAllFields : true
				}
			}
		});

		Ext.define("AddressGrid", {
			extend : "Ext.grid.Panel",
			alias : "widget.address-grid",
			height : 300,
			width : 600,
			store : addressStore,
			//plugins : [ rowEditing ],
			selType : "rowmodel", // 잘 모르 겠음 
			columns : [ {
				header : "이름",
				dataIndex : "name",
				editor : {
					allowBlank : false
				//공백을 허용하지 않겠다. 
				}
			}, {
				header : "주소",
				dataIndex : "address",
				flex : 1,
				editor : {
					allowBlank : false
				}
			}, {
				header : "전화번호",
				dataIndex : "tel",
				editor : {
					allowBlank : false
				}
			} ],
		//	renderTo : Ext.get("grid")
		});

		Ext.define("AddressForm", {
			extend : "Ext.form.Panel",
			alias : "widget.address-form",
			layout : "fit",
			//renderTo:Ext.getBody(),
			items : [ {
				xtype : "container",
				layout : "vbox",
				items : [ {
					xtype : "textfield",
					fieldLabel : "이름",
					name : "name",
					labelAlign : "left",
					allowBlank : false,
					emptyText : "이름을 입력 하세요"
				}, {
					xtype : "textfield",
					fieldLabel : "주소",
					name : "address",
					labelAlign : "left",
					allowBlank : false,
					emptyText : "주소를 입력 하세요"
				}, {
					xtype : "textfield",
					fieldLabel : "전화번호",
					name : "tel",
					labelAlign : "left",
					allowBlank : false,
					emptyText : "전화번호를 입력 하세요"
				} ]
			} ]
		});

		Ext.create("Ext.panel.Panel", {
			layout : "border",
			renderTo : Ext.get("grid"),
			title : "addressMd",
			frame : true,
			width : 600,
			height:500,
			items : [ {
				region : "north",
				height : 300,
				xtype : "address-grid",
				split:true
			}, {
				region : "center",
				height : 100,
				xtype : "address-form",
			} ]
		});

	});
</script>
</head>
<body>
	<div id="grid"></div>
</body>
</html>