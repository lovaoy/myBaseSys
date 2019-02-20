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
<script type="text/html" id="toolbarDemo">
  <div class="table-search">
    <button class="layui-btn" id="addPermission" onclick="addPermission()">添加权限</button>
  </div>
</script>
<div class="table-responsive">

    <table id="demo" lay-filter="permission"></table>
</div>
<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script>
layui.config({
    base: '${pageContext.request.contextPath}/static/mymodule/'
}).extend({
    treetable: 'treetable-lay/treetable'
}).use(['treetable'], function(){
  var table = layui.treetable;
  var $ = layui.$;
  //第一个实例
  table.render({
    treeColIndex: 2,          // treetable新增参数,树形图标显示在第几列
    treeSpid: -1,             // treetable新增参数,最上级的父级id
    treeIdName: 'id',       // treetable新增参数,id字段的名称
    treePidName: 'parentId',     // treetable新增参数,pid字段的名称
    treeDefaultClose: false,   // treetable新增参数,是否默认折叠
    treeLinkage: true,        // treetable新增参数,父级展开时是否自动展开所有子级
    elem: '#demo'
    ,height: $(window).height() - 10
    ,url: '/demo/permission/permissionList' //数据接口
    ,cols: [[ //表头
      {type: 'numbers'}
      ,{field: 'available', title: '是否可用', width:100}
      ,{field: 'name', title: '名称', width:200}
      ,{field: 'id', title: 'ID', width:80}
      ,{field: 'parentId', title: '父编号', width:80}
      ,{field: 'parentIds', title: '父编号列表', width:120}
      ,{field: 'permission', title: '权限', width:180}
      ,{field: 'resourceType', title: '资源类型', width:100}
      ,{field: 'url', title: 'URL', width:250}
    ]]
    ,toolbar: '#toolbarDemo'
    //,defaultToolbar: ['filter', 'print', 'exports']
  });

});

function addPermission(){
  window.location.href="permissionInfoAdd"
}
</script>
</body>
</html>
