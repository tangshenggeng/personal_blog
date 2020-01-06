package com.kpp.integralRecharge.controller;


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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.kpp.integralRecharge.beans.IntegralRecharge;
import com.kpp.integralRecharge.service.IntegralRechargeService;
import com.kpp.member.beans.Member;
import com.kpp.member.service.MemberService;
import com.kpp.utils.AnalysisKeyWordsListUtils;
import com.kpp.utils.EmailUntils;
import com.kpp.utils.Msg;
import com.kpp.utils.UUIDUtil;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author KPP
 * @since 2020-01-05
 */
@Controller
@RequestMapping("/integralRecharge")
public class IntegralRechargeController {

	@Autowired
	private  MemberService memSer;
	
	@Autowired
	private IntegralRechargeService inReSer;
	
	/**
	 * 批量拉黑
	 * */
	@RequestMapping(value="/exceptionByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg exceptionByIds(@RequestBody ArrayList<Integer> list) {
		List<IntegralRecharge> selectBatchIds = inReSer.selectBatchIds(list);
		for (IntegralRecharge integralRecharge : selectBatchIds) {
			integralRecharge.setRechargeState("异常");
			//积分回滚
			int integral = integralRecharge.getPayMoney()*100;
			Member member = memSer.selectOne(new EntityWrapper<Member>().eq("m_ident", integralRecharge.getMemIdent()));
			int oldIntegral = member.getmIntegral();
			int newIntegral = oldIntegral-integral;
			if(newIntegral<0) {
				EmailUntils emailUtils = new EmailUntils();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			    String format = sdf.format(integralRecharge.getCreateTime());       //将Date类型转换成String类型  
				String text =  "您在"+format+"充值"+integral+"积分，后台检测出现异常！当前您的积分为："+newIntegral+",为了不影响你的账号正常使用，请您及时补充充值！如有疑问，联系我。";
				emailUtils.sendEmailToCooper(member.getmEmail(),text);
			}else {
				EmailUntils emailUtils = new EmailUntils();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			    String format = sdf.format(integralRecharge.getCreateTime());       //将Date类型转换成String类型  
				String text =  "您在"+format+"充值"+integral+"积分，后台检测出现异常！当前您的积分为："+newIntegral+"如有疑问，联系我。";
				emailUtils.sendEmailToCooper(member.getmEmail(),text);
			}
			member.setmIntegral(newIntegral);
			memSer.updateById(member);
		}
		boolean b = inReSer.updateBatchById(selectBatchIds);
		if(!b) {
			return Msg.fail().add("msg","失败！");
		}
		return Msg.success().add("msg", "成功");
	}
	/**
	 * 批量拉黑
	 * */
	@RequestMapping(value="/recoveryByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg recoveryByIds(@RequestBody ArrayList<Integer> list) {
		List<IntegralRecharge> selectBatchIds = inReSer.selectBatchIds(list);
		for (IntegralRecharge integralRecharge : selectBatchIds) {
			integralRecharge.setRechargeState("正常");
			//积分回滚
			int integral = integralRecharge.getPayMoney()*100;
			Member member = memSer.selectOne(new EntityWrapper<Member>().eq("m_ident", integralRecharge.getMemIdent()));
			int oldIntegral = member.getmIntegral();
			int newIntegral = oldIntegral+integral;
			if(newIntegral<0) {
				EmailUntils emailUtils = new EmailUntils();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String format = sdf.format(integralRecharge.getCreateTime());       //将Date类型转换成String类型  
				String text =  "您在"+format+"充值"+integral+"积分，后台已经为您恢复！当前您的积分为："+newIntegral+",为了不影响你的账号正常使用，请您及时补充充值！如有疑问，联系我。";
				emailUtils.sendEmailToCooper(member.getmEmail(),text);
			}else {
				EmailUntils emailUtils = new EmailUntils();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String format = sdf.format(integralRecharge.getCreateTime());       //将Date类型转换成String类型  
				String text =  "您在"+format+"充值"+integral+"积分，后台已经为您恢复！当前您的积分为："+newIntegral+"如有疑问，联系我。";
				emailUtils.sendEmailToCooper(member.getmEmail(),text);
			}
			member.setmIntegral(newIntegral);
			memSer.updateById(member);
		}
		boolean b = inReSer.updateBatchById(selectBatchIds);
		if(!b) {
			return Msg.fail().add("msg","失败！");
		}
		return Msg.success().add("msg", "成功");
	}
	
