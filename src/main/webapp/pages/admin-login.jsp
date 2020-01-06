<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>登录</title>
 <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="个人博客">
  <meta name="description" content="个人博客">
  <link rel="stylesheet" href="${PATH}/static/layui/css/layui.css">
  <link rel="stylesheet" href="${PATH}/pages/static/css/global.css">
</head>
<body>

 <%@ include file="/pages/common/header.jsp"%>


<div class="layui-container fly-marginTop">
  <div class="fly-panel fly-panel-user" pad20>
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title">
        <li class="layui-this">后台登录</li>
      </ul>
      <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
        <div class="layui-tab-item layui-show">
          <div class="layui-form layui-form-pane">
            <form method="post" action="${PATH}/admin/loginInto">
              <div class="layui-form-item">
                <label for="L_email" class="layui-form-label">登录名</label>
                <div class="layui-input-inline">
                  <input type="text" id="L_email" name="adminName"  autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_pass" class="layui-form-label">密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_pass" name="adminPassword" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <button class="layui-btn" type="submit">立即登录</button>
              </div>
              <div class="layui-form-item fly-form-app">
                <!-- <span>或者使用社交账号登入</span>
                <a href="" onclick="layer.msg('正在通过QQ登入', {icon:16, shade: 0.1, time:0})" class="iconfont icon-qq" title="QQ登入"></a>
                <a href="" onclick="layer.msg('正在通过微博登入', {icon:16, shade: 0.1, time:0})" class="iconfont icon-weibo" title="微博登入"></a> -->
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="/pages/common/footer.jsp"%>

<script src="${PATH}/static/layui/layui.all.js"></script>
<script>
var error = "${msg}"
if(error!=""){
	layui.layer.msg(error,{icon:5});
}	
</script>
</body>
</html>