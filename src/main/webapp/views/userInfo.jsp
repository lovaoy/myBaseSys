<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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
    搜索用户：
    <div class="layui-inline">
        <input class="layui-input" name="keyword" id="nameReload" autocomplete="off" placeholder="用户名" width=150>
    </div>
    状态：
    <div class="layui-inline">
      <select class="layui-select" name="state" id="stateReload">
        <option></option>
        <option>正常</option>
        <option>未认证</option>
        <option>锁定</option>
      </select>
    </div>
    <button class="layui-btn" data-type="reload" id="userSearch">搜索</button>
    <button class="layui-btn" id="addUser" onclick="addUser()">添加用户</button>
  </div>
</script>
<div class="table-responsive">

    <table id="demo" lay-filter="user"></table>
</div>
<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script>
//全局变量，用于保存自页面传递过来的值
var checkedRole;

function getChecked(obj){
  checkedRole = obj;
}

layui.use('table', function(){
  var table = layui.table;
  var $ = layui.$;
  //第一个实例
  table.render({
    elem: '#demo'
    ,height: $(window).height() - 10
    ,url: '/demo/userInfo/userShow' //数据接口
    ,page: true //开启分页
    ,cols: [[ //表头
      {field: 'uid', title: 'ID', width:80, sort: true, fixed: 'left'}
      ,{field: 'username', title: '用户名', width:180}
      ,{field: 'name', title: '名称', width:180, sort: true}
      ,{field: 'state', title: '状态', width:120,templet: function(d){
        if(d.state == 0)
          return '未认证';
        else if(d.state == 1)
          return '正常';
        else if(d.state == 2)
          return '锁定';

      }
    }
    ,{field: 'roles', title: '角色', width:180,templet: function(d){
      if(d.roleList != ""){
        //js map 方法遍历对象
        var roles = d.roleList.map(function(value,index){
          console.log(value.role);
          return value.role;
        });
        return roles;
      }
      else {
        return '';
      }
    }}
    ,{fixed: 'right', width:250, align:'center', toolbar: '#barDemo'} //这里的toolbar值是模板元素的选择器
    ]]
    ,toolbar: '#toolbarDemo'
    ,defaultToolbar: ['filter', 'print', 'exports']
  });

  //监听工具条
table.on('tool(user)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
  var data = obj.data; //获得当前行数据
  //console.log(data.roleList[0].role);
  var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
  var tr = obj.tr; //获得当前行 tr 的DOM对象

  if(layEvent === 'role'){ //角色
    //do somehing
    layer.open({
            type: 2 //此处以iframe举例
            ,title: '角色分配'
            ,area: ['500px','350px']
            ,content: '/demo/views/rolesAllot.jsp'
            ,btn: ['分配', '关闭'] //只是为了演示
            //以下方法实现角色分配后将结果同步到数据库
            ,yes: function(index,layero){
              //console.log(checkedRole);
              //取出选中的role的id
              var ids = new Array();
              for(var i=0; i<checkedRole.length; i++){
                ids.push(checkedRole[i].id);
              }
              console.log(ids);
              layer.close(index);
              $.ajax({
                type: 'POST',
                url: "roleAllot",
                data: {
                  "uid": data.uid,
                  "ids": ids
                },
                traditional: true, //阻止深度序列化，后台能否接收的关键
                success: function(data){

                  var jsondata = $.parseJSON(data);
                  layer.msg(jsondata.msg);
                  table.reload('demo',{}); //刷新table，否则看不到更改的信息
            }});
            }
            ,btn2: function(){
              layer.close();
            }

            ,zIndex: layer.zIndex //重点1
            //此时layer层创建完毕，但是table中还没有数据，所以rows为undefined
            ,success: function(layero,index){
              layer.setTop(layero); //重点2
              var body = layer.getChildFrame('body', index);//通过该对象可以获取iframe中的dom元素
              //将data传到弹出层
              var roles;
              if(data.roleList != ""){
                roles = data.roleList.map(function(value,index){
                //  console.log(value.role);
                  return value.role;
                });
              }
              body.find("#data").val(roles);

            }
          });
  } else if(layEvent === 'reset'){ //重置密码
    layer.confirm('确定重置密码吗?', {icon: 3, title:'提示'}, function(index){
      //do something
      $.ajax({
        type: 'POST',
        url: "resetPwd",
        data: {
          "username": data.username
        },
        traditional: true, //阻止深度序列化，后台能否接收的关键
        success: function(data){
          layer.close(index);
          var jsondata = $.parseJSON(data);
          layer.msg(jsondata.msg);
        }});

    });

  } else if(layEvent === 'edit'){ //编辑
    //do something
    layer.open({
            type: 2 //此处以iframe举例
            ,title: '修改用户信息'
            ,area: ['300px','350px']
            ,content: '/demo/views/editUser.jsp'
            ,btn: ['确认', '关闭'] //只是为了演示
            ,yes: function(index,layero){
              var body = layer.getChildFrame('body', index);//通过该对象可以获取iframe中的dom元素
              var newName = body.find("#name").val();
              var newState = body.find("#state").val();
              layer.close(index);
              $.ajax({
                type: 'POST',
                url: "updateUser",
                data: {
                  "username": data.username,
                  "name": newName,
                  "state": newState

                },
                traditional: true, //阻止深度序列化，后台能否接收的关键
                success: function(data){

                  var jsondata = $.parseJSON(data);
                  layer.msg(jsondata.msg);
                  table.reload('demo',{}); //刷新table，否则看不到更改的信息
            }});

            }
            ,btn2: function(){
              layer.close();
            }

            ,zIndex: layer.zIndex //重点1
            ,success: function(layero,index){
              layer.setTop(layero); //重点2
              var body = layer.getChildFrame('body', index);//通过该对象可以获取iframe中的dom元素
              var w = $(layero).find("iframe")[0].contentWindow;//通过该对象可以获取iframe中的变量，调用iframe中的方法
              body.find("#username").val(data.username);//对iframe中的dom赋值
              body.find("#name").val(data.name);//对iframe中的dom赋值
              body.find("#state").val(data.state);//对iframe中的dom赋值
            }
          });
    //同步更新缓存对应的值
    obj.update({

    });
  }
});

var active = {
        reload: function(){
            var nameReload = $('#nameReload');
            var stateReload = $('#stateReload');

            table.reload('demo', {
                where: {
                    name: nameReload.val()
                    ,state: stateReload.val()
                }
                ,page: {
                    curr: 1 //重新从第 1 页开始
                  }
            });
        }
    };

//绑定搜索点击事件，将关键字传到后台,不能直接用$('#userSearch').on('click',function)
    $(document).on('click','#userSearch', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
});
});

function addUser(){
  window.location.href="userAdd"
}

</script>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="role">角色分配</a>
  <a class="layui-btn layui-btn-xs" lay-event="edit">修改信息</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="reset">密码重置</a>
</script>
</body>
</html>
