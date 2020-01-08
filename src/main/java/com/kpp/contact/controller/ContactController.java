package com.kpp.contact.controller;


import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.kpp.contact.beans.Contact;
import com.kpp.contact.service.ContactService;
import com.kpp.utils.Msg;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 应建
 * @since 2019-12-28
 */
@Controller
@RequestMapping("/contact")
public class ContactController {

	@Autowired
	private ContactService conSer;
	
	/**
	 * 批量删除
	 * */
	@RequestMapping(value="/delContactsByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg delClothingByIds(@RequestBody ArrayList<Integer> list) {
		boolean b = conSer.deleteBatchIds(list);
		if(!b) {
			return Msg.fail().add("msg","删除失败！");
		}
		return Msg.success().add("msg", "删除成功");
	}
	
	/**
	 * 得到所有留言
	 * @return 
	 * @throws ParseException 
	 * */
	@RequestMapping(value="/getAllContact",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getAllContact(@RequestParam("page")Integer page ,@RequestParam("limit")Integer limit ) {
		Page<Map<String, Object>> mapsPage = conSer.selectMapsPage(new Page<>(page, limit), new EntityWrapper<Contact>().orderBy("contact_id", false));
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有的留言");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	/**
	 * 留言
	 * */
	@RequestMapping(value="/addContact",method=RequestMethod.POST)
	@ResponseBody
	public Msg addContact(Contact con) {
		boolean b = conSer.insert(con);
		if(b) {
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	
}

