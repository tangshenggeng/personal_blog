package com.kpp.comment.controller;


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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.kpp.blog.beans.Blog;
import com.kpp.blog.service.BlogService;
import com.kpp.comment.beans.Comment;
import com.kpp.comment.service.CommentService;
import com.kpp.utils.AnalysisKeyWordsListUtils;
import com.kpp.utils.ConstantUtils;
import com.kpp.utils.Msg;
import com.kpp.utils.UUIDUtil;
import com.kpp.utils.UploadFileUtil;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author KPP
 * @since 2020-01-08
 */
@Controller
@RequestMapping("/comment")
public class CommentController {

	@Autowired
	private CommentService commSer;
	
	@Autowired
	private BlogService blogSer;
	
	/**
	 * 批量删除
	 * */
	@RequestMapping(value="/delByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg delByIds(@RequestBody ArrayList<Integer> list) {
		boolean b = commSer.deleteBatchIds(list);
		if(!b) {
			return Msg.fail().add("msg","删除失败！");
		}
		return Msg.success().add("msg", "删除成功");
	}
	
	
	/**
	 * 回复评论
	 * */
	@RequestMapping(value="/returnComment",method=RequestMethod.POST)
	@ResponseBody
	public Msg returnComment(Comment comm) {
		boolean b = commSer.updateById(comm);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	
	/**
	 * 得到所有评论
	 * @return 
	 * @throws ParseException 
	 * */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/getCommentList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getCommentList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		String keywords = (String) afterMap.get("keywords");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<Comment> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!keywords.equals("")) {
			wrapper.eq("mem_ident", keywords).or().eq("blog_ident", keywords).or().like("comment_text", keywords).or().like("reply_text", keywords);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.orderBy("create_time", false);
		Page<Map<String, Object>> mapsPage = commSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有评论");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	
	/**
	 * 得到所有评论（展示）
	 * @return 
	 * */
	@RequestMapping("/getCommentByShow/{ident}")
	@ResponseBody
	public List<Comment> getCommentByShow(@PathVariable("ident")String ident) {
		EntityWrapper<Comment> wrapper = new EntityWrapper<>();
		//String sql ="";
		wrapper.eq("blog_ident", ident).orderBy("comment_id", false);
		List<Comment> list = commSer.selectList(wrapper);
		return list;
	}
	
	/**
	 * 添加评论
	 * */
	@RequestMapping(value="/addComment",method=RequestMethod.POST)
	@ResponseBody
	public Msg addComment(Comment comm) {
		comm.setCommentIdent(UUIDUtil.createUUID());
		Blog blog = blogSer.selectOne(new EntityWrapper<Blog>().eq("blog_ident", comm.getBlogIdent()));
		blog.setCommetNum(blog.getCommetNum()+1);
		blogSer.updateById(blog);
		boolean b = commSer.insert(comm);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	
	
	/**
	 * 上传文章图片
	 * @return 
	 * */
	@RequestMapping(value="/uploadImg",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadImg(@RequestParam("file") CommonsMultipartFile file) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		UploadFileUtil fileUtils = new UploadFileUtil();
		String result = fileUtils.uploadImgFile(file, ConstantUtils.COMMENT_IMG);
		if(result.equals("error")) {
			resultMap.put("code", -1);
			resultMap.put("msg", "图片上传失败");
			return resultMap;	
		}
		String url = "/file/comment/imgs/"+result;
		resultMap.put("status", 0);
		resultMap.put("msg", "图片上传成功");
		resultMap.put("url", url);
		return resultMap;
	}
	//===========页面跳转===========
	/**
	 * 去往评论管理界面
	 * */
	@RequestMapping("/toCommentsPage")
	public String toCommentsPage() {
		return "/comment/comment-list";
	}
}

