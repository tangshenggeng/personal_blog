package com.kpp.blog.beans;

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
 * @since 2020-01-06
 */
@TableName("tb_blog")
public class Blog extends Model<Blog> {

    private static final long serialVersionUID = 1L;

    /**
     * 博客id
     */
    @TableId(value = "blog_id", type = IdType.AUTO)
    private Integer blogId;
    /**
     * 唯一标识
     */
    private String blogIdent;
    /**
     * 博客标题
     */
    private String blogTitle;
    /**
     * 标签唯一标识
     */
    private String blogLabel;
    /**
     * 内容
     */
    private String blogText;
    /**
     * 查看次数
     */
    private Integer blogLook;
    /**
     * 需要的积分
     */
    private Integer needIntegral;
    /**
     * 评论次数
     */
    private Integer commetNum;
    /**
     * 状态（展示or隐藏）
     */
    private String blogState;
    /**
     * 写作时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;
    /**
     * 假删除
     */
    @TableField(fill = FieldFill.INSERT)
    @TableLogic
    private Integer isDel;

    @TableField(exist=false)
    private String filepath;
    
    @TableField(exist=false)
    private String imgpath;
    

    public Integer getBlogId() {
        return blogId;
    }

    public void setBlogId(Integer blogId) {
        this.blogId = blogId;
    }

    public String getBlogIdent() {
        return blogIdent;
    }

    public void setBlogIdent(String blogIdent) {
        this.blogIdent = blogIdent;
    }

    public String getBlogTitle() {
        return blogTitle;
    }

    public void setBlogTitle(String blogTitle) {
        this.blogTitle = blogTitle;
    }

    public String getBlogLabel() {
        return blogLabel;
    }

    public void setBlogLabel(String blogLabel) {
        this.blogLabel = blogLabel;
    }

    public String getBlogText() {
        return blogText;
    }

    public void setBlogText(String blogText) {
        this.blogText = blogText;
    }

    public Integer getBlogLook() {
        return blogLook;
    }

    public void setBlogLook(Integer blogLook) {
        this.blogLook = blogLook;
    }

    public Integer getNeedIntegral() {
        return needIntegral;
    }

    public void setNeedIntegral(Integer needIntegral) {
        this.needIntegral = needIntegral;
    }

    public Integer getCommetNum() {
        return commetNum;
    }

    public void setCommetNum(Integer commetNum) {
        this.commetNum = commetNum;
    }

    public String getBlogState() {
        return blogState;
    }

    public void setBlogState(String blogState) {
        this.blogState = blogState;
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
        return this.blogId;
    }

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

	public String getImgpath() {
		return imgpath;
	}

	public void setImgpath(String imgpath) {
		this.imgpath = imgpath;
	}

	@Override
	public String toString() {
		return "Blog [blogId=" + blogId + ", blogIdent=" + blogIdent + ", blogTitle=" + blogTitle + ", blogLabel="
				+ blogLabel + ", blogText=" + blogText + ", blogLook=" + blogLook + ", needIntegral=" + needIntegral
				+ ", commetNum=" + commetNum + ", blogState=" + blogState + ", createTime=" + createTime + ", isDel="
				+ isDel + ", filepath=" + filepath + ", imgpath=" + imgpath + "]";
	}

    
}
