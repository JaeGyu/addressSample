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
        width: 400,
        height: 300,
        frame: true,
        title: 'Addresses',
        store: store,
        iconCls: 'icon-user',
        columns: [{
            text: 'Name',
            flex: 1,
            sortable: true,
            dataIndex: 'name',
            field: {
                xtype: 'textfield'
            }
        }, {
            header: 'Address',
            width: 80,
            sortable: true,
            dataIndex: 'address',
            field: {
                xtype: 'textfield'
            }
        }, {
            text: 'Tel',
            width: 80,
            sortable: true,
            dataIndex: 'tel',
            field: {
                xtype: 'textfield'
            }
        }],
        dockedItems: [{
            xtype: 'toolbar',
            items: [{
                text: 'Add',
                iconCls: 'icon-add',
                handler: function(){
                    // empty record
                    store.insert(0, new Address());
                    rowEditing.startEdit(0, 0);
                }
            }, '-', {
                itemId: 'delete',
                text: 'Delete',
                iconCls: 'icon-delete',
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