<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="${PATH}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${PATH}/static/vue/vue-resource.min.js"></script>
<div class="fly-header layui-bg-black">
  <div class="layui-container">
    <a class="fly-logo" href="${PATH}/pages/index.jsp">
      <img style="width: 135px;height: 37px" src="${PATH}/pages/static/images/logo.png" alt="layui">
    </a>
    <ul class="layui-nav fly-nav layui-hide-xs">
    
      <li class="layui-nav-item layui-this">
        <a href="#"><i class="iconfont icon-jiaoliu"></i>欢迎访问KPP博客</a>
      </li>
      <!-- <li class="layui-nav-item">
        <a href="../case/case.html"><i class="iconfont icon-iconmingxinganli"></i>案例</a>
      </li>
      <li class="layui-nav-item">
        <a href="http://www.layui.com/" target="_blank"><i class="iconfont icon-ui"></i>框架</a>
      </li> -->
    </ul>
    
    <ul class="layui-nav fly-nav-user">
      <c:choose>
		<c:when test="${not empty sessionScope.name}">
			<li class="layui-nav-item">
		        <a class="fly-nav-avatar" href="javascript:;">
		          <cite class="layui-hide-xs">贤心</cite>
		          <i class="iconfont icon-renzheng layui-hide-xs" title="认证信息：layui 作者"></i>
		          <i class="layui-badge fly-badge-vip layui-hide-xs">VIP3</i>
		          <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg">
		        </a>
		        <dl class="layui-nav-child">
		          <dd><a href="../user/set.html"><i class="layui-icon">&#xe620;</i>基本设置</a></dd>
		          <dd><a href="../user/message.html"><i class="iconfont icon-tongzhi" style="top: 4px;"></i>我的消息</a></dd>
		          <dd><a href="../user/home.html"><i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe68e;</i>我的主页</a></dd>
		          <hr style="margin: 5px 0;">
		          <dd><a href="" style="text-align: center;">退出</a></dd>
		        </dl>
		      </li>
		</c:when>
		<c:when test="${empty sessionScope.name}">
			<!-- 未登入的状态 -->
	      <li class="layui-nav-item">
	        <a class="iconfont icon-touxiang layui-hide-xs" href="user/login.html"></a>
	      </li>
	      <li class="layui-nav-item">
	        <a href="${PATH}/pages/login.jsp">登入</a>
	      </li>
	      <li class="layui-nav-item">
	        <a href="${PATH}/pages/reg.jsp">注册</a>
	      </li>
		</c:when>
	  </c:choose>
      
      <!-- <li class="layui-nav-item layui-hide-xs">
        <a href="/app/qq/" onclick="layer.msg('正在通过QQ登入', {icon:16, shade: 0.1, time:0})" title="QQ登入" class="iconfont icon-qq"></a>
      </li>
      <li class="layui-nav-item layui-hide-xs">
        <a href="/app/weibo/" onclick="layer.msg('正在通过微博登入', {icon:16, shade: 0.1, time:0})" title="微博登入" class="iconfont icon-weibo"></a>
      </li> -->
      
    </ul>
  </div>
</div>

<div class="fly-panel fly-column">
  <div class="layui-container">
    <ul class="layui-clear">
      <!-- <li class="layui-hide-xs"><a href="/">首页</a></li> 
      <li class="layui-this"><a href="">提问</a></li> 
      <li><a href="">分享<span class="layui-badge-dot"></span></a></li> 
      <li><a href="">讨论</a></li> 
      <li><a href="">建议</a></li> 
      <li><a href="">公告</a></li> 
      <li><a href="">动态</a></li>  -->
      
      <c:if test="${not empty sessionScope.name}">
      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><span class="fly-mid"></span></li> 
	      <!-- 用户登入后显示 -->
	      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="../user/index.html">我发表的贴</a></li> 
	      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="../user/index.html#collection">我收藏的贴</a></li> 
      </c:if>
    </ul> 
    
  </div>
</div>

<%-- 
            <script>
            	var getClassifyDiv = new Vue({
            		el:"#getClassifyDiv",
            		data:{
            			classifys:[]
            		},created: function () {
            			//供应商
            			this.$http.get("${PATH}/classify/getClassifyByShow").then(function(response){
            				//成功
            				this.classifys=response.body;
            			},function(response) {
            				//错误
            				console.log("系统错误！")
            			});
            		}          		
            	});
            	function findByKWSpan(){
            		var testform=document.getElementById("findByKWForm");
                        testform.submit();
            	}
            </script>
         </header> --%>
