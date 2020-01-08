<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="background-color:#FFFFFF"">
<head>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>KPP个人博客后台</title>
  <link rel="stylesheet" href="${PATH}/static/layui/css/layui.css">
   <link rel="stylesheet" href="${PATH}/pages/static/css/global.css">
  <!--[if lt IE 9]>
  <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
  <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>

<body class="layui-layout-body" style="margin-top: 0px;">
<div class="layui-layout layui-layout-admin">
  <%@ include file="/WEB-INF/view/common/header.jsp"%>
  <%@ include file="/WEB-INF/view/common/nav.jsp"%>
  <div class="layui-body">
  	<div style="padding: 15px;">
    	<blockquote class="layui-elem-quote">
		<a href="${PATH}/admin/index">主页</a> /
		<a>评论管理</a>
	</blockquote>
		<form class="layui-form" id="kwCustForm">
			<!-- <div class="layui-col-md3">
				<div class="layui-form-item">
					<label class="layui-form-label">关键字</label>
					<div class="layui-input-block">
						<input type="text" name="custName"  placeholder="请输入" autocomplete="off"
							class="layui-input">
					</div>
				</div>
			</div> --> 
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">关键字</label>
					<div class="layui-input-block">
						<input type="text" name="keywords"  placeholder="请输入" autocomplete="off"
							class="layui-input">
					</div>
				</div>
			</div>
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label range-label">日期</label>
					<div class="layui-input-inline">
						<input type="text" id="start_date" placeholder="请选择" name="start_date"
							autocomplete="off" class="layui-input">
					</div>
					<div class="layui-form-mid">-</div>
					<div class="layui-input-inline">
						<input type="text" id="end_date" placeholder="请选择" name="end_date"
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" type="button" id="kwFormBtn">筛选</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</div>
		</form><br>
		<div class="row">
			<div class="layui-col-md12">
				<div class="card">
					<div class="card-header">
						<h2>评论管理</h2><br>
						<button class="layui-btn layui-btn-danger" type="button" id="delByIds"><i class="layui-icon layui-icon-delete"></i>删除选中</button>
					</div>
					<div class="card-body">
						<table id="dataListTb" lay-filter="dataTbFilter"
							class="table table-responsive table-hover">

						</table>
					</div>
				</div>
			</div>
		</div>
    </div>
  </div>
  <div class="layui-footer layui-bg-green">
    <!-- 底部固定区域 -->
    © KPP个人博客
  </div>
</div>
<div style="display: none;" id="lookBlogTextModel">
	<div  style="margin: 20px 20px">
		<div class="panel panel-default">
			  <div class="panel-body" >
			    <blockquote class="layui-elem-quote" id="blogTextDiv">引用区域的文字</blockquote>
			  </div>
			</div>
	</div>
</div>
<div style="display: none;" id="returnTextModel">
	<div  style="margin: 20px 20px">
		<div class="panel panel-default">
			  <div class="panel-body layui-form layui-form-pane">
			  评论：<blockquote class="layui-elem-quote" id="commentTextDiv">未曾评论</blockquote>
			  回复：<blockquote class="layui-elem-quote" id="returnTextDiv">未曾回复</blockquote>
			  	<form method="post">
		            <div class="layui-form-item layui-form-text">
		            <input type="hidden" name="commentId" id="commentIdReturn">
		              <div class="layui-input-block">
		                <textarea id="L_content" name="replyText" required lay-verify="required" placeholder="请输入内容"  class="layui-textarea fly-editor" style="height: 150px;"></textarea>
		              </div>
		            </div>
		            <div class="layui-form-item">
		              <button class="layui-btn" lay-filter="returnComment" lay-submit>提交回复</button>
		            </div>
		          </form>
			  </div>
			</div>
	</div>
