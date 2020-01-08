<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %> 
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>阅读博客</title>
   <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="个人博客">
  <meta name="description" content="个人博客">
  <link rel="stylesheet" href="${PATH}/static/layui/css/layui.css">
  <link rel="stylesheet" href="${PATH}/pages/static/css/global.css">
</head>
<body>

<%@ include file="/pages/common/header.jsp"%>

<!-- <div class="layui-hide-xs">
  <div class="fly-panel fly-column">
    <div class="layui-container">
      <ul class="layui-clear">
        <li class="layui-hide-xs"><a href="/">首页</a></li> 
        <li class="layui-this"><a href="">提问</a></li> 
        <li><a href="">分享<span class="layui-badge-dot"></span></a></li> 
        <li><a href="">讨论</a></li> 
        <li><a href="">建议</a></li> 
        <li><a href="">公告</a></li> 
        <li><a href="">动态</a></li> 
        <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><span class="fly-mid"></span></li> 
        
        用户登入后显示
        <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="../user/index.html">我发表的贴</a></li> 
        <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="../user/index.html#collection">我收藏的贴</a></li> 
      </ul> 
      
      <div class="fly-column-right layui-hide-xs"> 
        <span class="fly-search"><i class="layui-icon"></i></span> 
        <a href="add.html" class="layui-btn">发表新帖</a> 
      </div> 
      <div class="layui-hide-sm layui-show-xs-block" style="margin-top: -10px; padding-bottom: 10px; text-align: center;"> 
        <a href="add.html" class="layui-btn">发表新帖</a> 
      </div> 
    </div>
  </div>
