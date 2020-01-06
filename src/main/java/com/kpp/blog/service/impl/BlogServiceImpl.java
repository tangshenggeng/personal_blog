package com.kpp.blog.service.impl;

import com.kpp.blog.beans.Blog;
import com.kpp.blog.mapper.BlogMapper;
import com.kpp.blog.service.BlogService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author KPP
 * @since 2020-01-06
 */
@Service
public class BlogServiceImpl extends ServiceImpl<BlogMapper, Blog> implements BlogService {

}