</div>
<script src="${PATH}/static/js/jquery2.0-min.js"></script>	
<script src="${PATH}/static/layui/layui.all.js"></script>
<script>
$(function() {
	renderTb();
});
function renderTb() {
	var data = $("#kwCustForm").serializeArray();
	layui.use(['table','util'], function() {
		var table = layui.table
		,util = layui.util;
		//第一个实例
		table.render({
			elem : '#dataListTb',
			height :400,
			url : '${PATH}/comment/getCommentList',
			id:"datListTbId",
			size : 'sm ',
			contentType: "application/json",//必须指定，否则会报415错误
		    dataType : 'json',
			method:"POST",
			id:"dataListTbId",
			page : true //开启分页
			,
			where : {
				kwdata : data
			},
			cols : [ [ //表头
			{
				field : 'commentId',
				title : '#',
				type:"checkbox",
				align : "center"
			},{
				field : 'blogIdent',
				title : '博客标识',
				align : "center"
			},{
				field : 'memNick',
				title : '评论人昵称',
				align : "center"
			},{
				field : 'memIdent',
				title : '客户标识',
				align : "center"
			},{
				field : 'createTime',
				title : '创建时间',
				sort:true,
				align : "center"
				,templet:"<div>{{layui.util.toDateString(d.createTime, 'yyyy-MM-dd HH:mm:ss')}}</div>"
			},{
				fixed : 'right',
				width : 150,
				rowspan : 2,
				title : '操作',
				align : 'center',
				toolbar : '#barDemo'
			}]],
			parseData : function(res) { //res 即为原始返回的数据
				console.log(res)
				return {
					"code" : res.status, //解析接口状态
					"msg" : res.message, //解析提示文本
					"count" : res.total, //解析数据长度
					"data" : res.data
				//解析数据列表
				};
			}
		});
		table.on('tool(dataTbFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
		  	var data = obj.data; //获得当前行数据
		  	var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
		  	 if(layEvent === 'detailBlog'){
		  		$.ajax({
					url:"${PATH}/blog/getBlogByIdentAdmin/"+data.blogIdent,
					method:"get",
					success:function(res){
						$("#blogTextDiv").html(res.blogText)
					}
				});
		  		layui.layer.open({
					title : '查看博文',
					fix : true,
					resize : false,
					move : false,
					area : [ '800px', '400px' ],
					shadeClose : false,
					type : 1,
					anim: 5,
					content : $('#lookBlogTextModel'),
					cancel : function(index, layero) {
						$('#lookBlogTextModel').css("display", "none")
					}
				 })
		  	  }else if(layEvent === 'return'){
		  		$("#commentTextDiv").html(data.commentText)
		  		$("#returnTextDiv").html(data.replyText)
		  		$("#commentIdReturn").val(data.commentId)
		  		  layui.config({
					  version: "3.0.0"
					  ,base: '${PATH}/pages/static/js/'
					}).extend({
					  fly: 'index'
					}).use(['fly', 'face'], function(){
					  var $ = layui.$
					  ,fly = layui.fly;
					  $('#commentTextDiv').each(function(){
					    var othis = $(this), html = othis.html();
					    othis.html(fly.content(html));
					  });
					  $('#returnTextDiv').each(function(){
					    var othis = $(this), html = othis.html();
					    othis.html(fly.content(html));
					  });
					});
		  		layui.layer.open({
					title : '回复评论',
					fix : true,
					resize : false,
					move : false,
					area : [ '800px', '400px' ],
					shadeClose : false,
					type : 1,
					anim: 5,
					content : $('#returnTextModel'),
					cancel : function(index, layero) {
						$('#returnTextModel').css("display", "none")
					}
				 })
		  	  }else if(layEvent === 'LAYTABLE_TIPS'){
		  	    layer.alert('Hi，头部工具栏扩展的右侧图标。');
		  	  }
		});
	});
}
//批量删除
$("#delByIds").click(function(){
	layui.use(['table','layer'], function() {
		var table = layui.table
		,layer = layui.layer;
		layer.confirm('真的删除行么', function(index){
			var checkStatus = table.checkStatus('dataListTbId');
			var datas = checkStatus.data
			var ids = new Array();
			$(datas).each(function(){
				ids.push($(this)[0].commentId);
			})
			
			if(ids.length==0){
				layer.msg("请选择数据！");
				return false;
			}
			$.ajax({
				url:"${PATH}/comment/delByIds",
				method:"POST",
				contentType: "application/json",//必须指定，否则会报415错误
			    dataType : 'json',
				data:JSON.stringify(ids),
				success:function(res){
					console.log(res)
					if(res.code == 100){
						layer.msg(res.extend.msg,{icon:6},function(){
							renderTb();
						});
					}else{
						layer.msg(res.extend.msg,{icon:5},function(){
							renderTb();
						});
					}
				},error:function(){
					layer.msg("系统错误！",{icon:5},function(){
						renderTb();
					});
				}
			});	
		  layer.close(index);
		});
	});
})
layui.use('laydate', function(){
  var laydate = layui.laydate;
  //执行一个laydate实例
  laydate.render({
    elem: '#start_date' //指定元素,
    ,eventElem: '#start_date'
    ,trigger: 'click'
  });
  laydate.render({
    elem: '#end_date' //指定元素,
    ,eventElem: '#end_date'
    ,trigger: 'click'
  });
});
//筛选
$("#kwFormBtn").click(function(){
	renderTb();
});
//回复评论
layui.use('form', function(){
	var form = layui.form;
	form.on('submit(returnComment)', function(data){
		  console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
		  var datas=data.field
		  $.ajax({
			  url:"${PATH}/comment/returnComment",
			  method:"post",
			  data:datas,
			  success:function(res){
					if(res.code==100){
						layer.msg(res.extend.msg,{icon:6},function(){
							layui.layer.closeAll()
							renderTb();
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
});
</script>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="detailBlog">查看博文</a>
  <a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="return">回复</a>
</script>
</body>
</html>