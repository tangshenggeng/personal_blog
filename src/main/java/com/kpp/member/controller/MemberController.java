package com.kpp.member.controller;


import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.kpp.code.beans.RegiterCode;
import com.kpp.code.service.RegiterCodeService;
import com.kpp.member.beans.Member;
import com.kpp.member.service.MemberService;
import com.kpp.utils.AnalysisKeyWordsListUtils;
import com.kpp.utils.ConstantUtils;
import com.kpp.utils.EmailUntils;
import com.kpp.utils.Msg;
import com.kpp.utils.UUIDUtil;
import com.kpp.utils.UploadFileUtil;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author KPP
 * @since 2020-01-04
 */
@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService memSer;
	
	@Autowired
	private RegiterCodeService regiterCodeSer;	//验证码
	
	/**
	 * 通过ident查询
	 * */
	@RequestMapping(value="/getByMemIdent/{ident}",produces = "text/html; charset=utf-8")
	@ResponseBody
	public String getByMemIdent(@PathVariable("ident")String ident) {
		Member member = memSer.selectOne(new EntityWrapper<Member>().eq("m_ident", ident));
		String info = "该客户的邮箱为："+member.getmEmail()
		+"<hr>签名为："+member.getmAutograph()
		+"<hr>当前积分为："+member.getmIntegral()
		+"<hr>账号状态为："+member.getmState();
		return info;
	}
	
	/**
	 * 批量拉黑
	 * */
	@RequestMapping(value="/exceptionCustByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg exceptionCustByIds(@RequestBody ArrayList<Integer> list) {
		List<Member> selectBatchIds = memSer.selectBatchIds(list);
		for (Member member : selectBatchIds) {
			member.setmState("异常");
			EmailUntils emailUtils = new EmailUntils();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = new Date();
		    String format = sdf.format(date);       //将Date类型转换成String类型  
			String text =  "您的账号经后台在"+format+"检测出现异常！您将无法登录！如有疑问，联系我。";
			emailUtils.sendEmailToCooper(member.getmEmail(),text);
		}
		boolean b = memSer.updateBatchById(selectBatchIds);
		if(!b) {
			return Msg.fail().add("msg","失败！");
		}
		return Msg.success().add("msg", "成功");
	}
	/**
	 * 批量恢复
	 * */
	@RequestMapping(value="/recoveryCustByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg recoveryCustByIds(@RequestBody ArrayList<Integer> list) {
		List<Member> selectBatchIds = memSer.selectBatchIds(list);
		for (Member member : selectBatchIds) {
			member.setmState("正常");
			EmailUntils emailUtils = new EmailUntils();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = new Date();
		    String format = sdf.format(date);       //将Date类型转换成String类型  
			String text =  "您的账号经后台在"+format+"检测，已经为您恢复，给您带来不便深感抱歉！如有疑问，联系我。";
			emailUtils.sendEmailToCooper(member.getmEmail(),text);
		}
		boolean b = memSer.updateBatchById(selectBatchIds);
		if(!b) {
			return Msg.fail().add("msg","失败！");
		}
		return Msg.success().add("msg", "成功");
	}
	/**
	 * 批量删除
	 * */
	@RequestMapping(value="/delCustByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg delCustByIds(@RequestBody ArrayList<Integer> list) {
		boolean b = memSer.deleteBatchIds(list);
		if(!b) {
			return Msg.fail().add("msg","删除失败！");
		}
		return Msg.success().add("msg", "删除成功");
	}
	
	/**
	 * 得到正常客户
	 * @return 
	 * @throws ParseException 
	 * */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/getNormalCustList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getNormalCustList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		String email = (String) afterMap.get("custEmail");
		String name = (String) afterMap.get("custName");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<Member> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!name.equals("")) {
			wrapper.like("m_nick", name).or().like("m_autograph", name).or().like("m_ident", name);
		}
		if(!email.equals("")) {
			wrapper.eq("m_email", email);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.eq("m_state","正常").orderBy("create_time", false);
		Page<Map<String, Object>> mapsPage = memSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有正常客户");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	/**
	 * 得到异常客户
	 * @return 
	 * @throws ParseException 
	 * */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/getAbnormalCustList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getAbnormalCustList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		String email = (String) afterMap.get("custEmail");
		String name = (String) afterMap.get("custName");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<Member> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!name.equals("")) {
			wrapper.like("m_nick", name).or().like("m_autograph", name).or().like("m_ident", name);
		}
		if(!email.equals("")) {
			wrapper.eq("m_email", email);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.eq("m_state","异常").orderBy("create_time", false);
		Page<Map<String, Object>> mapsPage = memSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有异常客户");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	/**
	 *添加客户
	 * */
	@RequestMapping(value="/addMem",method=RequestMethod.POST)
	@ResponseBody
	public Msg addCust(Member cust) {
		//验证用户名或者邮箱是否已经存在
		boolean orNot = repeatOrNot(cust.getmEmail());
		if(orNot) {
			return Msg.fail().add("msg", "客户已存在！");
		}
		cust.setmIdent(UUIDUtil.createUUID());
		cust.setmPassword("123456");
		cust.setmHeader("/file/header/default.png");
		cust.setmAutograph("这个人很赖，什么都没留下！");
		cust.setmState("正常");
		cust.setmNick("默认昵称");
		cust.setmIntegral(0);
		boolean b = memSer.insert(cust);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	
	/**
	 * 修改密码
	 * */
	@RequestMapping(value="/editPwd",method=RequestMethod.POST)
	@ResponseBody
	public Msg editPwd(Member member) {
		String pwd1 = member.getFormPwd1();
		String pwd2 = member.getFormPwd2();
		if(!pwd1.equals(pwd2)) {
			return Msg.fail().add("msg","两次密码输入不一致！");
		}
		Member one = memSer.selectOne(new EntityWrapper<Member>().eq("m_ident", member.getmIdent()).eq("m_password", member.getFormCode()));
		if(one==null) {
			return Msg.fail().add("msg","原密码错误！");
		}
		one.setmPassword(pwd2);
		boolean b = memSer.updateById(one);
		if(b) {
			return Msg.success().add("msg", "修改成功！请重新登录！");
		}
		return Msg.fail().add("msg","修改失败！");
	}
	
	/**
	 * 修改头像（隐患两个人同时修改）
	 * @return 
	 * */
	@RequestMapping(value="/editHeaderImg",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> editHeaderImg(@RequestParam("file") CommonsMultipartFile file,HttpServletRequest req) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		UploadFileUtil fileUtils = new UploadFileUtil();
		String result = fileUtils.uploadImgFile(file, ConstantUtils.HEADER_IMG);
		if(result.equals("error")) {
			resultMap.put("code", -1);
			resultMap.put("msg", "图片上传失败");
			return resultMap;	
		}
		String url = "/file/header/"+result;
		String ident = (String) req.getSession().getAttribute("ident");
		Member member = new Member();
		member.setmHeader(url);
		boolean b = memSer.update(member, new EntityWrapper<Member>().eq("m_ident", ident));
		if(b) {
			req.getSession().setAttribute("header", url);
			resultMap.put("code", 0);
			resultMap.put("msg", "头像修改成功！");
			resultMap.put("data", url);
			return resultMap;
		}
		resultMap.put("code", -1);
		resultMap.put("msg", "头像修改失败！");
		return resultMap;	
	}
	
	/**
	 * 修改资料
	 * */
	@RequestMapping(value="/editInfo",method=RequestMethod.POST)
	@ResponseBody
	public Msg editInfo(Member mem,HttpServletRequest req) {
		Member byIdent = getByIdent(mem.getmIdent());
		if(byIdent==null) {
			return Msg.fail().add("msg", "未找到您的信息！");
		}
		Member member = new Member();
		member.setmAutograph(mem.getmAutograph());
		member.setmNick(mem.getmNick());
		boolean b = memSer.update(member, new EntityWrapper<Member>().eq("m_ident", mem.getmIdent()).eq("m_email", mem.getmEmail()));
		if(b) {
			req.getSession().setAttribute("name", mem.getmNick());
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	
	/**
	 * 退出登录
	 * */
	@RequestMapping(value="/loginOut",method=RequestMethod.GET)
	public String loginOut(HttpServletRequest req) {
		req.getSession().invalidate();
		return "redirect:/pages/index.jsp";
	}
	/**
	 * 登录
	 * */
	@RequestMapping(value="/loginInto",method=RequestMethod.POST)
	public String loginInto(Member men,HttpServletRequest req,Model model) {
		EntityWrapper<Member> wrapper = new EntityWrapper<>();
		//验证用户名或者邮箱是否已经存在
		boolean orNot = repeatOrNot(men.getmEmail());
		if(!orNot) {
			model.addAttribute("error", "您还未注册！请您先注册！");
			return "forward:/pages/login.jsp";
		}
		wrapper.eq("m_email",men.getmEmail()).eq("m_password",men.getmPassword()).eq("m_state","正常");
		Member one = memSer.selectOne(wrapper);
		if(one==null) {
			model.addAttribute("error", "用户名或密码错误或账号异常");
			return "forward:/pages/login.jsp";
		}
		req.getSession().setAttribute("name", one.getmNick());
		req.getSession().setAttribute("ident", one.getmIdent());
		req.getSession().setAttribute("header", one.getmHeader());
		return "redirect:/pages/index.jsp";
	}
	/**
	 * 忘记密码
	 * */
	@RequestMapping(value="/forgetPwd",method=RequestMethod.POST)
	@ResponseBody
	public Msg forgetPwd(Member men) {
		//验证两次输入的密码
		if(!men.getFormPwd1().equals(men.getFormPwd2())) {
			return Msg.fail().add("msg", "两次密码不一致！");
		}
		//验证用户名或者邮箱是否已经存在
		boolean orNot = repeatOrNot(men.getmEmail());
		if(!orNot) {
			return Msg.fail().add("msg", "账号不存在！");
		}
		//验证邮箱
		EntityWrapper<RegiterCode> codeWrapper = new EntityWrapper<>();
		codeWrapper.eq("regiter_email", men.getmEmail())
		.eq("code", men.getFormCode());
		int count = regiterCodeSer.selectCount(codeWrapper);
		if(count == 0) {
			return Msg.fail().add("msg", "验证码有误！");
		}
		//删除对应邮箱验证码
		regiterCodeSer.delete(codeWrapper);
		
		EntityWrapper<Member> wrapper = new EntityWrapper<>();
		wrapper.eq("m_email",men.getmEmail())
		.eq("m_state", "正常");
		int custCount = memSer.selectCount(wrapper);
		if(custCount==0) {
			return Msg.fail().add("msg", "您的账号出现异常");
		}
		men.setmPassword(men.getFormPwd2());
		boolean b = memSer.update(men, wrapper);
		if(b) {
			return Msg.success().add("msg", "修改成功！请登录！");
		}else {
			return Msg.fail().add("msg", "修改失败！");
		}
	}
	
	/**
	 * 注册
	 * */
	@RequestMapping(value="/regiter",method=RequestMethod.POST)
	@ResponseBody
	public Msg regiter(Member mem) {
		//验证两次输入的密码
		if(!mem.getFormPwd1().equals(mem.getFormPwd2())) {
			return Msg.fail().add("msg", "两次密码不一致！");
		}
		//验证用户名或者邮箱是否已经存在
		boolean orNot = repeatOrNot(mem.getmEmail());
		if(orNot) {
			return Msg.fail().add("msg", "您已经注册过了！");
		}
		//验证邮箱
		EntityWrapper<RegiterCode> codeWrapper = new EntityWrapper<>();
		codeWrapper.eq("regiter_email", mem.getmEmail())
					.eq("code", mem.getFormCode());
		int count = regiterCodeSer.selectCount(codeWrapper);
		if(count == 0) {
			return Msg.fail().add("msg", "验证码有误！");
		}
		//删除对应邮箱验证码
		regiterCodeSer.delete(codeWrapper);
		Member member = new Member();
		member.setmAutograph(mem.getmAutograph());
		member.setmEmail(mem.getmEmail());
		member.setmIdent(UUIDUtil.createUUID());
		member.setmIntegral(0);
		member.setmNick(mem.getmNick());
		member.setmPassword(mem.getFormPwd2());
		member.setmState("正常");
		String header = mem.getmHeader();
		if(header.equals("")) {
			member.setmHeader("/file/header/default.png");
		}else {
			member.setmHeader(header);
		}
		boolean b = memSer.insert(member);
		if(b) {
			return Msg.success().add("msg", "注册成功！请登录！");
		}
		return Msg.fail().add("msg", "注册失败！");
	}
	/**
	 * 上传头像
	 * @return 
	 * */
	@RequestMapping(value="/uploadHeaderImg",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadHeaderImg(@RequestParam("file") CommonsMultipartFile file) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		UploadFileUtil fileUtils = new UploadFileUtil();
		String result = fileUtils.uploadImgFile(file, ConstantUtils.HEADER_IMG);
		if(result.equals("error")) {
			resultMap.put("code", 1);
			resultMap.put("msg", "图片上传失败");
			return resultMap;	
		}
		String url = "/file/header/"+result;
		resultMap.put("code", 0);
		resultMap.put("msg", "图片上传成功");
		resultMap.put("data", url);
		return resultMap;
	}
	//===============页面跳转及方法抽取=====================
	/**
	 * 抽取方法，验证用户名和邮箱是否存在
	 * true 存在
	 * false 不存在	
	 * @return 
	 */
	private boolean repeatOrNot(String email) {
		EntityWrapper<Member> getCustWrapper = new EntityWrapper<>();
		getCustWrapper.eq("m_email", email);
		int count2 = memSer.selectCount(getCustWrapper);
		if(count2 != 0) {
			return true;
		}
		return false;
	}
	//去往设置信息界面
	@RequestMapping("/toSetMyInfoPage/{ident}")
	public String toSetMyInfoPage(@PathVariable("ident")String ident,Model model) {
		Member member = getByIdent(ident);
		if(member==null) {
			model.addAttribute("msg", "未找到您的信息");
			return "forward:/pages/member/set.jsp";
		}
		model.addAttribute("email", member.getmEmail());
		model.addAttribute("autograph", member.getmAutograph());
		model.addAttribute("nick", member.getmNick());
		model.addAttribute("header", member.getmHeader());
		return "forward:/pages/member/set.jsp";
	}
	//去往充值积分界面
	@RequestMapping("/toMyIntegralPage/{ident}")
	public String toMyIntegralPage(@PathVariable("ident")String ident,Model model) {
		Member member = getByIdent(ident);
		if(member==null) {
			model.addAttribute("msg", "未找到您的信息");
			return "forward:/pages/member/integral.jsp";
		}
		model.addAttribute("integral", member.getmIntegral());
		return "forward:/pages/member/integral.jsp";
	}
	//通过ident找到客户
	private Member getByIdent(String ident) {
		EntityWrapper<Member> wrapper = new EntityWrapper<>();
		wrapper.eq("m_ident", ident);
		Member mem = memSer.selectOne(wrapper);
		return mem;
	}
	//添加客户
	@RequestMapping(value="/toAddMemPage")
	public String toAddCustPage() {
		return "/custs/add-cust";
	}
	
	//正常客户
	@RequestMapping("/toNormalMemPage")
	public String toNormalCustPage() {
		return "/custs/normal-custs";
	}
	//异常客户
	@RequestMapping("/toAbnormalMemPage")
	public String toAbnormalCustPage() {
		return "/custs/abnormal-custs";
	}
	//我的收藏
	@RequestMapping("/toMyCollectBlogPage/{ident}")
	public String toMyCollectBlogPage(@PathVariable("ident")String ident,Model model) {
		Member member = getByIdent(ident);
		if(member==null) {
			model.addAttribute("msg", "未找到您的信息");
			return "forward:/pages/member/my-collections.jsp";
		}
		model.addAttribute("ident", member.getmIdent());
		return "forward:/pages/member/my-collections.jsp";
	}
	//我的收藏
	@RequestMapping("/toMyBuyBlogPage/{ident}")
	public String toMyBuyBlogPage(@PathVariable("ident")String ident,Model model) {
		Member member = getByIdent(ident);
		if(member==null) {
			model.addAttribute("msg", "未找到您的信息");
			return "forward:/pages/member/my-collections.jsp";
		}
		model.addAttribute("ident", member.getmIdent());
		return "forward:/pages/member/my-buy.jsp";
	}
	
}

