package com.kpp.member.controller;


import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.kpp.code.beans.RegiterCode;
import com.kpp.code.service.RegiterCodeService;
import com.kpp.member.beans.Member;
import com.kpp.member.service.MemberService;
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
	 * 注册
	 * */
	@RequestMapping(value="/regiter",method=RequestMethod.POST)
	@ResponseBody
	public Msg regiter(Member mem) {
		System.out.println(mem);
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
	//====================================
	/**
	 * 抽取方法，验证用户名和邮箱是否存在
	 * true 存在
	 * false 不存在	
	 * @return 
	 */
	public boolean repeatOrNot(String email) {
		EntityWrapper<Member> getCustWrapper = new EntityWrapper<>();
		getCustWrapper.eq("m_email", email);
		int count2 = memSer.selectCount(getCustWrapper);
		if(count2 != 0) {
			return true;
		}
		return false;
	}
	
}

