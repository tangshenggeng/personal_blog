<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <div class="layui-header layui-bg-green">
    <div class="layui-logo layui-bg-red">KPP个人博客后台</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <!-- <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item"><a href="">控制台</a></li>
      <li class="layui-nav-item"><a href="">商品管理</a></li>
      <li class="layui-nav-item"><a href="">用户</a></li>
      <li class="layui-nav-item">
        <a href="javascript:;">其它系统</a>
        <dl class="layui-nav-child">
          <dd><a href="">邮件管理</a></dd>
          <dd><a href="">消息管理</a></dd>
          <dd><a href="">授权管理</a></dd>
        </dl>
      </li>
    </ul> -->
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
         <!--  <img src="http://t.cn/RCzsdCq" class="layui-nav-img"> -->
          ${sessionScope.admin}
        </a>
        <dl class="layui-nav-child">
          <dd><a href="#">基本资料</a></dd>
          <dd><a href="#">安全设置</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item"><a href="${PATH}/admin/loginOut">退出</a></li>
    </ul>
  </div>
        <script type="text/javascript">
        	var admin = "${sessionScope.admin}"
        	if(admin==""){
        		alert("登录超时！请重新登录")
        		window.location.href="${PATH}/admin/loginOut";
        	}
        </script>