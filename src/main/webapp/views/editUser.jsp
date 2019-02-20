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
  <div class="">
    <div class="layui-form-item">
        <label for="username" class="layui-form-label">用户名：</label>
      <div class="layui-input-block">
        <input type="text" id="username" name="username" readonly/>
      </div>
    </div>
    <div class="layui-form-item">
      <label for="name" class="layui-form-label">名称：</label>
      <div class="layui-input-block">
        <input type="text" id="name" name="name" />
      </div>
    </div>
    <div class="layui-form-item">
      <label for="state" class="layui-form-label">状态：</label>
      <div class="layui-input-block">
        <select name="state" id=state>
          <option value="1">正常</option>
          <option value="0">未认证</option>
          <option value="2">锁定</option>
        </select>
      </div>
    </div>
  </div>
</body>
