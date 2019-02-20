<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>UserInfo</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">

    <!--  加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>

  </head>
  <body>
    <div class="div-addUser">
    <span id="result" style="color:red"></span>
    <form id="userForm" class="form-horizontal" method="post" onsubmit="return false;">
      <div class="form-group">
        <label for="username" class="col-sm-2 control-label">用户名：</label>
        <div class="col-sm-3">
          <input type="text" class ="form-control" name="username" placeholder="用户名" required autofocus/>
        </div>
      </div>
      <div class="form-group">
        <label for="name" class="col-sm-2 control-label">名称：</label>
        <div class="col-sm-3">
          <input type="text" class ="form-control" name="name" placeholder="名称" required/>
        </div>
      </div>
      <div class="form-group">
        <label for="password" class="col-sm-2 control-label">密码：</label>
        <div class="col-sm-3">
          <input type="password" class ="form-control" name="password" placeholder="密码" required/>
        </div>
      </div>
      <div class="form-group">
        <label for="state" class="col-sm-2 control-label">状态：</label>
        <div class="col-sm-3">
          <select class="form-control" name="state">
            <option>正常</option>
            <option>未认证</option>
            <option>锁定</option>
          </select>
        </div>
      </div>
      <div class="form-group">
        <div class="col-sm-offset-2 col-sm-2">
          <button type="submit" class="btn btn-success" id="addUser">添加</button>
        </div>
        <button class="btn btn-danger" type="button" id="back">返回</button>
      </div>
    </form>
  </div>
  <script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
  <script>
  layui.use('layer', function(){ //独立版的layer无需执行这一句
    var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句

    $('#addUser').on('click', function(){
      var username = $("input[name='username']").val();
      var name = $("input[name='name']").val();
      var password = $("input[name='password']").val();
      var state = $("select[name='state']").val();

      $.ajax({
        type: 'POST',
        url: "../userInfo/saveUser",
        data: {
          "username": username,
          "name": name,
          "password": password,
          "state": state
        },
        traditional: true, //阻止深度序列化，后台能否接收的关键
        success: function(data){
          var jsondata = $.parseJSON(data);
          layer.msg(jsondata.msg);
    }});
    });


    $('#back').on('click', function(){
      window.location.href="../userInfo/userList"
    });
  });
  </script>
  </body>
</html>
