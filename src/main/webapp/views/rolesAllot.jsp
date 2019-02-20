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
  <div class="table-responsive">

      <table id="demo" lay-filter="role"></table>
      <input type="hidden" name="data" id="data">
  </div>
  <script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
  <script>
  layui.use('table', function(){
    var table = layui.table;
    var $ = layui.$;
    //第一个实例
    table.render({
      elem: '#demo'
      ,height: $(window).height() - 10
      ,url: '/demo/role/roleList' //数据接口
      ,cols: [[ //表头
        {type: 'checkbox', fixed: 'left'}
        ,{field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
        ,{field: 'role', title: '角色', width:180}
        ,{field: 'description', title: '描述', width:180}
      ]]
      //给当前用户具有到角色前打勾
      ,done: function(res, curr, count){
        //如果是异步请求数据方式，res即为你接口返回的信息。
        //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
        var data = $("#data").val();
        //console.log(data);
        for(var i = 0; i<res.data.length; i++){
          //console.log(data.indexOf(res.data[i].role))
          if(data.indexOf(res.data[i].role)>=0){
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
    table.on('checkbox(role)', function(obj){
      //console.log(parent);
      parent.getChecked(table.checkStatus('demo').data); //选中行的相关数据
    });
  });
  </script>
  </body>
  </html>
