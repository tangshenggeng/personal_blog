package com.kpp.member.beans;

import com.baomidou.mybatisplus.enums.FieldFill;
import com.baomidou.mybatisplus.enums.IdType;
import java.util.Date;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
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
@TableName("tb_blog_collection")
public class BlogCollection extends Model<BlogCollection> {

    private static final long serialVersionUID = 1L;

    /**
     * 收藏id
     */
    @TableId(value = "collection_id", type = IdType.AUTO)
    private Integer collectionId;
    /**
     * 博客的id
     */
    private String blogIdnet;
    /**
     * 客户的id
     */
    private String memIdent;
    /**
     * 收藏时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;


    public Integer getCollectionId() {
        return collectionId;
    }

    public void setCollectionId(Integer collectionId) {
        this.collectionId = collectionId;
    }

    public String getBlogIdnet() {
        return blogIdnet;
    }

    public void setBlogIdnet(String blogIdnet) {
        this.blogIdnet = blogIdnet;
    }

    public String getMemIdent() {
        return memIdent;
    }

    public void setMemIdent(String memIdent) {
        this.memIdent = memIdent;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    protected Serializable pkVal() {
        return this.collectionId;
    }

    @Override
    public String toString() {
        return "BlogCollection{" +
        ", collectionId=" + collectionId +
        ", blogIdnet=" + blogIdnet +
        ", memIdent=" + memIdent +
        ", createTime=" + createTime +
        "}";
    }
}
