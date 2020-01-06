<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
  %>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>KPP个人博客后台</title>
  <link rel="stylesheet" href="${PATH}/static/layui/css/layui.css">
  <!--[if lt IE 9]>
  <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
  <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<style>
input[type=number] {  
    -moz-appearance:textfield;  
}  
input[type=number]::-webkit-inner-spin-button,  
input[type=number]::-webkit-outer-spin-button {  
    -webkit-appearance: none;  
    margin: 0;  
}  
</style>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@ include file="/WEB-INF/view/common/header.jsp"%>
  <%@ include file="/WEB-INF/view/common/nav.jsp"%>
  <div class="layui-body">
  	<div style="padding: 15px;">
    	<blockquote class="layui-elem-quote">
		<a href="${PATH}/admin/index">主页</a> /
		<a>展示的博客</a>
	</blockquote>
		<form class="layui-form" id="kwCustForm">
			<div class="layui-col-md3">
				<div class="layui-form-item">
					<label class="layui-form-label">关键字</label>
					<div class="layui-input-block">
						<input type="text" name="kwyWords"  placeholder="请输入" autocomplete="off"
							class="layui-input">
					</div>
				</div>
			</div> 
			<div class="layui-col-md3">
				<div class="layui-form-item">
					<label class="layui-form-label">标签</label>
						<div class="layui-input-block">
					      <select name="labelIdent" id="labelListSel">
					        <option value="0">请选择</option>
					        <option v-for="item in labels" :value="item.labelIdent">{{item.labelName}}</option>
					      </select>
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
						<h2>展示的博客</h2><br>
						<button class="layui-btn layui-btn-danger" type="button" id="delByIds"><i class="layui-icon layui-icon-delete"></i>删除选中</button>
						<button class="layui-btn " type="button" id="exceptionCustBtn"><i class="layui-icon layui-icon-face-surprised"></i>隐藏选中</button>
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
<div style="display: none;" id="lookCloInfoModel">
	<div  style="margin: 20px 20px">
		<div class="panel panel-default">
			  <div class="panel-body" >
			  <blockquote class="layui-elem-quote" id="labelNameDiv"></blockquote>
			    内容：<br><br><blockquote class="layui-elem-quote" id="cloInfoDiv"></blockquote>
			  </div>
			</div>
	</div>
</div>
<div style="display: none;" id="editBlogInfoModel">
	<div  style="margin: 20px 20px">
		<div class="panel panel-default">
		  <div class="panel-body" >
		  	<form class="layui-form">
		  		<input type="hidden" id="editBlogIdModel" name="blogId"/>
		  		<input type="hidden" id="oldLabelIdentModel" name="filepath"><!-- 暂存老标签ident -->
		  		<div class="layui-form-item">
				  <label class="layui-form-label">标题</label>
				  <div class="layui-input-block">
				    <input type="text" name="blogTitle" id="editBlogTitleModel" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
				  </div>
				</div>
		  		<div class="layui-form-item">
				  <label class="layui-form-label">积分</label>
				  <div class="layui-input-block">
				    <input type="number" name="needIntegral" id="editNeedIntegralModel" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
				  </div>
				</div>
		  		<div class="layui-form-item">
				  <label class="layui-form-label">标签</label>
				  <div class="layui-input-block">
				  	<select name="blogLabel" id="labelListSelModel">
					  <option v-for="item in labels" :value="item.labelIdent">{{item.labelName}}</option>
					</select>
				  </div>
				</div>
		  		<div class="layui-form-item">
				  <label class="layui-form-label">状态</label>
				  <div class="layui-input-block">
				  	<input type="radio" name="blogState" value="展示" title="展示" checked>
      				<input type="radio" name="blogState" value="隐藏" title="隐藏" >
				  </div>
				</div>
		  		<div class="layui-form-item">
				    <div class="layui-input-block">
				      <button class="layui-btn" lay-submit lay-filter="formDemo">修改</button>
				      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
				    </div>
				</div>
		  	</form>
		  </div>
		</div>
	</div>
</div>
<script src="${PATH}/static/js/jquery2.0-min.js"></script>	
<script src="${PATH}/static/layui/layui.all.js"></script>
<script src="${PATH}/static/vue/vue.min.js"></script>
<script src="${PATH}/static/vue/vue-resource.min.js"></script>
<script>
var labelListSel = new Vue({
	el:"#labelListSel",
	data:{
		labels:[],
	},created: function () {
		//供应商
		this.$http.get("${PATH}/blogLabel/getLabelList",{
			}).then(function(response){
			//成功
			this.labels=response.body;
		},function(response) {
			//错误
			console.log("系统错误！")
		});
	},updated:function(){
		layui.form.render('select'); 
	}
	})
