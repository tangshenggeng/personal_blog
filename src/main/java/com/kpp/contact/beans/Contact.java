package com.kpp.contact.beans;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableLogic;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.FieldFill;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * <p>
 * 
 * </p>
 *
 * @author KPP
 * @since 2019-12-28
 */
@TableName("tb_contact")
public class Contact extends Model<Contact> {

    private static final long serialVersionUID = 1L;

    /**
     * 联系我们id
     */
    @TableId(value = "contact_id", type = IdType.AUTO)
    private Integer contactId;
    /**
     * 称呼
     */
    private String contactName;
    /**
     * 邮箱
     */
    private String contactEmail;
    /**
     * 电话
     */
    private String contactPhone;
    /**
     * 类型
     */
    private String contactSort;
    /**
     * 内容
     */
    private String contactMessage;
    /**
     * 留言时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;
    /**
     * 是否删除
     */
    @TableField(fill = FieldFill.INSERT)
    @TableLogic
    private Integer isDel;


    public Integer getContactId() {
        return contactId;
    }

    public void setContactId(Integer contactId) {
        this.contactId = contactId;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getContactEmail() {
        return contactEmail;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getContactSort() {
        return contactSort;
    }

    public void setContactSort(String contactSort) {
        this.contactSort = contactSort;
    }

    public String getContactMessage() {
        return contactMessage;
    }

    public void setContactMessage(String contactMessage) {
        this.contactMessage = contactMessage;
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
        return this.contactId;
    }

    @Override
    public String toString() {
        return "Contact{" +
        ", contactId=" + contactId +
        ", contactName=" + contactName +
        ", contactEmail=" + contactEmail +
        ", contactPhone=" + contactPhone +
        ", contactSort=" + contactSort +
        ", contactMessage=" + contactMessage +
        ", createTime=" + createTime +
        ", isDel=" + isDel +
        "}";
    }
}
