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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/myadmin.css">
</head>
<body class="layui-layout-body layui-layout-admin">
<div class="layui-layout">
  <div class="layui-header">
    <div class="layui-logo">淮安农村商业银行</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item"><a href="">控制台</a></li>
      <!--<li class="layui-nav-item"><a href="">商品管理</a></li>-->
      <li class="layui-nav-item"><a href="">用户</a></li>
      <li class="layui-nav-item">
        <a href="javascript:;">其它系统</a>
        <dl class="layui-nav-child">
          <dd><a href="javascript:;" data-title="邮件管理">邮件管理</a></dd>
          <dd><a href="javascript:;" data-title="消息管理">消息管理</a></dd>
          <dd><a href="javascript:;" data-title="授权管理">授权管理</a></dd>
        </dl>
      </li>
    </ul>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
          <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
          ${name}
        </a>
        <dl class="layui-nav-child">
          <dd><a href="javascript:;" data-id="A1" data-title="基本资料">基本资料</a></dd>
          <dd><a data-url="views/changePwd.jsp" data-id="A2" data-title="修改密码">修改密码</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item"><a href="logout">退了</a></li>
    </ul>
  </div>

  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree"  lay-filter="test" id="side-bar">
        <!--
        <li class="layui-nav-item layui-nav-itemed">
          <a class="" href="javascript:;">系统设置</a>
          <dl class="layui-nav-child">
            <dd><a data-url="userInfo/userList" data-id="11" data-title="用户管理">用户管理</a></dd>
            <dd><a data-url="role/roleInfo" data-id="12" data-title="角色管理">角色管理</a></dd>
            <dd><a data-url="permission/permissionInfo" data-id="13" data-title="权限管理">权限管理</a></dd>
          </dl>
        </li>
        <li class="layui-nav-item">
          <a href="javascript:;">大数据</a>
          <dl class="layui-nav-child">
            <dd><a href="javascript:;" data-title="列表一" data-id="21">列表一</a></dd>
            <dd><a href="javascript:;" data-title="列表二" data-id="22">列表二</a></dd>
            <dd><a href="javascript:;" data-title="超链接" data-id="23">超链接</a></dd>
          </dl>
        </li>
        <li class="layui-nav-item"><a href="">云计算</a></li>
        <li class="layui-nav-item"><a href="">分布式</a></li>
        -->
      </ul>
    </div>
  </div>

      <!-- 主体内容 -->
      <div class="layui-body" id="LAY_app_body">
        <div class="layui-tab" lay-filter="demo">
          <ul class="layui-tab-title" >
            <li lay-id="0" class="layui-this"><i class="layui-icon layui-icon-home"></i></li>
          </ul>
          <ul class="rightmenu" style = "display: none;position: absolute;">
              <li data-type="closeothers">关闭其他</li>
              <li data-type="closeall">关闭所有</li>
          </ul>
          <div class="layui-tab-content">
          <div class="layui-tab-item layui-show">
              <iframe scrolling="auto" frameborder="0" src="views/index.jsp" style="width:100%;height:90%;"></iframe>
            </div>

          </div>
        </div>
      </div>

  <div class="layui-footer">
    <!-- 底部固定区域 -->
    © harcb.com - 底部固定区域
  </div>
