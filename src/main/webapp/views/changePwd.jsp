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
  <form class="layui-form" action="">
  <div class="layui-form-item">
    <label class="layui-form-label">旧密码</label>
    <div class="layui-input-inline">
      <input type="password" name="oldpassword" id="oldpassword" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
    </div>
    <div class="layui-form-mid layui-word-aux">输入旧密码</div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">新密码</label>
    <div class="layui-input-inline">
      <input type="password" name="newpassword" id="newpassword" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
    </div>
    <div class="layui-form-mid layui-word-aux">输入新密码</div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">新密码</label>
    <div class="layui-input-inline">
      <input type="password" name="new2password" id="new2password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
    </div>
    <div class="layui-form-mid layui-word-aux">再次输入新密码</div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" lay-submit lay-filter="formDemo">修改</button>
      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
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
    if(data.field.newpassword != data.field.new2password){
      layer.msg("两次密码输入不一致，请重新输入！");
      return false;
    }
    $.ajax({
      type: 'POST',
      url: "../userInfo/changePwd",
      data: {
        "oldpassword": data.field.oldpassword
        ,"newpassword": data.field.newpassword
      },
      traditional: true, //阻止深度序列化，后台能否接收的关键
      success: function(data){
        var jsondata = $.parseJSON(data);
        if(jsondata.success){
          layer.alert(jsondata.msg, function(index){
            window.location.href="../logout";
            layer.close(index);
          });
        }else{
          layer.msg(jsondata.msg);
        }

      }});
      return false;
  });

  //监听重置
  form.on('reset', function(data){
    $('#oldpassword').val("");
    $('#newpassword').val("");
    $('#new2password').val("");
  });
});
</script>
</body>