</div> -->

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8 content detail">
      <div class="fly-panel detail-box">
        <h1>${blog.blogTitle}</h1>
        <div class="fly-detail-info" style="height: 20px">
          <!-- <span class="layui-badge">审核中</span> 
          <span class="layui-badge layui-bg-green fly-detail-column">动态</span>
          
          <span class="layui-badge" style="background-color: #999;">未结</span>
          <span class="layui-badge" style="background-color: #5FB878;">已结</span>
          
          <span class="layui-badge layui-bg-black">置顶</span>
          <span class="layui-badge layui-bg-red">精帖</span>
          
          <div class="fly-admin-box" data-id="123">
            <span class="layui-btn layui-btn-xs jie-admin" type="del">删除</span>
            
            <span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="1">置顶</span> 
            <span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="0" style="background-color:#ccc;">取消置顶</span> 
            
            <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="1">加精</span> 
            <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="0" style="background-color:#ccc;">取消加精</span>
          </div> -->
          <span class="fly-list-nums"> 
            <a href="#comment"><i class="iconfont" title="回答">&#xe60c;</i> ${blog.commetNum}</a>
            <i class="iconfont" title="人气">&#xe60b;</i>${blog.blogLook}
          </span>
        </div>
        <div class="detail-about" style="padding-left: 15px">
          <!-- <a class="fly-avatar" href="../user/home.html">
            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" alt="贤心">
          </a> -->
          <div class="fly-detail-user">
            <a href="#" class="fly-link">
              <cite>KPP</cite>
              <i class="iconfont icon-renzheng" title="认证信息：{{ rows.user.approve }}"></i>
             <!--  <i class="layui-badge fly-badge-vip">VIP3</i> -->
            </a>
            <span>${blog.filepath}</span>
          </div>
          <div class="detail-hits" id="LAY_jieAdmin" data-id="123">
            <span style="padding-right: 10px; color: #FF7200">积分：${blog.needIntegral}</span>  
            <span class="layui-btn layui-btn-xs jie-admin" type="edit" id="collectedBlog"><a href="javascript:void(0);">收藏此贴</a></span>
            <span class="layui-btn layui-btn-xs jie-admin" type="edit" id="notCollectBlog" style="background-color: #5FB878;"><a href="javascript:void(0);">取消收藏</a></span>
          </div>
        </div>
        <div class="detail-body photos">
         	<!-- 内容 -->
         	${blog.blogText}
        </div>
      </div>
      <div class="fly-panel detail-box" id="flyReply">
        <fieldset class="layui-elem-field layui-field-title" style="text-align: center;">
          <legend>评论</legend>
        </fieldset>
        <ul class="jieda" id="jieda">
          <li data-id="111" class="jieda-daan" v-for="item in comments"> 
            <a name="item-1111111111"></a>
            <div class="detail-about detail-about-reply" style="padding-left: 15px">
              <!-- <a class="fly-avatar" href="">
                <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" alt=" ">
              </a> -->
              <div class="fly-detail-user">
                <a href="#" class="fly-link">
                  <cite>{{item.memNick}}</cite>
                  <i class="iconfont icon-renzheng" :title="item.memNick"></i>
                  <!-- <i class="layui-badge fly-badge-vip">VIP3</i>  -->             
                </a>
                
                <!-- <span>(楼主)</span> -->
                <!--
                <span style="color:#5FB878">(管理员)</span>
                <span style="color:#FF9E3F">（社区之光）</span>
                <span style="color:#999">（该号已被封）</span>
                -->
              </div>

              <div class="detail-hits">
                <span>{{item.createTime | moment}}</span>
              </div>

              <!-- <i class="iconfont icon-caina" title="最佳答案"></i> -->
            </div>
            <div class="detail-body jieda-body photos commentText">
            {{item.commentText}}
            </div>
            <div class="jieda-reply">
              <!-- <span class="jieda-zan zanok" type="zan">
                <i class="iconfont icon-zan"></i>
                <em>66</em>
              </span> -->
              <span type="reply" style="padding-left: 50px">
                	博主回复：<span v-if="item.replyText===null">博主暂时还未回复</span><span v-else class="commentText">{{item.replyText}}</span>
              </span>
              <!-- <div class="jieda-admin">
                <span type="edit">编辑</span>
                <span type="del">删除</span>
                <span class="jieda-accept" type="accept">采纳</span>
              </div> -->
            </div> 
          </li>
          
          <!-- 无数据时 -->
          <!-- <li class="fly-none">消灭零回复</li> -->
        </ul>
        <c:choose>
        	<c:when test="${not empty sessionScope.name}">
        		<div class="layui-form layui-form-pane">
		          <form method="post">
		          	<input type="hidden" name="memNick" value="${sessionScope.name}"/>
		          	<input type="hidden" name="memIdent" value="${sessionScope.ident}"/>
		          	<input type="hidden" name="blogIdent" value="${blog.blogIdent}"/>
		            <div class="layui-form-item layui-form-text">
		              <a name="comment"></a>
		              <div class="layui-input-block">
		                <textarea id="L_content" name="commentText" required lay-verify="required" placeholder="请输入内容"  class="layui-textarea fly-editor" style="height: 150px;"></textarea>
		              </div>
		            </div>
		            <div class="layui-form-item">
		              <button class="layui-btn" lay-filter="addComment" lay-submit>提交评论</button>
		            </div>
		          </form>
		        </div>	
        	</c:when>
        	<c:when test="${empty sessionScope.name}">
				<div align="center">评论请先<a href="${PATH}/pages/login.jsp"> 登录   </a></div>     		
        	</c:when>
        </c:choose>
        
      </div>
    </div>
    <div class="layui-col-md4" id="discussions">
      <dl class="fly-panel fly-list-one">
        <dt class="fly-panel-title">热议</dt>
        <dd v-for="item in discussions">
          <a :href="'${PATH}/blog/getBlogByIdent/'+item.blogIdent">{{item.blogTitle}}</a>
          <span><i class="iconfont icon-pinglun1"></i> {{item.commetNum}}</span>
        </dd>
        <!-- 无数据时 -->
        <!--
        <div class="fly-none">没有相关数据</div>
        -->
      </dl>

      <div class="fly-panel">
        <div class="fly-panel-title">
          这里可作为广告区域
        </div>
        <div class="fly-panel-main">
          <a href="http://layim.layui.com/?from=fly" target="_blank" class="fly-zanzhu" time-limit="2017.09.25-2099.01.01" style="background-color: #5FB878;">LayIM 3.0 - layui 旗舰之作</a>
        </div>
      </div>

      <div class="fly-panel" style="padding: 20px 0; text-align: center;">
        <img src="${PATH}/pages/weixin.jpg" style="max-width: 100%;" alt="layui">
        <p style="position: relative; color: #666;">微信扫码关KPP公众号</p>
      </div>

    </div>
  </div>
