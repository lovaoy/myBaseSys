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
    <label class="layui-form-label">角色名</label>
    <div class="layui-input-inline">
      <input type="text" name="role" id="role" required lay-verify="required" placeholder="角色名" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">角色描述</label>
    <div class="layui-input-inline">
      <input type="text" name="description" id="description" required lay-verify="required" placeholder="角色描述" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" lay-submit lay-filter="formDemo">添加</button>
      <!-- 此处如果用button会出现点击按钮时input会一闪而过请填写此项 ，如果input中有内容会导致要点击两次才能返回-->
      <a href="roleInfo" class="layui-btn layui-btn-warm">返回</a>
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
      url: "../role/roleAdd",
      data: {
        "role": data.field.role
        ,"description": data.field.description
      },
      traditional: true, //阻止深度序列化，后台能否接收的关键
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
