<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>注册</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="fly,layui,前端社区">
  <meta name="description" content="Fly社区是模块化前端UI框架Layui的官网社区，致力于为web开发提供强劲动力">
  <link rel="stylesheet" href="${PATH}/static/layui/css/layui.css">
  <link rel="stylesheet" href="${PATH}/pages/static/css/global.css">
</head>
<body>
 <%@ include file="/pages/common/header.jsp"%>

<div class="layui-container fly-marginTop">
  <div class="fly-panel fly-panel-user" pad20>
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title">
        <li><a href="${PATH}/pages/login.jsp">登入</a></li>
        <li class="layui-this">注册</li>
      </ul>
      <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
        <div class="layui-tab-item layui-show">
          <div class="layui-form layui-form-pane">
            <form  method="post">
            <div class="row">
            <div class="layui-col-md6">
              <div class="layui-form-item">
                <label for="email" class="layui-form-label">邮箱</label>
                <div class="layui-input-inline">
                  <input type="text" id="email" name="mEmail" required lay-verify="email" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">将会成为您唯一的登入名</div>
              </div>
              <div class="layui-form-item">
                <label for="L_username" class="layui-form-label">昵称</label>
                <div class="layui-input-inline">
                  <input type="text" id="L_username" name="mNick" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_pass" class="layui-form-label">密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_pass" name="formPwd1" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">6到16个字符</div>
              </div>
              <div class="layui-form-item">
                <label for="L_repass" class="layui-form-label">确认密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_repass" name="formPwd2" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_vercode" class="layui-form-label">验证码</label>
                <div class="layui-input-inline">
                  <input type="text" id="L_vercode" name="formCode" required lay-verify="required" placeholder="查看邮箱输入验证码" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="padding: 0 !important;">
                  <span style="color: #c00;"><input type="button" onclick="sendemail()" id="codeBtn" value="点击获取验证码"  name="vercode" class="layui-input" style="padding-right: 10px;"></span>
                </div>
              </div>
              </div>
              <div class="layui-col-md6">
	              <div class="layui-form-item">
	                <label class="layui-form-label">签名</label>
	                <div class="layui-input-block">
	                	<textarea name="mAutograph" required lay-verify="required" placeholder="请输入" class="layui-textarea"></textarea>
	                </div>
	              </div>
              	<!-- 头像 -->
              		<div class="layui-form-item">
                    <input type="hidden" name="mHeader" id="productImg"/>
                    <div class="layui-upload">
                        <button type="button" class="layui-btn" id="productImgButton">上传头像</button>
                        <div class="layui-upload-list">
                            <img style="width: 80px;height: 80px" class="layui-upload-img" id="productImgImg">
                        </div>
                    </div>
                </div>
              </div>
              <div class="layui-form-item">
                <button class="layui-btn" lay-filter="*" lay-submit>立即注册</button>
              </div>
              <!-- <div class="layui-form-item fly-form-app">
                <span>或者直接使用社交账号快捷注册</span>
                <a href="" onclick="layer.msg('正在通过QQ登入', {icon:16, shade: 0.1, time:0})" class="iconfont icon-qq" title="QQ登入"></a>
                <a href="" onclick="layer.msg('正在通过微博登入', {icon:16, shade: 0.1, time:0})" class="iconfont icon-weibo" title="微博登入"></a>
              </div> -->
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>

</div>

 <%@ include file="/pages/common/footer.jsp"%>

<script src="${PATH}/static/layui/layui.js"></script>
<script>
layui.use(['layer','form'], function(){
	var layer = layui.layer,form=layui.form;
	form.on('submit(*)', function(data){
	  var datas= data.field;
	  $.ajax({
		url:"${PATH}/member/regiter",
		method:"post",
		data:datas,
		success:function(res){
			if(res.code==100){
				layer.msg(res.extend.msg,{icon:6},function(){
					window.location.href="${PATH}/pages/login.jsp";
				})
			}else{
				layer.msg(res.extend.msg,{icon:5})	
			}
		},error:function(){
			layer.msg("系统出错！")
		}
	  });
	  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
	});
})


</script>
<script>
var contextPath = "${PATH}/static/"
	layui.config({
	    base: contextPath + 'layui/easyCropper/' //layui自定义layui组件目录
	})
	layui.use(['easyCropper'], function(){
	  
	    var easyCropper = layui.easyCropper;
	    //创建一个图片裁剪上传组件
	    var productImgCropper = easyCropper.render({
	        elem: '#productImgButton'
	        ,saveW:380     //保存宽度
	        ,saveH:360     //保存高度
	        ,mark:1/1   //选取比例
	        ,size: 2048    // 大小限制 默认1024k 选填
	        ,area:'600px'  //弹窗宽度
	        ,url: '${PATH}/member/uploadHeaderImg'  //图片上传接口返回和（layui 的upload 模块）返回的JOSN一样
	        ,done: function(url){ //上传完毕回调
	            $("#productImg").val(url);
	            $("#productImgImg").attr('src',url);
	        }
	    });
	})
 //验证码
 var countdown=60; 
 function sendemail(){
 	layui.use('layer', function(){
 	  	var layer = layui.layer;
 	  	var obj = $("#codeBtn");
 	    var email = $("#email").val();
 	    var reg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
 	    if(!reg.test(email)){
 	    	layer.msg("请输入正确的邮箱！",{icon:5});
 	    	return;
 	    }
 	    $.ajax({
 	    	url:"${PATH}/regiterCode/createEmailCode?regEmail="+email,
 	    	method:"get",
 	    	success:function(res){
 	    		if(res.code==100){
 	    			layer.msg(res.extend.msg,{icon:6});
 	    		}else{
 	    			layer.msg(res.extend.msg,{icon:5});
 	    		}
 	    	},error:function(){
 	    		layer.msg("系统错误！",{icon:5});
 	    		return;
 	    	}
 	    });
 	    settime(obj);
 	});
     }
 function settime(obj) { //发送验证码倒计时
     if (countdown == 0) { 
         obj.attr('disabled',false); 
         //obj.removeattr("disabled"); 
         obj.val("点击获取验证码");
         countdown = 60; 
         return;
     } else { 
         obj.attr('disabled',true);
         obj.val("重新发送(" + countdown + ")");
         countdown--; 
     } 
 setTimeout(function() { 
     settime(obj) }
     ,1000) 
 }
</script>

</body>
</html>