</div>
<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script>
//JavaScript代码区域
//layui代码区域
layui.use('element', function(){
  var $ = jQuery = layui.jquery;
  var element = layui.element;
  var deleteIndex;//全局变量

  $().ready(function(){
    //自动生成左侧菜单项
      var data = $.parseJSON('${data}');
      //alert(data.count);
      //var sideBar = $("#side-bar");
      for(var i=0; i<data.count; i++){
        if(data.data[i].parentId == -1 && data.data[i].resourceType == "directory"){
          //先拼接，再append，否则css样式会失效
          var content = "<li class=\"layui-nav-item \"> <a class=\"\" href=\"javascript:;\" data-id=\""
                          +data.data[i].id+"\">"+data.data[i].name+"<span class=\"layui-nav-more\"></span></a></li>";
          $("#side-bar").append(content);

        }
        else if(data.data[i].resourceType == 'menu'){
          //jQuery属性选择器选择动态变量的写法
          var dir = $("a[data-id="+data.data[i].parentId+"]");
          //判断某个元素是否存在的方法
          if(dir.parent().children("dl").length > 0){
            var content = "<dd><a data-url=\""+data.data[i].url+"\" data-id=\""
                          +data.data[i].id+"\" data-title=\""+data.data[i].name+"\">"+data.data[i].name+"</a></dd>";
            dir.parent().children("dl").append(content);
          }
          else{
            var content = "<dl class=\"layui-nav-child\"><dd><a data-url=\""+data.data[i].url+"\" data-id=\""
                          +data.data[i].id+"\" data-title=\""+data.data[i].name+"\">"+data.data[i].name+"</a></dd></dl>";
            dir.parent().append(content);
          }
        }
      }
      //关键，不加这句刚开始导航菜单点击无法展开
      element.init();
  });

  element.on('tab(demo)', function(data){
    deleteIndex=$(this).attr("lay-id");
  });


  //触发事件
  var active = {
              //在这里给active绑定几项事件，后面可通过active调用这些事件
              tabAdd: function(url,id,name) {
                  //新增一个Tab项 传入三个参数，分别对应其标题，tab页面的地址，还有一个规定的id，是标签中data-id的属性值
                  //关于tabAdd的方法所传入的参数可看layui的开发文档中基础方法部分
                  element.tabAdd('demo', {
                      title: name+'<i class="layui-icon layui-unselect layui-tab-close">ဆ</i>',//手动添加关闭按钮
                      content: '<iframe data-frameid="'+id+'" scrolling="auto" frameborder="0" src="'+url+'" style="width:100%;height:90%;"></iframe>',
                      id: id //规定好的id
                  });

                   CustomRightClick(id); //给tab绑定右击事件
                   FrameWH();  //计算ifram层的大小
                   element.init();
              },
              tabChange: function(id) {
                  //切换到指定Tab项
                  element.tabChange('demo', id); //根据传入的id传入到指定的tab项
                  $("iframe[data-frameid='"+id+"']").attr("src",$("iframe[data-frameid='"+id+"']").attr("src"));//切换后刷新框架
              },
              tabDelete: function (id) {
              element.tabDelete("demo", id);//删除
              }
              , tabDeleteAll: function (ids) {//删除所有
                  $.each(ids, function (i,item) {
                      element.tabDelete("demo", item); //ids是一个数组，里面存放了多个id，调用tabDelete方法分别删除
                  })
              }
          };

          //添加tab关闭响应事件，.click只能为页面现有的元素绑定点击事件，如果是动态生成的新的元素，是没有事件的
          //而$(document).on("click","指定的元素",function(){});方法则是将指定的事件绑定在document上，而新产生的元素如果符合指定的元素，那就触发此事件
          $(document).on('click', 'i.layui-tab-close', function() {
            id = $(this).parent("li").attr("lay-id");
            element.tabDelete("demo",id);
          });
          //当点击有layui-nav-child属性下到a标签时，即左侧菜单栏中内容 ，触发点击事件
                  $(document).on('click','.layui-nav-child a',function() {
                      var dataid = $(this);

                      //这时会判断右侧.layui-tab-title属性下的有lay-id属性的li的数目，即已经打开的tab项数目
                      if ($(".layui-tab-title li[lay-id]").length <= 0) {
                          //如果比零小，则直接打开新的tab项
                          active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"),dataid.attr("data-title"));
                      } else {
                          //否则判断该tab项是否以及存在

                          var isData = false; //初始化一个标志，为false说明未打开该tab项 为true则说明已有
                          $.each($(".layui-tab-title li[lay-id]"), function () {
                              //如果点击左侧菜单栏所传入的id 在右侧tab项中的lay-id属性可以找到，则说明该tab项已经打开
                              if ($(this).attr("lay-id") == dataid.attr("data-id")) {
                                  isData = true;
                              }
                          })
                          if (isData == false) {
                              //标志为false 新增一个tab项
                              active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"),dataid.attr("data-title"));
                          }
                      }
                      //最后不管是否新增tab，最后都转到要打开的选项页面上
                      active.tabChange(dataid.attr("data-id"));
                  });
                  function CustomRightClick(id) {
                            //取消右键  rightmenu属性开始是隐藏的 ，当右击的时候显示，左击的时候隐藏
                            $('.layui-tab-title li').on('contextmenu', function () { return false; })
                            $('.layui-tab-title,.layui-tab-title li').click(function () {
                                $('.rightmenu').hide();
                            });
                            //桌面点击右击
                            $('.layui-tab-title li').on('contextmenu', function (e) {
                                var popupmenu = $(".rightmenu");
                                popupmenu.find("li").attr("data-id",id); //在右键菜单中的标签绑定id属性

                                //判断右侧菜单的位置
                                l = ($(document).width() - e.clientX) < popupmenu.width() ? (e.clientX - popupmenu.width()) : e.clientX;
                                t = ($(document).height() - e.clientY) < popupmenu.height() ? (e.clientY - popupmenu.height()) : e.clientY;
                                popupmenu.css({ left: l-200, top: t-60 }).show(); //进行绝对定位
                                //alert("右键菜单")
                                return false;
                            });
                        }
                        $(".rightmenu li").click(function () {

                             //右键菜单中的选项被点击之后，判断type的类型，决定关闭所有还是关闭其他。
                             if ($(this).attr("data-type") == "closeothers") {
                                 //如果关闭其他
                                 $.each($(".layui-tab-title li[lay-id]"), function () {
                                    //如果点击左侧菜单栏所传入的id 在右侧tab项中的lay-id属性可以找到，则说明该tab项已经打开
                                    if ($(this).attr("lay-id")!=deleteIndex && $(this).attr("lay-id")!="0") {
                                      active.tabDelete($(this).attr("lay-id"));
                                    }
                                  });
                             } else if ($(this).attr("data-type") == "closeall") {
                                 var tabtitle = $(".layui-tab-title li");
                                 var ids = new Array();
                                 $.each(tabtitle, function (i) {
                                     ids[i] = $(this).attr("lay-id");
                                 })
                                 //关闭所有时，过滤掉首页
                                 ids = $.grep(ids, function(value) {
                                    return value != "0";
                                  });
                                 //如果关闭所有 ，即将所有的lay-id放进数组，执行tabDeleteAll
                                 active.tabDeleteAll(ids);
                             }

                             $('.rightmenu').hide(); //最后再隐藏右键菜单
                         });
                         function FrameWH() {
                             var h = $(window).height() - 60 - 41 - 10 - 10 - 44; //header 60 tab-title 40 上下各留白 10 footer 44
                             $("iframe").css("height",h+"px");
                         }

                         $(window).resize(function () {
                             FrameWH();
                         });

});
</script>
</body>
</html>
