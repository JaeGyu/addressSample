<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf8' />
<link
	href='http://cdn.sencha.io/ext/gpl/4.2.1/resources/css/ext-all.css'
	rel='stylesheet' />
<script src='http://cdn.sencha.io/ext/gpl/4.2.1/ext-all.js'></script>
<style type="text/css">
.icon-add{
  background-image: url("add.png");
}

.icon-delete{
	background-image:url("delete.png");
}
</style>
<script>
Ext.require(['Ext.data.*', 'Ext.grid.*']);

Ext.define('Address', {
    extend: 'Ext.data.Model',
    fields: [ 'name', 'address', 'tel'],
    validations: [{
        type: 'length',
        field: 'name',
        min: 1
    }, {
        type: 'length',
        field: 'address',
        min: 1
    }, {
        type: 'length',
        field: 'tel',
        min: 1
    }]
});

Ext.onReady(function(){

    var store = Ext.create('Ext.data.Store', {
        autoLoad: true,
        autoSync: true,
        model: 'Address',
        proxy: {
        	type:'ajax',
            //type: 'rest',
            //url: 'app.php/users',
            api:{
				read: 'list.json',
				update:'update.json'
			},
            reader: {
                type: 'json',
                root: 'address'
            },
            writer: { //writer에대한 type을 정의 할 수 있다.
                type: 'json'
            }
        },
        listeners: {
            write: function(store, operation){
                var record = operation.getRecords()[0],
                    name = Ext.String.capitalize(operation.action),
                    verb;
                    
                if (name == 'Destroy') {
                    record = operation.records[0];
                    verb = 'Destroyed';
                } else {
                    verb = name + 'd';
                }
                Ext.example.msg(name, Ext.String.format("{0} user: {1}", verb, record.getId()));
                
            }
        }
    });
    
    var rowEditing = Ext.create('Ext.grid.plugin.RowEditing', {
        listeners: {
            cancelEdit: function(rowEditing, context) {
                // Canceling editing of a locally added, unsaved record: remove it
                if (context.record.phantom) {
                    store.remove(context.record);
                }
            }
        }
    });
    
    var grid = Ext.create('Ext.grid.Panel', {
        renderTo: document.body,
        plugins: [rowEditing],
        width: 800,
        height: 300,
        frame: true,
        title: '주소록',
        store: store,
        iconCls: 'icon-user',
        columns: [{
            text: '성명',
            flex: 1,
            sortable: true,
            dataIndex: 'name',
            field: {
                xtype: 'textfield'
            }
        }, {
            header: '주소',
            //width: 80,
            flex: 5,
            sortable: true,
            dataIndex: 'address',
            field: {
                xtype: 'textfield'
            }
        }, {
            text: '전화번호',
            //width: 80,
            flex: 5,
            sortable: true,
            dataIndex: 'tel',
            field: {
                xtype: 'textfield'
            }
        }],
        dockedItems: [{
            xtype: 'toolbar',
            items: [{
                text: '추가',
                iconCls: 'icon-add',
                handler: function(){
                    // empty record
                    store.insert(0, new Address());
                    rowEditing.startEdit(0, 0);
                }
            }, '-',{
                itemId: 'delete',
                text: '삭제',
                iconCls: 'icon-delete',  //위에 css로 경로를 정의 해야 된다.
                disabled: true,
                handler: function(){
                    var selection = grid.getView().getSelectionModel().getSelection()[0];
                    if (selection) {
                        store.remove(selection);
                    }
                }
            }]
        }]
    });
    grid.getSelectionModel().on('selectionchange', function(selModel, selections){
        grid.down('#delete').setDisabled(selections.length === 0);
    });
});
</script>
</head>
<body>
</body>
</html>