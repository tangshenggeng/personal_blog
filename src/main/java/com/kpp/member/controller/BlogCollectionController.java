package com.kpp.member.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.kpp.blog.beans.Blog;
import com.kpp.blog.service.BlogService;
import com.kpp.member.beans.BlogCollection;
import com.kpp.member.service.BlogCollectionService;
import com.kpp.utils.Msg;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author KPP
 * @since 2020-01-08
 */
@Controller
@RequestMapping("/blogCollection")
public class BlogCollectionController {
	
	@Autowired
	private BlogCollectionService blogCollectSer;
	
	@Autowired
	private BlogService blogSer;
	
	/**
	 * 我的收藏
	 * @return 
	 * */
	@RequestMapping("/getBlogListByMem/{ident}")
	@ResponseBody
	public List<Blog> getBlogListByMem(@PathVariable("ident")String ident) {
		List<BlogCollection> list = blogCollectSer.selectList(new EntityWrapper<BlogCollection>().eq("mem_ident", ident));
		
		String inSql= "";
		if(list.isEmpty()) {
			inSql="1";
		}else {
			for (BlogCollection blogCollection : list) {
				inSql += blogCollection.getBlogIdnet()+",";
			}
		}
		EntityWrapper<Blog> wrapper = new EntityWrapper<>();
		String selectSql = "blog_ident AS blogIdent,blog_title AS blogTitle,need_integral AS needIntegral,commet_num AS commetNum,create_time AS createTime";
		wrapper.setSqlSelect(selectSql).in("blog_ident", inSql).orderBy("blog_id", false);
		List<Blog> blogs = blogSer.selectList(wrapper);
		return blogs;
	}
	
	/**
	 * 判断是否收藏
	 * */
	@RequestMapping("/blogIsConllect/{blogIdent}/{memIdent}")
	@ResponseBody
	public Msg blogIsConllect(@PathVariable("blogIdent")String blogIdent,
			@PathVariable("memIdent")String memIdent) {
		if(memIdent.equals("")) {
			return Msg.fail().add("msg", "登录超时！");
		}
		int count = blogCollectSer.selectCount(new EntityWrapper<BlogCollection>().eq("blog_idnet", blogIdent).eq("mem_ident", memIdent));
		if(count==0) {
			return Msg.fail().add("msg", "未收藏");
		}else {
			return Msg.success().add("msg", "已收藏");
		}
	}
	/**
	 * 收藏博客
	 * */
	@RequestMapping("/collectBlog/{blogIdent}/{memIdent}")
	@ResponseBody
	public Msg collectBlog(@PathVariable("blogIdent")String blogIdent,
			@PathVariable("memIdent")String memIdent) {
		if(memIdent.equals("")) {
			return Msg.fail().add("msg", "登录超时！");
		}
		BlogCollection collection = new BlogCollection();
		collection.setBlogIdnet(blogIdent);
		collection.setMemIdent(memIdent);
		boolean b = blogCollectSer.insert(collection);
		if(b) {
			return Msg.fail().add("msg", "收藏成功");
		}else {
			return Msg.success().add("msg", "收藏失败");
		}
		
	}
	/**
	 * 取消收藏
	 * */
	@RequestMapping("/cancelCollectBlog/{blogIdent}/{memIdent}")
	@ResponseBody
	public Msg cancelCollectBlog(@PathVariable("blogIdent")String blogIdent,
			@PathVariable("memIdent")String memIdent) {
		if(memIdent.equals("")) {
			return Msg.fail().add("msg", "登录超时！");
		}
		boolean b = blogCollectSer.delete(new EntityWrapper<BlogCollection>().eq("blog_idnet", blogIdent).eq("mem_ident", memIdent));
		if(b) {
			return Msg.fail().add("msg", "取消成功");
		}else {
			return Msg.success().add("msg", "取消失败");
		}
		
	}
}

