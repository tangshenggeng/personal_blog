<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <div class="layui-side layui-bg-cyan">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree">
        <li class="layui-nav-item">
          <a class="" href="javascript:;">客户管理</a>
          <dl class="layui-nav-child">
            <dd><a href="${PATH}/member/toAddMemPage">添加客户</a></dd>
          	<dd><a href="${PATH}/member/toNormalMemPage">正常顾客</a></dd>
          	<dd><a href="${PATH}/member/toAbnormalMemPage">异常顾客</a></dd>
          </dl>
        </li>
        <!-- <li class="layui-nav-item">
          <a href="javascript:;">会员管理</a>
          <dl class="layui-nav-child">
            <dd><a href="javascript:;">列表一</a></dd>
            <dd><a href="javascript:;">列表二</a></dd>
            <dd><a href="">超链接</a></dd>
          </dl>
        </li> -->
        <li class="layui-nav-item">
          <a href="javascript:;">积分日志</a>
          <dl class="layui-nav-child">
            <dd><a href="${PATH}/integralRecharge/toNormalPage">正常充值</a></dd>
            <dd><a href="${PATH}/integralRecharge/toAbnormalPage">异常充值</a></dd>
          </dl>
        </li>
        <li class="layui-nav-item">
          <a href="javascript:;">评论及购买记录</a>
          <dl class="layui-nav-child">
            <dd><a href="${PATH}/comment/toCommentsPage">评论管理</a></dd>
            <dd><a href="${PATH}/blogBuy/toBlogsBuyPage">购买记录</a></dd>
          </dl>
        </li>
        <li class="layui-nav-item">
          <a href="javascript:;">博客管理</a>
          <dl class="layui-nav-child">
            <dd><a href="${PATH}/blog/toWritePage">编写博客</a></dd>
            <dd><a href="${PATH}/blog/toShowPage">展示的博客</a></dd>
            <dd><a href="${PATH}/blog/toHidePage">隐藏的博客</a></dd>
          </dl>
        </li>
      </ul>
    </div>
  </div>