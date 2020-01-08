package com.kpp.blog.controller;


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
import org.springframework.ui.Model;
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
import com.kpp.blog.beans.BlogLabel;
import com.kpp.blog.service.BlogLabelService;
import com.kpp.blog.service.BlogService;
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
 * @since 2020-01-06
 */
@Controller
@RequestMapping("/blog")
public class BlogController {

	@Autowired
	private BlogLabelService blogLabelSer;
	
	@Autowired
	private BlogService blogSer;
	
	/**
	 * 通过ident查看博客（后台）
	 * */
	@RequestMapping("/getBlogByIdentAdmin/{ident}")
	@ResponseBody
	public Blog getBlogByIdentAdmin(@PathVariable("ident")String ident) {
		Blog blog = blogSer.selectOne(new EntityWrapper<Blog>().eq("blog_ident", ident));
		return blog;
	}
	/**
	 * 热议
	 * @return 
	 * */
	@RequestMapping("/getDiscussions")
	@ResponseBody
	public List<Blog> getDiscussions() {
		EntityWrapper<Blog> wrapper = new EntityWrapper<>();
		String sql = "blog_ident AS blogIdent, blog_title AS blogTitle,commet_num AS commetNum";
		wrapper.setSqlSelect(sql).eq("blog_state", "展示").orderBy("commet_num", false).orderBy("blog_id",false).last("LIMIT 4");
		List<Blog> list = blogSer.selectList(wrapper);
		return list;
	}
	
	/**
	 * 查看免费的博客
	 * */
	@RequestMapping("/getBlogByIdent/{ident}")
	public String getBlogByIdent(@PathVariable("ident")String ident,Model model) {
		EntityWrapper<Blog> wrapper = new EntityWrapper<>();
		String sql = "blog_id AS blogId,blog_ident AS blogIdent, blog_title AS blogTitle,blog_label AS blogLabel,blog_text AS blogText,blog_look AS blogLook,need_integral AS needIntegral,commet_num AS commetNum,create_time AS createTime";
		wrapper.setSqlSelect(sql).eq("blog_ident", ident);
		Blog blog = blogSer.selectOne(wrapper);
		Date time = blog.getCreateTime();
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd :hh:mm:ss");
		String createTime = ft.format(time);
		blog.setFilepath(createTime);
		blog.setBlogLook(blog.getBlogLook()+1);
		boolean b = blogSer.updateById(blog);
		model.addAttribute("blog", blog);
		return "forward:/pages/blog/detail.jsp";
	}
	
	
	/**
	 * 首页得到所有的博客
	 * @return 
	 * */
	@RequestMapping(value="/getBlogListIndex",method=RequestMethod.POST)
	@ResponseBody
	public Page<Map<String, Object>> getBlogListIndex(@RequestBody HashMap<String, Object> map) {
		Integer page = (Integer) map.get("page");
		String condition = (String) map.get("condition");
		String keyword = (String) map.get("keyword");
		String ident = (String) map.get("ident");
		int limit = 8;
		EntityWrapper<Blog> wrapper = new EntityWrapper<>();
		String sqlSelect="blog_ident AS blogIdent,blog_title AS blogTitle,need_integral AS needIntegral,commet_num AS commetNum,create_time AS createTime";
		wrapper.setSqlSelect(sqlSelect);
		if(condition.equals("commet")) {
			wrapper.orderBy("commet_num", false);
		}else{
			wrapper.orderBy("blog_id", false);
		}
		if(!ident.equals("all")) {
			wrapper.like("blog_label", ident);
		}
		if(!(keyword.equals("all")||keyword.equals(""))) {
			wrapper.like("blog_title", keyword);
		}
		wrapper.eq("blog_state", "展示");
		Page<Map<String, Object>> blogsWhitPage = blogSer.selectMapsPage(new Page<Blog>(page, limit), wrapper);
		return blogsWhitPage;
	}
	
