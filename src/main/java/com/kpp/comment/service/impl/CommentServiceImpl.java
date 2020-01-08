package com.kpp.comment.service.impl;

import com.kpp.comment.beans.Comment;
import com.kpp.comment.mapper.CommentMapper;
import com.kpp.comment.service.CommentService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author KPP
 * @since 2020-01-08
 */
@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements CommentService {

}