var labelListSelModel = new Vue({
	el:"#labelListSelModel",
	data:{
		labels:[],
	},created: function () {
		//供应商
		this.$http.get("${PATH}/blogLabel/getLabelList",{
			}).then(function(response){
			//成功
			this.labels=response.body;
		},function(response) {
			//错误
			console.log("系统错误！")
		});
	},updated:function(){
		layui.form.render('select'); 
	}
	})
</script>	
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
			url : '${PATH}/blog/getShowList',
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
				field : 'blogId',
				title : '#',
				type:"checkbox",
				align : "center"
			}, {
				field : 'blogIdent',
				title : '博文序号',
				align : "center"
			},{
				field : 'blogTitle',
				title : '标题',
				align : "center"
			},{
				field : 'needIntegral',
				title : '积分',
				sort:true,
				align : "center"
			},{
				field : 'blogLook',
				title : '查看次数',
				sort:true,
				align : "center"
			},{
				field : 'commetNum',
				title : '评论量',
				sort:true,
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
		  	 if(layEvent === 'detail'){
		  		$.ajax({
					url:"${PATH}/blogLabel/getByLabelIdent/"+data.blogLabel,
					method:"get",
					success:function(res){
						$("#labelNameDiv").html("标签：&nbsp;&nbsp;&nbsp;&nbsp;"+res.labelName)
					}
				});
		  		$("#cloInfoDiv").html(data.blogText)
		  		layui.layer.open({
					title : '查看博客',
					fix : true,
					resize : false,
					move : false,
					area : [ '1000px', '500px' ],
					shadeClose : false,
					type : 1,
					anim: 5,
					content : $('#lookCloInfoModel'),
					cancel : function(index, layero) {
						$('#lookCloInfoModel').css("display", "none")
					}
				 })
		  	  }else if(layEvent === 'edit'){
		  		$("#editBlogIdModel").val(data.blogId)
		  		$("#editBlogTitleModel").val(data.blogTitle)
		  		$("#editNeedIntegralModel").val(data.needIntegral)
		  		$("#oldLabelIdentModel").val(data.blogLabel)
		  		$("#labelListSelModel option").each(function(){
					var val = $(this).val()
					if(val == data.blogLabel){
						$(this).attr("selected","selected")
					}
				});
		  		layui.form.render('select');	
		  		layui.layer.open({
					title : '修改博客信息',
					fix : true,
					resize : false,
					move : false,
					area : [ '800px', '400px' ],
					shadeClose : false,
					type : 1,
					anim: 5,
					content : $('#editBlogInfoModel'),
					cancel : function(index, layero) {
						$("#labelListSelModel option").each(function(){
				  			$(this).removeAttr("selected");
						});
						layui.form.render('select');
						$('#editBlogInfoModel').css("display", "none")
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
				ids.push($(this)[0].blogId);
			})
			
			if(ids.length==0){
				layer.msg("请选择数据！");
				return false;
			}
			$.ajax({
				url:"${PATH}/blog/delByIds",
				method:"POST",
				contentType: "application/json",//必须指定，否则会报415错误
			    dataType : 'json',
				data:JSON.stringify(ids),
				success:function(res){
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
//批量异常
$("#exceptionCustBtn").click(function(){
	layui.use(['table','layer'], function() {
		var table = layui.table
		,layer = layui.layer;
		layer.confirm('确认隐藏吗？', function(index){
			var checkStatus = table.checkStatus('dataListTbId');
			var datas = checkStatus.data
			var ids = new Array();
			$(datas).each(function(){
				ids.push($(this)[0].blogId);
			})
			if(ids.length==0){
				layer.msg("请选择数据！");
				return false;
			}
			$.ajax({
				url:"${PATH}/blog/hideByIds",
				method:"POST",
				contentType: "application/json",//必须指定，否则会报415错误
			    dataType : 'json',
				data:JSON.stringify(ids),
				success:function(res){
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
layui.use(['form','layer'], function(){
	var form = layui.form,layer=layui.layer;
	form.on('submit(formDemo)', function(data){
	  var datas = data.field
	  $.ajax({
		 url:"${PATH}/blog/editBlogById",
		 method:"POST",
		 data:datas,
		 success:function(res){
			if(res.code==100){
				layer.msg(res.extend.msg,{icon:6},function(){
					layer.closeAll();
					renderTb();
				})
			}else{
				layer.msg(res.extend.msg,{icon:5})	
			}
		},error:function(){
			layer.msg("系统错误")
		}
	  });
	  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
	}); 
});

</script>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
  <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edit">修改</a>
</script>
</body>
</html>