	/**
	 *根据id修改
	 * */
	@RequestMapping(value="/editBlogById",method=RequestMethod.POST)
	@ResponseBody
	public Msg editBlogById(Blog blog) {
		Integer needIntegral = blog.getNeedIntegral();
		if(needIntegral<0) {
			return Msg.fail().add("msg", "倒贴？不是吧？？？");
		}
		//更新标签的博文数量
		List<BlogLabel> labels = new ArrayList<BlogLabel>();
		BlogLabel oldLabel = blogLabelSer.selectOne(new EntityWrapper<BlogLabel>().eq("label_ident", blog.getFilepath()));
		BlogLabel newLabel = blogLabelSer.selectOne(new EntityWrapper<BlogLabel>().eq("label_ident", blog.getBlogLabel()));
		oldLabel.setBlogNum(oldLabel.getBlogNum()-1);
		newLabel.setBlogNum(newLabel.getBlogNum()+1);
		labels.add(newLabel);
		labels.add(oldLabel);
		blogLabelSer.updateBatchById(labels);
		
		boolean b = blogSer.updateById(blog);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	
	/**
	 * 批量删除
	 * */
	@RequestMapping(value="/delByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg delByIds(@RequestBody ArrayList<Integer> list) {
		boolean b = blogSer.deleteBatchIds(list);
		if(!b) {
			return Msg.fail().add("msg","删除失败！");
		}
		return Msg.success().add("msg", "删除成功");
	}
	/**
	 * 批量隐藏
	 * */
	@RequestMapping(value="/hideByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg hideByIds(@RequestBody ArrayList<Integer> list) {
		List<Blog> blogs = blogSer.selectBatchIds(list);
		blogs.forEach(blog -> blog.setBlogState("隐藏"));
		boolean b = blogSer.updateBatchById(blogs);
		if(!b) {
			return Msg.fail().add("msg","失败！");
		}
		return Msg.success().add("msg", "成功");
	}
	/**
	 * 批量隐藏
	 * */
	@RequestMapping(value="/showByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg showByIds(@RequestBody ArrayList<Integer> list) {
		List<Blog> blogs = blogSer.selectBatchIds(list);
		blogs.forEach(blog -> blog.setBlogState("展示"));
		boolean b = blogSer.updateBatchById(blogs);
		if(!b) {
			return Msg.fail().add("msg","失败！");
		}
		return Msg.success().add("msg", "成功");
	}
	
	/**
	 * 得到展示的博客
	 * @return 
	 * @throws ParseException 
	 * */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/getShowList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getShowList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		String kwyWords = (String) afterMap.get("kwyWords");
		String labelIdent = (String) afterMap.get("labelIdent");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<Blog> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!kwyWords.equals("")) {
			wrapper.like("blog_title", kwyWords)
			.or().like("blog_ident", kwyWords).andNew();
		}
		if(!labelIdent.equals("0")) {
			wrapper.eq("blog_label", labelIdent);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.eq("blog_state","展示").orderBy("create_time", false);
		Page<Map<String, Object>> mapsPage = blogSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有展示的博客");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	/**
	 * 得到隐藏的博客
	 * @return 
	 * @throws ParseException 
	 * */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/getHideList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getHideList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		String kwyWords = (String) afterMap.get("kwyWords");
		String labelIdent = (String) afterMap.get("labelIdent");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<Blog> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!kwyWords.equals("")) {
			wrapper.like("blog_title", kwyWords)
			.or().like("blog_ident", kwyWords).andNew();
		}
		if(!labelIdent.equals("0")) {
			wrapper.eq("blog_label", labelIdent);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.eq("blog_state","隐藏").orderBy("create_time", false);
		Page<Map<String, Object>> mapsPage = blogSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有隐藏的博客");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	
	
	
	/**
	 * 编写博客
	 * */
	@RequestMapping(value="/addBlog",method=RequestMethod.POST)
	@ResponseBody
	public Msg addBlog(Blog blog) {
		int needIntegral = blog.getNeedIntegral();
		if(needIntegral<0) {
			return Msg.fail().add("msg", "倒贴？不是吧？？？");
		}
		String label = getLabelIdent(blog.getBlogLabel());
		blog.setBlogLabel(label);
		blog.setBlogIdent(UUIDUtil.createUUID());
		blog.setBlogLook(0);
		blog.setCommetNum(0);
		boolean b = blogSer.insert(blog);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}

	/**
	 * 上传文章图片
	 * @return 
	 * */
	@RequestMapping(value="/uploadBlogImg",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadBlogImg(@RequestParam("file") CommonsMultipartFile file) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		UploadFileUtil fileUtils = new UploadFileUtil();
		String result = fileUtils.uploadImgFile(file, ConstantUtils.BLOG_IMG);
		if(result.equals("error")) {
			resultMap.put("code", -1);
			resultMap.put("msg", "图片上传失败");
			return resultMap;	
		}
		String url = "/file/blog/imgs/"+result;
		Map<String, Object> urlMap = new HashMap<String, Object>();
		urlMap.put("src", url);
		resultMap.put("code", 0);
		resultMap.put("msg", "图片上传成功");
		resultMap.put("data", urlMap);
		return resultMap;
	}
	/**
	 * 上传文章文件
	 * @return 
	 * */
	@RequestMapping(value="/uploadBlogFile",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadBlogFile(@RequestParam("file") CommonsMultipartFile file) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		UploadFileUtil fileUtils = new UploadFileUtil();
		String result = fileUtils.uploadFile(file, ConstantUtils.BLOG_FILE);
		if(result.equals("error")) {
			resultMap.put("code", -1);
			resultMap.put("msg", "上传失败");
			return resultMap;	
		}
		String url = "/file/blog/files/"+result;
		Map<String, Object> urlMap = new HashMap<String, Object>();
		urlMap.put("src", url);
		resultMap.put("code", 0);
		resultMap.put("msg", "上传成功");
		resultMap.put("data", urlMap);
		return resultMap;
	}
	/**
	 * 删除文件
	 * @return 
	 * */
	@SuppressWarnings("unused")
	@RequestMapping(value="/deleteFile",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(Blog blog) {
		String filepath = blog.getFilepath();
		String imgpath = blog.getImgpath();
		UploadFileUtil fileUtils = new UploadFileUtil();
		String msg="";
		if(filepath!=null) {
			String substringFile = filepath.substring(filepath.lastIndexOf("/"));
			String string = fileUtils.delFile(ConstantUtils.BLOG_VIDEO+substringFile);
			msg=string;
		}
		if(imgpath!=null) {
			String substringImg = imgpath.substring(imgpath.lastIndexOf("/"));
			String string = fileUtils.delFile(ConstantUtils.BLOG_IMG+substringImg);
			msg=string;
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String fileUrl = filepath;
		String imgUrl = imgpath;
		Map<String, Object> urlMap = new HashMap<String, Object>();
		urlMap.put("src", fileUrl);
		urlMap.put("src", imgUrl);
		resultMap.put("code", 0);
		resultMap.put("msg", "删除成功");
		resultMap.put("data", urlMap);
		return resultMap;
	}
	/**
	 * 上传文章视频
	 * @return 
	 * */
	@RequestMapping(value="/uploadBlogVideo",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadBlogVideo(@RequestParam("file") CommonsMultipartFile file) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		UploadFileUtil fileUtils = new UploadFileUtil();
		String result = fileUtils.uploadVideoFile(file, ConstantUtils.BLOG_VIDEO);
		if(result.equals("error")) {
			resultMap.put("code", -1);
			resultMap.put("msg", "视频上传失败");
			return resultMap;	
		}
		String url = "/file/blog/videos/"+result;
		Map<String, Object> urlMap = new HashMap<String, Object>();
		urlMap.put("src", url);
		resultMap.put("code", 0);
		resultMap.put("msg", "视频上传成功");
		resultMap.put("data", urlMap);
		return resultMap;
	}
	
	//===============页面跳转=====================
	//通过标签名字等到标签的ident
	private String getLabelIdent(String blogLabel) {
		BlogLabel label = blogLabelSer.selectOne(new EntityWrapper<BlogLabel>().eq("label_name", blogLabel));
		if(label!=null) {	//标签存在
			label.setBlogNum(label.getBlogNum()+1);
			blogLabelSer.updateById(label);
			return label.getLabelIdent();
		}else {		//标签不存在
			String ident = UUIDUtil.createUUID();
			BlogLabel newLabel = new BlogLabel();
			newLabel.setBlogNum(1);
			newLabel.setLabelIdent(ident);
			newLabel.setLabelName(blogLabel);
			blogLabelSer.insert(newLabel);
			return ident;
		}
	}
	//去往编写界面
	@RequestMapping("/toWritePage")
	public String toWritePage() {
		return "/blog/write";
	}
	//展示的博客
	@RequestMapping("/toShowPage")
	public String toShowPage() {
		return "/blog/show-blogs";
	}
	//隐藏的博客
	@RequestMapping("/toHidePage")
	public String toHidePage() {
		return "/blog/hide-blog";
	}
	
}

