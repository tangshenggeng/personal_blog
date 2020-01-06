package com.kpp.blog.controller;


import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.kpp.blog.beans.BlogLabel;
import com.kpp.blog.service.BlogLabelService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author KPP
 * @since 2020-01-06
 */
@Controller
@RequestMapping("/blogLabel")
public class BlogLabelController {

	@Autowired
	private BlogLabelService blogLabelSer;
	
	//得到所有的label
	@RequestMapping("/getLabelList")
	@ResponseBody
	public List<BlogLabel> getLabelList() {
		List<BlogLabel> list = blogLabelSer.selectList(new EntityWrapper<BlogLabel>().orderBy("blog_num", false));
		return list;
	}
	//通过ident得到
	@RequestMapping("/getByLabelIdent/{ident}")
	@ResponseBody
	public BlogLabel getByLabelIdent(@PathVariable("ident")String ident) {
		BlogLabel label = blogLabelSer.selectOne(new EntityWrapper<BlogLabel>().eq("label_ident", ident));
		return label;
	}
	
}

