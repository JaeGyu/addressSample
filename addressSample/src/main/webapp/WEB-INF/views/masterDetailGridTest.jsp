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
<style type="text/css">
.icon-add {
	background-image: url("add.png");
}

.icon-delete {
	background-image: url("delete.png");
}
</style>
<script>
	Ext.onReady(function() {
		//모델 정의  -->ok
		//스토어 정의  -->ok
		// 폼 패널 정의  -->ok
		// 그리드 정의  -->ok
		//마스터 디테일 패널 정의 -->ok
		//마스터 디테일 패널에 그리드 패널과 폼패널 연결 하기  -->ok
		//툴바 생성하기  -->ok
		//CRUD 테스트 하기 

		Ext.define("Address", {
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
			model : "Address",
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
			selType : "rowmodel", //Ext.selection.RowModel(rowmodel)을 selType 설정 옵션을 사용해 그리드에 적용한다. 
			listeners : {
				select : function(RowModel, record, index, eOpts) {
					/*
					  mdPanel 의 하위 객체에서  alias가 address-form
					  인 컴포넌트를 
					 */
					mdPanel.down("address-form").loadRecord(record);
				}
			},
			dockedItems : [ {
				xtype : 'toolbar',
				items : [ {
					text : '추가',
					iconCls : 'icon-add',
					handler : function() {
						// 		                    store.insert(0, new Address());
						// 		                    rowEditing.startEdit(0, 0);
						addressStore.insert(0, new Address({
							name:"",
							address:"",
							tel:""
						}));
						
						
						var grid = mdPanel.down("address-grid");
						grid.getSelectionModel().select(0);  //그리드의 첫번째 로우를 선택한다. 
						
					}
				} ]
			} ]
		});

		/*
		   주소록 디테일
		   마스터 그리드의 로우를 클릭하면 
		   디테일 영역의 Form에 관련 데이터가 매핑됨
		 */
		Ext.define("AddressForm", {
			extend : "Ext.form.Panel",
			alias : "widget.address-form",
			layout : "fit",
			title : "AddressInput Detail",
			items : [ {
				bodyPadding : 5,
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
					width : 400,
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
			} ],
			buttons : [ {
				text : "작업저장",
				handler : function() {
					var form = this.up("form").getForm();
					
					var grid = mdPanel.down("address-grid");
					var recordIndex = form.getRecord().index;
					
					console.log("recordIndex :: " + recordIndex);
					
					console.log("form.getRecord() :: "+form.getRecord());
					
					var formValues = form.getValues();
					var record = grid.getStore().getAt(recordIndex);

					
					//form.updateRecord(record);
					
					
 					record.beginEdit();
 					record.set(formValues);
 					record.endEdit();

				}
			} ]
		});

		var mdPanel = Ext.create("Ext.panel.Panel", {
			layout : "border",
			renderTo : Ext.get("grid"),
			title : "주소록",
			frame : true,
			width : 600,
			height : 500,
			items : [ {
				region : "north",
				height : 300,
				xtype : "address-grid",
				split : true
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