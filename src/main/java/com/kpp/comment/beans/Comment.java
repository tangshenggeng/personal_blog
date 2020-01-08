package com.kpp.comment.beans;

import com.baomidou.mybatisplus.enums.FieldFill;
import com.baomidou.mybatisplus.enums.IdType;
import java.util.Date;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableLogic;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author KPP
 * @since 2020-01-08
 */
@TableName("tb_comment")
public class Comment extends Model<Comment> {

    private static final long serialVersionUID = 1L;

    /**
     * 评论id
     */
    @TableId(value = "comment_id", type = IdType.AUTO)
    private Integer commentId;
    /**
     * 评论标识
     */
    private String commentIdent;
    /**
     * 评论人标识
     */
    private String memIdent;
    /**
     * 评论人昵称
     */
    private String memNick;
    /**
     * 博客
     */
    private String blogIdent;
    /**
     * 内容
     */
    private String commentText;
    /**
     * 回复
     */
    private String replyText;
    /**
     * 时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;
    /**
     * 假删除
     */
    @TableField(fill = FieldFill.INSERT)
    @TableLogic
    private Integer isDel;

   
    	
    public Integer getCommentId() {
        return commentId;
    }

    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
    }

    public String getCommentIdent() {
        return commentIdent;
    }

    public void setCommentIdent(String commentIdent) {
        this.commentIdent = commentIdent;
    }

    public String getMemIdent() {
        return memIdent;
    }

    public void setMemIdent(String memIdent) {
        this.memIdent = memIdent;
    }

    public String getMemNick() {
        return memNick;
    }

    public void setMemNick(String memNick) {
        this.memNick = memNick;
    }

    public String getBlogIdent() {
        return blogIdent;
    }

    public void setBlogIdent(String blogIdent) {
        this.blogIdent = blogIdent;
    }

    public String getCommentText() {
        return commentText;
    }

    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }

    public String getReplyText() {
        return replyText;
    }

    public void setReplyText(String replyText) {
        this.replyText = replyText;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getIsDel() {
        return isDel;
    }

    public void setIsDel(Integer isDel) {
        this.isDel = isDel;
    }

    @Override
    protected Serializable pkVal() {
        return this.commentId;
    }

	@Override
	public String toString() {
		return "Comment [commentId=" + commentId + ", commentIdent=" + commentIdent + ", memIdent=" + memIdent
				+ ", memNick=" + memNick + ", blogIdent=" + blogIdent + ", commentText=" + commentText + ", replyText="
				+ replyText + ", createTime=" + createTime + ", isDel=" + isDel + "]";
	}
}
