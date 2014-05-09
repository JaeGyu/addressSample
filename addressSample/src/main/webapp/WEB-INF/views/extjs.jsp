<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<style type="text/css">
	.image {width : 130px}
</style>
<link
	href='http://cdn.sencha.io/ext/gpl/4.2.1/resources/css/ext-all.css'
	rel='stylesheet' />
<script src='http://cdn.sencha.io/ext/gpl/4.2.1/ext-all.js'></script>
<script>
	//로딩이 된후 바로 호출이 되도록 onReady 
	Ext.onReady(function() {
		console.log("로딩이 되었습니다.");

		//1.모델을 정의 
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
			} ]
		});

		//2. 스토어 정의 
		var addressStore = Ext.create("Ext.data.Store", {
			autoLoad : true,
			autoSync : true, //true이면 store의 값에 변동이 생기면 자동으로 이벤트가 발생해서 ajax처리를 한다. 
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
					root : 'address', //root를 안적어 주면 현재 응답 구조에선 제대로 출력 안됨 
					successProperty : 'success'
				},
				writer : {
					type : "json",
					writeAllFields : true //모든 필드의 데이터를 전송할때 true로 한다. 디폴트는 true 
				}
			}
		});

		var rowEditing = Ext.create("Ext.grid.plugin.RowEditing", {
			clicksToEdit : 2 // row를 에디트 하기위해 클릭을 몇번하는지 지정 지금은 2번 클릭해야 에디트 기능을 쓸 수 있음 
			//이 예제에선 삭제를 위해 로우 하나를 클릭해놓고 삭제 버튼을 눌러야 하는데 한번
			//클릭하변 에디트 기능이 나와서 에디트기능은 더블클릭시 호출되도록 변경함  
		});

		Ext.create("Ext.grid.Panel", {
			title : "주소록",
			height : 300,
			width : 600,
			store : addressStore,
			plugins : [ rowEditing ],
			selType : "rowmodel",
			columns : [ {
				header : "이름",
				dataIndex : "name",
				editor : {
					allowBlank : false
				}
			}, {
				header : "주소",
				dataIndex : "address",
				editor : {
					allowBlank : false
				}
			}, {
				header : "전화번호",
				dataIndex : "tel",
				editor : {
					allowBlank : false
				}
			}, {
				header : "삭제",
				xtype : "actioncolumn",
				items : [ {
					icon : "deleteButton.png",
					iconCls : "image", //위 아이콘의 css class를 정의 함 
					handler : function(grid, rowNum, colNum) {
						var store = grid.getStore();
						var id = store.getAt(rowNum);
						store.remove(id);
					}
				} ]
			} ],
			renderTo : Ext.get("grid")
		});
	});
</script>
</head>
<body>
	<div id="grid"></div>
</body>
</html>