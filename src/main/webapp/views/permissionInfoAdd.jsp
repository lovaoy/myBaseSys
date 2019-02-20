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
<div class="table-responsive">
  <form class="layui-form" action="">
    <div class="layui-form-item">
      <div class="layui-inline">
    <label class="layui-form-label">是否可用</label>
    <div class="layui-input-inline">
      <select name="available" lay-filter="available">
        <option value="1" selected="">true</option>
        <option value="0">false</option>
      </select>
    </div>
  </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">权限名</label>
    <div class="layui-input-inline">
      <input type="text" name="name" id="name" required lay-verify="required" placeholder="权限名" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">父编号</label>
    <div class="layui-input-inline">
      <input type="text" name="parentId" id="parentId" required lay-verify="required" placeholder="父编号" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">父编号列表</label>
    <div class="layui-input-inline">
      <input type="text" name="parentIds" id="parentIds" required lay-verify="required" placeholder="父编号列表" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">权限</label>
    <div class="layui-input-inline">
      <input type="text" name="permission" id="permission" required lay-verify="required" placeholder="权限" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-inline">
  <label class="layui-form-label">资源类型</label>
  <div class="layui-input-inline">
    <select name="resourceType" lay-filter="resourceType">
      <option value="button" selected="">button</option>
      <option value="menu">menu</option>
      <option value="directory">directory</option>
    </select>
  </div>
</div>
</div>
  <div class="layui-form-item">
    <label class="layui-form-label">资源路径</label>
    <div class="layui-input-inline">
      <input type="text" name="url" id="url" placeholder="资源路径" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" lay-submit lay-filter="formDemo">添加</button>
      <!-- 此处如果用button会出现点击按钮时input会一闪而过请填写此项 ，如果input中有内容会导致要点击两次才能返回-->
      <a href="permissionInfo" class="layui-btn layui-btn-warm">返回</a>
    </div>
  </div>
  </form>
  <script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
  <script>
  layui.use('form', function(){
  var form = layui.form;
  var $ = layui.$;

  //监听提交
  form.on('submit(formDemo)', function(data){
    $.ajax({
      type: 'POST',
      url: "../permission/permissionAdd",
      data: data.field,
      success: function(data){
        var jsondata = $.parseJSON(data);
          layer.msg(jsondata.msg);

      }});
      return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
  });

  });
  </script>
</body>
</html>