</div>

<%@ include file="/pages/common/footer.jsp"%>
<script src="${PATH}/static/layui/layui.all.js"></script>
 <script src="${PATH}/static/vue/vue.min.js"></script>
<script src="${PATH}/static/vue/vue-resource.min.js"></script>
<script src="${PATH}/static/js/comment.js"></script>
<script type="text/javascript">
layui.config({
	  version: "3.0.0"
	  ,base: '${PATH}/pages/static/js/'
	}).extend({
	  fly: 'index'
	}).use(['fly', 'face'], function(){
	  var $ = layui.$
	  ,fly = layui.fly;
	  $('.commentText').each(function(){
	    var othis = $(this), html = othis.html();
	    othis.html(fly.content(html));
	  });
	});
</script>
<script>
 var discussions = new Vue({
	el:"#discussions",
	data:{
		discussions:[],
	},created: function () {
		this.$http.get("${PATH}/blog/getDiscussions").then(function(response){
			//成功
			this.discussions=response.body;
		},function(response) {
			//错误
			console.log("系统错误！")
		});
	}
 });
 var flyReply = new Vue({
	 el:"#flyReply",
	 data:{
		comments:[],
	 	blogIdent:"${blog.blogIdent}"
	 },created: function () {
		 this.$http.get("${PATH}/comment/getCommentByShow/"+this.blogIdent).then(function(response){
				console.log(response.body)
				//成功
				this.comments=response.body;
			},function(response) {
				//错误
				console.log("系统错误！")
			});
	 }
 })
 Vue.filter('moment', function (value, formatString) {
	    formatString = formatString || 'YYYY-MM-DD HH:mm:ss';
	    return moment(value).format(formatString);
	});
</script>
<script>
var integral = ${blog.needIntegral};
var blogIdent = "${blog.blogIdent}"
var memIdent = "${sessionScope.ident}"
	$(function(){
		inspectCollect();
		if(integral!=0){
			if(memIdent==""){
				layui.layer.msg("请先登录",function(){
					window.location.href="${PATH}/pages/login.jsp";
				})
				return false;
			}
			//检验是否购买
			$.ajax({
				url:"${PATH}/blogBuy/blogIsBuy/"+blogIdent+"/"+memIdent,
				method:"get",
				success:function(res){
					if(res.code==200){	
						layui.layer.msg("您还未购买！请您先购买！",function(){
							window.location.href="${PATH}/pages/index.jsp";
						})
					}
				}
			})
		}
	})
	//收藏
	$("#collectedBlog").click(function(){
		$.ajax({
				url:"${PATH}/blogCollection/collectBlog/"+blogIdent+"/"+memIdent,
				method:"get",
				success:function(res){
					if(res.code==100){	
						layui.layer.msg(res.extend.msg,function(){
							inspectCollect();
						})
					}else{
						layui.layer.msg(res.extend.msg,function(){
							inspectCollect();
						})
					}
				}
			})
	});
	//取消收藏
	$("#notCollectBlog").click(function(){
		$.ajax({
				url:"${PATH}/blogCollection/cancelCollectBlog/"+blogIdent+"/"+memIdent,
				method:"get",
				success:function(res){
					if(res.code==100){	
						layui.layer.msg(res.extend.msg,function(){
							inspectCollect();
						})
					}else{
						layui.layer.msg(res.extend.msg,function(){
							inspectCollect();
						})
					}
				}
			})
		
	});
	function inspectCollect(){
		//检验是否收藏
		$.ajax({
			url:"${PATH}/blogCollection/blogIsConllect/"+blogIdent+"/"+memIdent,
			method:"get",
			success:function(res){
				console.log(res)
				if(res.code==100){	//已收藏
					//style="display: none;"
					$("#collectedBlog").css("display","none");
					$("#notCollectBlog").css("display","")
					
				}else{				//未收藏
					$("#notCollectBlog").css("display","none");
					$("#collectedBlog").css("display","")
				}
			}
		})
	}
	
	layui.use(['form','layer'], function(){
	  var form = layui.form,layer=layui.layer;
	  form.on('submit(addComment)', function(data){
		  console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
		  var datas = data.field
		  $.ajax({
			  url:"${PATH}/comment/addComment",
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
	
	})
	
</script>
</body>
</html>