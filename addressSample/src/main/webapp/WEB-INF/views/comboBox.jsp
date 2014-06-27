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
	//콤보박스
	Ext.onReady(function() {
		Ext.define("User", {
			extend : "Ext.data.Model",
			fields : [ {
				type : "string",
				name : "fullName"
			}, {
				type : "int",
				name : "userID"
			} ]
		});

		var store = Ext.create("Ext.data.Store", {
			model : "User",
			proxy : {
				type : "ajax",
				url : "data/users.jsonn",
				reader : {
					type : "json",
					root : "users"
				}
			}
		});

		var formPanel = Ext.create("Ext.form.Panel", {
			title : "ComboBox with server side data example",
			width : 350,
			autoHeight : true,
			bodyPadding : 10,
			items : [ {
				xtype : "combobox",
				fieldLabel : "Select User",
				displayField : "fullName",
				valueField : "userId",
				store : store,
				queryMode : "remote",
				forceSelection : true,
				anchor : "100%"
			} ],
			renderTo : Ext.getBody(),
			style : "margin: 50px"
		});
	});
</script>
</head>
<body>
</body>
</html>