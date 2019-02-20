<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>HARCB</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
</head>
<body>
  <body>
    <form class="layui-form">
    <div class="layui-form-item">
          <label class="layui-form-label">选择权限</label>
          <div class="layui-input-block">
              <div id="LAY-auth-tree-index"></div>
          </div>
          <input type="hidden" name="data" id="data">
      </div>
      </form>
  <script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
  <script>
  layui.config({
  	base: '${pageContext.request.contextPath}/static/mymodule/',
  }).extend({
  	authtree: 'authtree/authtree',
  });

  layui.use(['jquery', 'authtree', 'form', 'layer'], function(){
	var $ = layui.jquery;
	var authtree = layui.authtree;
	var form = layui.form;
	var layer = layui.layer;
	// 一般来说，权限数据是异步传递过来的
	$.ajax({
		url: '/demo/permission/permissionList',
		dataType: 'json',
		success: function(res){

      var data = $("#data").val();
      //console.log(data);
      for(var i = 0; i<res.data.length; i++){
        //console.log(data.indexOf(res.data[i].role))
        if(data.indexOf(res.data[i].permission)>=0){
          //这句才是真正选中，通过设置关键字LAY_CHECKED为true选中
          res.data[i]["checked"]='true';
        }
      }

            var trees = authtree.listConvert(res.data,{
              primaryKey: 'id'
              ,startPid:-1
              ,parentKey:'parentId'
              ,nameKey: 'name'
              ,disabledKey:-'available'
              });
              console.log(trees);
            // 如果后台返回的不是树结构，请使用 authtree.listConvert 转换
            authtree.render('#LAY-auth-tree-index', trees, {
				inputname: 'authids[]',
				layfilter: 'lay-check-auth',
				autowidth: true,
        autochecked: true, //自动选中父级节点：开启后，选中某节点，会将其上层所有未选中父节点设为选中，并且将其下层所有节点设为选中；取消选中某节点，其所有子节点均取消。
        autoclose: false   //自动取消父级节点：开启后，取消选中某一子节点，当其兄弟节点均处于未选中状态，自动取消父级节点
			});
        }
    });
    //监听监听节点树节点选中状态改变(包括全选等)
    authtree.on('change(lay-check-auth)', function(data) {

				// 获取所有已选中节点
				var checked = authtree.getChecked('#LAY-auth-tree-index');
				parent.getChecked(checked);

			});
});

  /**
  layui.config({
      base: '${pageContext.request.contextPath}/static/mymodule/'
  }).extend({
      treetable: 'treetable-lay/treetable'
  }).use(['table','treetable'], function(){
    var table = layui.table;
    var treetable = layui.treetable;
    var $ = layui.$;
    //第一个实例
    treetable.render({
      treeColIndex: 1,          // treetable新增参数,树形图标显示在第几列
      treeSpid: -1,             // treetable新增参数,最上级的父级id
      treeIdName: 'id',       // treetable新增参数,id字段的名称
      treePidName: 'parentId',     // treetable新增参数,pid字段的名称
      treeDefaultClose: false,   // treetable新增参数,是否默认折叠
      treeLinkage: false,        // treetable新增参数,父级展开时是否自动展开所有子级
      elem: '#demo'
      ,height: $(window).height() - 10
      ,url: '/demo/permission/permissionList' //数据接口
      ,cols: [[ //表头
        {type: 'checkbox'}
        ,{field: 'name', title: '名称', width:250}
        ,{field: 'permission', title: '权限', width:180}
      ]]
      //给当前用户具有到角色前打勾
      ,done: function(res, curr, count){
        //如果是异步请求数据方式，res即为你接口返回的信息。
        //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
        var data = $("#data").val();
        //console.log(data);
        for(var i = 0; i<res.data.length; i++){
          //console.log(data.indexOf(res.data[i].role))
          if(data.indexOf(res.data[i].permission)>=0){
            //这句才是真正选中，通过设置关键字LAY_CHECKED为true选中
            res.data[i]["LAY_CHECKED"]='true';
            //下面三句是通过更改css来实现选中的效果
            var index= res.data[i]['LAY_TABLE_INDEX'];
            $('tr[data-index=' + index + '] input[type="checkbox"]').prop('checked', true);
            $('tr[data-index=' + index + '] input[type="checkbox"]').next().addClass('layui-form-checked');
          }
        }

    }
    });

    //监听checkbox事件并将数据传到父页面
    table.on('checkbox(permission)', function(obj){
      console.log(parent);
      parent.getChecked(table.checkStatus('demo').data); //选中行的相关数据
    });
  });
  */
  </script>
  </body>
  </html>
