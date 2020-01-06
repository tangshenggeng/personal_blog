package com.kpp.blog.beans;

import com.baomidou.mybatisplus.enums.IdType;
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
 * @since 2020-01-06
 */
@TableName("tb_blog_label")
public class BlogLabel extends Model<BlogLabel> {

    private static final long serialVersionUID = 1L;

    /**
     * 标签id
     */
    @TableId(value = "label_id", type = IdType.AUTO)
    private Integer labelId;
    /**
     * 标签唯一标识
     */
    private String labelIdent;
    /**
     * 标签名
     */
    private String labelName;
    /**
     * 包含的博客数量
     */
    private Integer blogNum;


    public Integer getLabelId() {
        return labelId;
    }

    public void setLabelId(Integer labelId) {
        this.labelId = labelId;
    }

    public String getLabelIdent() {
        return labelIdent;
    }

    public void setLabelIdent(String labelIdent) {
        this.labelIdent = labelIdent;
    }

    public Integer getBlogNum() {
        return blogNum;
    }

    public void setBlogNum(Integer blogNum) {
        this.blogNum = blogNum;
    }

    @Override
    protected Serializable pkVal() {
        return this.labelId;
    }

	public String getLabelName() {
		return labelName;
	}

	public void setLabelName(String labelName) {
		this.labelName = labelName;
	}

	@Override
	public String toString() {
		return "BlogLabel [labelId=" + labelId + ", labelIdent=" + labelIdent + ", labelName=" + labelName
				+ ", blogNum=" + blogNum + "]";
	}

}
