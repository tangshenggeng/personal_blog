<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>帐号设置</title>
   <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="个人博客">
  <meta name="description" content="个人博客">
  <link rel="stylesheet" href="${PATH}/static/layui/css/layui.css">
  <link rel="stylesheet" href="${PATH}/pages/static/css/global.css">
</head>
<body>

<%@ include file="/pages/common/header.jsp"%>

<div class="layui-container fly-marginTop fly-user-main">
  <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
    <li class="layui-nav-item">
      <a href="${PATH}/member/toMyIntegralPage/${sessionScope.ident}">
        <i class="iconfont icon-kiss"></i>
        	积分充值
      </a>
    </li>
    <!-- <li class="layui-nav-item">
      <a href="index.html">
        <i class="layui-icon">&#xe612;</i>
        用户中心
      </a>
    </li> -->
    <li class="layui-nav-item layui-this">
      <a href="${PATH}/member/toSetMyInfoPage/${sessionScope.ident}">
        <i class="layui-icon">&#xe620;</i>
        基本设置
      </a>
    </li>
    <!-- <li class="layui-nav-item">
      <a href="message.html">
        <i class="iconfont icon-renzheng layui-hide-xs" title="加入会员"></i>
        加入会员
      </a>
    </li> -->
  </ul>

  <div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>
  
  <div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>
  
  
  <div class="fly-panel fly-panel-user" pad20>
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title" id="LAY_mine">
        <li class="layui-this" lay-id="info">我的资料</li>
        <li lay-id="avatar">头像</li>
        <li lay-id="pass">密码</li>
        <li lay-id="bind">帐号绑定</li>
      </ul>
      <div class="layui-tab-content" style="padding: 20px 0;">
        <div class="layui-form layui-form-pane layui-tab-item layui-show">
          <form method="post">
          	<input type="hidden" name="mIdent" value="${sessionScope.ident}" />
            <div class="layui-form-item">
              <label for="L_email" class="layui-form-label">邮箱</label>
              <div class="layui-input-inline">
                <input type="text" id="L_email" name="mEmail" value="${email}" readonly="readonly" class="layui-input">
              </div>
            </div>
            <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">昵称</label>
              <div class="layui-input-inline">
                <input type="text" id="L_username" name="mNick" value="${nick}"  required lay-verify="required" autocomplete="off" value="" class="layui-input">
              </div>
              <!-- <div class="layui-form-mid layui-word-aux">右上角没变？试试重新登录</div> -->
              <!-- <div class="layui-inline">
                <div class="layui-input-inline">
                  <input type="radio" name="sex" value="0" checked title="男">
                  <input type="radio" name="sex" value="1" title="女">
                </div>
              </div> -->
            </div>
            
            <div class="layui-form-item layui-form-text">
              <label for="L_sign" class="layui-form-label">签名</label>
              <div class="layui-input-block">
                <textarea placeholder="随便写些什么刷下存在感" id="L_sign" name="mAutograph" autocomplete="off" class="layui-textarea" style="height: 80px;">${autograph}</textarea>
              </div>
            </div>
            <div class="layui-form-item">
              <button class="layui-btn" key="set-mine" lay-filter="editInfo" lay-submit>确认修改</button>
            </div>
          </div>
          
          <div class="layui-form layui-form-pane layui-tab-item">
            <div class="layui-form-item">
              <div class="avatar-add">
                <p>建议尺寸168*168，支持jpg、png、gif，最大不能超过50KB</p>
                <button type="button" class="layui-btn upload-img" id="productImgButton">
                  <i class="layui-icon">&#xe67c;</i>上传头像
                </button>
                <img id="productImgImg" src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg">
                <span class="loading"></span>
              </div>
            </div>
          </div>
          
          <div class="layui-form layui-form-pane layui-tab-item">
            <form  method="post">
            	<input type="hidden" name="mIdent" value="${sessionScope.ident}"/>
              <div class="layui-form-item">
                <label for="L_nowpass" class="layui-form-label">当前密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_nowpass" name="formCode" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_pass" class="layui-form-label">新密码</label>
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
                <button class="layui-btn" key="set-mine" lay-filter="editPwd" lay-submit>确认修改</button>
              </div>
            </form>
          </div>
          
          <div class="layui-form layui-form-pane layui-tab-item">
            <ul class="app-bind">
              <li class="fly-msg app-havebind">
                <i class="iconfont icon-qq"></i>
                <span>已成功绑定，您可以使用QQ帐号直接登录Fly社区，当然，您也可以</span>
                <a href="javascript:;" class="acc-unbind" type="qq_id">解除绑定</a>
                
                <!-- <a href="" onclick="layer.msg('正在绑定微博QQ', {icon:16, shade: 0.1, time:0})" class="acc-bind" type="qq_id">立即绑定</a>
                <span>，即可使用QQ帐号登录Fly社区</span> -->
              </li>
              <li class="fly-msg">
                <i class="iconfont icon-weibo"></i>
                <!-- <span>已成功绑定，您可以使用微博直接登录Fly社区，当然，您也可以</span>
                <a href="javascript:;" class="acc-unbind" type="weibo_id">解除绑定</a> -->
                
                <a href="" class="acc-weibo" type="weibo_id"  onclick="layer.msg('正在绑定微博', {icon:16, shade: 0.1, time:0})" >立即绑定</a>
                <span>，即可使用微博帐号登录Fly社区</span>
              </li>
            </ul>
          </div>
        </div>

      </div>
    </div>
  </div>
</div>
<%@ include file="/pages/common/footer.jsp"%>

<script src="${PATH}/static/layui/layui.all.js"></script>
<script type="text/javascript">
var error = "${msg}"
if(error!=""){
	layui.layer.msg(error,{icon:5},function(){
		window.location.href="${PATH}/pages/index.jsp";
	});
}	
layui.use(['layer', 'form'], function(){
	var layer = layui.layer,form = layui.form;
	form.on('submit(editInfo)', function(data){
		  var datas = data.field
		  $.ajax({
			url:"${PATH}/member/editInfo",
			method:"post",
			data:datas,
			success:function(res){
				if(res.code==100){
					layer.msg(res.extend.msg,{icon:6},function(){
						location.reload() 
					})
				}else{
					layer.msg(res.extend.msg,{icon:5})	
				}
			},error:function(){
				layer.msg("系统错误")
			}
		  })
		  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
		});
	form.on('submit(editPwd)', function(data){
		  var datas = data.field
		  $.ajax({
			url:"${PATH}/member/editPwd",
			method:"post",
			data:datas,
			success:function(res){
				if(res.code==100){
					layer.msg(res.extend.msg,{icon:6},function(){
						window.location.href="${PATH}/member/loginOut"; 
					})
				}else{
					layer.msg(res.extend.msg,{icon:5})	
				}
			},error:function(){
				layer.msg("系统错误")
			}
		  })
		  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
		});
})
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
	        ,url: '${PATH}/member/editHeaderImg'  //图片上传接口返回和（layui 的upload 模块）返回的JOSN一样
	        ,done: function(url){ //上传完毕回调
	        	location.reload() 
	            $("#productImgImg").attr('src',url);
	        }
	    });
	})


</script>
</body>
</html>