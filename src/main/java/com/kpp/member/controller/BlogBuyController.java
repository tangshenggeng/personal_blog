package com.kpp.member.controller;


import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.kpp.blog.beans.Blog;
import com.kpp.blog.service.BlogService;
import com.kpp.comment.beans.Comment;
import com.kpp.member.beans.BlogBuy;
import com.kpp.member.beans.Member;
import com.kpp.member.service.BlogBuyService;
import com.kpp.member.service.MemberService;
import com.kpp.utils.AnalysisKeyWordsListUtils;
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
@RequestMapping("/blogBuy")
public class BlogBuyController {

	@Autowired
	private BlogBuyService blogBuySer;
	
	@Autowired
	public MemberService memSer;
	
	@Autowired
	public BlogService blogSer;
	
	/**
	 * 批量删除
	 * */
	@RequestMapping(value="/delByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg delByIds(@RequestBody ArrayList<Integer> list) {
		boolean b = blogBuySer.deleteBatchIds(list);
		if(!b) {
			return Msg.fail().add("msg","删除失败！");
		}
		return Msg.success().add("msg", "删除成功");
	}
	
	/**
	 * 得到所有购买订单
	 * @return 
	 * @throws ParseException 
	 * */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/getBuyList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getBuyList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		String keywords = (String) afterMap.get("keywords");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<BlogBuy> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!keywords.equals("")) {
			wrapper.eq("mem_ident", keywords).or().eq("blog_ident", keywords);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.orderBy("create_time", false);
		Page<Map<String, Object>> mapsPage = blogBuySer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有购买");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	
	/**
	 * 我的收藏
	 * @return 
	 * */
	@RequestMapping("/getBlogListByMem/{ident}")
	@ResponseBody
	public List<Blog> getBlogListByMem(@PathVariable("ident")String ident) {
		List<BlogBuy> list = blogBuySer.selectList(new EntityWrapper<BlogBuy>().eq("mem_ident", ident));
		String inSql= "";
		if(list.isEmpty()) {
			inSql="1";
		}else {
			for (BlogBuy blogBuy : list) {
				inSql += blogBuy.getBlogIdent()+",";
			}
		}
		EntityWrapper<Blog> wrapper = new EntityWrapper<>();
		String selectSql = "blog_ident AS blogIdent,blog_title AS blogTitle,need_integral AS needIntegral,commet_num AS commetNum,create_time AS createTime";
		wrapper.setSqlSelect(selectSql).in("blog_ident", inSql).orderBy("blog_id", false);
		List<Blog> blogs = blogSer.selectList(wrapper);
		return blogs;
	}
	
	/**
	 * 购买博客
	 * */
	@RequestMapping("/blogForBuy/{blogIdent}/{memIdent}")
	@ResponseBody
	public Msg blogForBuy(@PathVariable("blogIdent")String blogIdent,
			@PathVariable("memIdent")String memIdent) {
		Member member = memSer.selectOne(new EntityWrapper<Member>().eq("m_ident", memIdent));
		Blog blog = blogSer.selectOne(new EntityWrapper<Blog>().eq("blog_ident", blogIdent));
		if(member==null||blog==null) {
			return Msg.fail().add("msg", "客户或博客未找到！");
		}
		int memIntegra = member.getmIntegral();
		int needIntegral = blog.getNeedIntegral();
		if(memIntegra<needIntegral) {
			return Msg.fail().add("msg", "积分不足！");
		}
		member.setmIntegral(memIntegra-needIntegral);
		memSer.updateById(member);				//更新客户积分
		BlogBuy entity = new BlogBuy();
		entity.setBlogIdent(blogIdent);
		entity.setMemIdent(memIdent);
		boolean b = blogBuySer.insert(entity);
		if(b) {
			return Msg.success().add("msg", "成功").add("ident", blogIdent);
		}
		return Msg.fail().add("msg", "失败");
	}
	
	/**
	 * 判断是否购买
	 * */
	@RequestMapping("/blogIsBuy/{blogIdent}/{memIdent}")
	@ResponseBody
	public Msg blogIsBuy(@PathVariable("blogIdent")String blogIdent,
			@PathVariable("memIdent")String memIdent) {
		if(memIdent.equals("")) {
			return Msg.fail().add("msg", "登录超时！");
		}
		int count = blogBuySer.selectCount(new EntityWrapper<BlogBuy>().eq("blog_ident", blogIdent).eq("mem_ident", memIdent));
		if(count==0) {
			return Msg.fail().add("msg", "未购买");
		}else {
			return Msg.success().add("msg", "已购买");
		}
	}
	@RequestMapping("/toBlogsBuyPage")
	public String toBlogsBuyPage() {
		return "/blog/buy-blogs";
	}
}

