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
@TableName("tb_blog_buy")
public class BlogBuy extends Model<BlogBuy> {

    private static final long serialVersionUID = 1L;

    /**
     * 购买id
     */
    @TableId(value = "buy_id", type = IdType.AUTO)
    private Integer buyId;
    /**
     * 博客标识
     */
    private String blogIdent;
    /**
     * 客户标识
     */
    private String memIdent;
    /**
     * 购买时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;


    public Integer getBuyId() {
        return buyId;
    }

    public void setBuyId(Integer buyId) {
        this.buyId = buyId;
    }

    public String getBlogIdent() {
        return blogIdent;
    }

    public void setBlogIdent(String blogIdent) {
        this.blogIdent = blogIdent;
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
        return this.buyId;
    }

    @Override
    public String toString() {
        return "BlogBuy{" +
        ", buyId=" + buyId +
        ", blogIdent=" + blogIdent +
        ", memIdent=" + memIdent +
        ", createTime=" + createTime +
        "}";
    }
}
