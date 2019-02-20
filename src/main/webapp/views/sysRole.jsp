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
    <button class="layui-btn" id="addRole" onclick="addRole()">添加角色</button>
  </div>
</script>
<div class="table-responsive">

    <table id="demo" lay-filter="role"></table>
</div>
<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script>
//全局变量，用于保存自页面传递过来的值
var checkedPermissions;

function getChecked(obj){
  checkedPermissions = obj;
}
layui.use('table', function(){
  var table = layui.table;
  var $ = layui.$;
  //第一个实例
  table.render({
    elem: '#demo'
    ,height: $(window).height() - 10
    ,url: '/demo/role/roleList' //数据接口
    ,cols: [[ //表头
      {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
      ,{field: 'role', title: '角色', width:180}
      ,{field: 'description', title: '描述', width:180}
      ,{fixed: 'right', width:250, align:'center', toolbar: '#barDemo'} //这里的toolbar值是模板元素的选择器
    ]]
    ,toolbar: '#toolbarDemo'
    ,defaultToolbar: ['filter', 'print', 'exports']
  });

  //监听工具条
table.on('tool(role)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
  var data = obj.data; //获得当前行数据
  var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
  var tr = obj.tr; //获得当前行 tr 的DOM对象

  if(layEvent === 'permission'){ //角色
    //do somehing
    layer.open({
            type: 2 //此处以iframe举例
            ,title: '权限配置'
            ,area: ['500px','350px']
            ,content: '/demo/views/permissionAllot.jsp'
            ,btn: ['分配', '关闭'] //只是为了演示
            //以下方法实现角色分配后将结果同步到数据库
            ,yes: function(index,layero){

              console.log(checkedPermissions);
              layer.close(index);
              $.ajax({
                type: 'POST',
                url: "permissionAllot",
                data: {
                  "roleId": data.id,
                  "permissionIds": checkedPermissions
                },
                traditional: true, //阻止深度序列化，后台能否接收的关键
                success: function(data){

                  var jsondata = $.parseJSON(data);
                  layer.msg(jsondata.msg);

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
              console.log(data);
              var permissions;
              if(data.permissions != ""){
                permissions = data.permissions.map(function(value,index){
                //  console.log(value.role);
                  return value.permission;
                });
              }
              body.find("#data").val(permissions);

            }
          });
  } else if(layEvent === 'del'){ //重置密码


  } else if(layEvent === 'edit'){ //编辑
    //do something

  }
});

});

function addRole(){
  window.location.href="roleInfoAdd"
}
</script>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="permission">权限配置</a>
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">角色删除</a>
</script>
</body>
</html>
