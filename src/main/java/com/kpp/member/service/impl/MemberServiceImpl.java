package com.kpp.member.service.impl;

import com.kpp.member.beans.Member;
import com.kpp.member.mapper.MemberMapper;
import com.kpp.member.service.MemberService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author KPP
 * @since 2020-01-04
 */
@Service
public class MemberServiceImpl extends ServiceImpl<MemberMapper, Member> implements MemberService {

}
