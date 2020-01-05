package com.kpp.integralRecharge.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.kpp.integralRecharge.beans.IntegralRecharge;
import com.kpp.integralRecharge.service.IntegralRechargeService;
import com.kpp.member.beans.Member;
import com.kpp.member.service.MemberService;
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
	
}

