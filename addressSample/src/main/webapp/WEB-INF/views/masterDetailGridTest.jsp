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

.icon-save {
	background-image: url("save.png");
}
</style>
<script>
	Ext
			.onReady(function() {

				var newInstance = false;

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

					/**
					 * 툴바 설정
					 */
					dockedItems : [ {
						xtype : 'toolbar',
						items : [ {
							text : '추가',
							iconCls : 'icon-add',
							handler : function() {
								addressStore.insert(0, new Address({
									name : "",
									address : "",
									tel : ""
								}));

								var grid = mdPanel.down("address-grid");
								// 						var store = grid.getStore();

								// 						var record;
								// 						var modelType = grid.modelType;

								// 						console.log(modelType);

								// 						// 해당 store의 모델 생성
								// 						if (modelType) {
								// 							record = Ext.create(modelType);
								// 						} else {
								// 							var model = {
								// 								extend: 'Ext.data.Model',
								// 								fields: store.model.getFields()
								// 							};
								// 							record = Ext.define('phantomRecord', model);
								// 						}

								// 						store.insert(0, record);

								grid.getSelectionModel().select(0); //그리드의 첫번째 로우를 선택한다.
							}
						} ]
					} ],

					initComponent : function(config) {
						var me = this;
						me.callParent(arguments);
					}
				});

				/*
				   주소록 디테일
				   마스터 그리드의 로우를 클릭하면 
				   디테일 영역의 Form에 관련 데이터가 매핑됨
				 */
				Ext
						.define(
								"AddressForm",
								{
									extend : "Ext.form.Panel",
									alias : "widget.address-form",
									layout : "fit",
									frame : true,
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
									/**
									 * 툴바 설정
									 */
									dockedItems : [ {
										xtype : 'toolbar',
										items : [
												{
													text : '추가',
													iconCls : 'icon-add',
													handler : function() {
														console
																.log("신규 버튼이 클릭 되었습니다.");
														this.up("address-form")
																.getForm()
																.reset();

														newInstance = true;

														console
																.log("newInstance :: "
																		+ newInstance);

													}
												},
												"-",
												{
													text : "Save",
													iconCls : "icon-save",
													handler : function() {
														console
																.log("저장 버튼이 클릭 되었습니다.");
														var form = this.up(
																"address-form")
																.getForm();
														var grid = mdPanel
																.down("address-grid");
														var store = grid
																.getStore();
														var formValues = form
																.getValues();

														if (newInstance) {
															store
																	.add(formValues);
															newInstance = false;
														} else {
															var recordIndex = form
																	.getRecord().index;
															var record = grid
																	.getStore()
																	.getAt(
																			recordIndex);
															record.beginEdit();
															record
																	.set(formValues);
															record.endEdit();
														}
													}
												},
												"-",
												{
													text : 'Delete',
													iconCls : 'icon-delete',
													handler : function() {
														var form = this.up(
																"address-form")
																.getForm();
														var grid = mdPanel
																.down("address-grid");
														var store = grid
																.getStore();
														var formValues = form
																.getValues();
														var recordIndex = form
																.getRecord().index;
														var record = grid
																.getStore()
																.getAt(
																		recordIndex);

														Ext.Msg
																.confirm(
																		"Confirm",
																		"확실히 지우시겠습니까?",
																		function(
																				btn) {
																			if (btn === "yes") {
																				console
																						.log("지운데");
																				store
																						.remove(record);
																			} else {
																				console
																						.log("안 지운데 ");
																			}
																		});

													}
												} ]
									} ]
								// 			buttons : [ {
								// 				text : "작업저장",
								// 				handler : function() {
								// 					var form = this.up("address-form").getForm();

								// 					var grid = mdPanel.down("address-grid");
								// 					var recordIndex = form.getRecord().index;

								// 					var store = grid.getStore();

								// 					var formValues = form.getValues();
								// 					var record = grid.getStore().getAt(recordIndex);

								// 					console.log("store length :: " + store.data.length);

								// 					var values = form.getValues();

								// 					console.log(form.getRecord());

								// 					console.log(form.getValues());
								// 					console.log(form.getRecord().data);

								// 					var formRecord = form.getRecord();
								// 					var formRecordData = form.getRecord().data;
								// 					var formData = form.getValues();

								// 					// 					formRecordData.name = formData.name; 
								// 					// 					formRecordData.address = formData.address; 
								// 					// 					formRecordData.tel = formData.tel;
								// 					console.log("~~~~~~~~~~~~~~~~~~~~~~");

								// 					console.log(form.getRecord().data);

								// 					//store.sync();

								// 					// 					for(var i=0;i<store.data.length;i++){
								// 					// 						console.log((i+1)+" : "+store.data.items[i].data.name);
								// 					// 					}

								// 					//form.updateRecord(form.getRecord());

								// 					formRecord.beginEdit();
								// 					formRecord.set(formValues);
								// 					console.log("******************");
								// 					console.log(form.getRecord());

								// 					formRecord.endEdit();

								// 				}
								// 			}, {
								// 				text : "Reset",
								// 				handler : function() {
								// 					this.up("address-form").getForm().reset();
								// 				}
								// 			} ]
								});

				var mdPanel = Ext.create("Ext.panel.Panel", {
					layout : "border",
					renderTo : Ext.get("grid"),
					title : "주소록",
					frame : true,
					width : 600,
					height : 520,
					items : [ {
						region : "north",
						height : 300,
						xtype : "address-grid",
						split : true
					}, {
						region : "center",
						height : 200,
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