	/**
	 * 批量删除
	 * */
	@RequestMapping(value="/delByIds",method=RequestMethod.POST)
	@ResponseBody
	public Msg delCustByIds(@RequestBody ArrayList<Integer> list) {
		boolean b = inReSer.deleteBatchIds(list);
		if(!b) {
			return Msg.fail().add("msg","删除失败！");
		}
		return Msg.success().add("msg", "删除成功");
	}
	
	/**
	 * 得到正常充值
	 * @return 
	 * @throws ParseException 
	 * */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/getNormalList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getNormalList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		String email = (String) afterMap.get("custEmail");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<IntegralRecharge> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!email.equals("")) {
			wrapper.eq("mem_ident", email);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.eq("recharge_state","正常").orderBy("create_time", false);
		Page<Map<String, Object>> mapsPage = inReSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有正常充值");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	/**
	 * 得到异常充值
	 * @return 
	 * @throws ParseException 
	 * */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/getAbnormalList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getAbnormalList(@RequestBody Map<Object,Object> kwMap) throws ParseException {
		int page = (int) kwMap.get("page");
		int limit = (int) kwMap.get("limit");
		ArrayList<Map> arrayList = new ArrayList<>();
		arrayList = (ArrayList<Map>) kwMap.get("kwdata");
		AnalysisKeyWordsListUtils utils = new AnalysisKeyWordsListUtils();
		HashMap<String, Object> afterMap = utils.analysisKeyWordsList(arrayList);
		String email = (String) afterMap.get("custEmail");
		String start_date = (String) afterMap.get("start_date");
		String end_date = (String) afterMap.get("end_date");
		EntityWrapper<IntegralRecharge> wrapper = new EntityWrapper<>();
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		if(!email.equals("")) {
			wrapper.eq("mem_ident", email);
		}
		if(!start_date.equals("") && !end_date.equals("")) {
			Date startDate = format1.parse(start_date);
			Date endDate = format1.parse(end_date);
			wrapper.between("create_time", startDate, endDate);
		}
		wrapper.eq("recharge_state","异常").orderBy("create_time", false);
		Page<Map<String, Object>> mapsPage = inReSer.selectMapsPage(new Page<>(page, limit), wrapper);
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",0);
		resultMap.put("message","所有异常充值");
		resultMap.put("total",mapsPage.getTotal());
		resultMap.put("data",mapsPage.getRecords());
		return resultMap;
	}
	
	/**
	 * 充值积分
	 * */
	@RequestMapping(value="/rechargeByMen",method=RequestMethod.POST)
	@ResponseBody
	public Msg rechargeByMen(IntegralRecharge iRch) {
		int after = iRch.getPayMoney()*100;
		String ident = iRch.getMemIdent();
		Member member = memSer.selectOne(new EntityWrapper<Member>().eq("m_ident", ident));
		member.setmIntegral(member.getmIntegral()+after);
		iRch.setRechargeIdent(UUIDUtil.createUUID());
		iRch.setAfterIntegral(member.getmIntegral());
		iRch.setRechargeState("正常");
		boolean b = inReSer.insert(iRch);
		if(b) {
			memSer.updateById(member);
			return Msg.success().add("msg", "成功");
		}
		return Msg.fail().add("msg", "失败");
	}
	
	//========================页面跳转============================
	@RequestMapping("/toNormalPage")
	public String toNormalPage() {
		return "/integral/normal-integral";
	}
	@RequestMapping("/toAbnormalPage")
	public String toAbnormalPage() {
		return "/integral/abnormal-integral";
	}
	
}

