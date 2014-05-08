<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
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
			autoSync : true,
			model : "address",
			proxy : {
				type : "ajax",
				api : {
					read : "list.json"
				},
				reader : {
					type : "json"
				}
			}
		});

		
		var rowEditing = Ext.create("Ext.grid.plugin.RowEditing",{
			clicksToEdit:1
		});
		
		Ext.create("Ext.grid.Panel",{
			title:"주소록",
			height
		});
		
	});
</script>
</head>
<body>Ext!!
</body>
</html>