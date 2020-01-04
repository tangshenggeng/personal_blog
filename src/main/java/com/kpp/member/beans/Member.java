package com.kpp.member.beans;

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
 * @since 2020-01-04
 */
@TableName("tb_member")
public class Member extends Model<Member> {

    private static final long serialVersionUID = 1L;

    /**
     * 客户的id
     */
    @TableId(value = "member_id", type = IdType.AUTO)
    private Integer memberId;
    /**
     * 唯一标识
     */
    private String mIdent;
    /**
     * 昵称
     */
    private String mNick;
    /**
     * 注册邮箱
     */
    private String mEmail;
    /**
     * 密码
     */
    private String mPassword;
    /**
     * 签名
     */
    private String mAutograph;
    /**
     * 头像路径
     */
    private String mHeader;
    /**
     * 积分
     */
    private Integer mIntegral;
    /**
     * 账号状态（异常or正常）
     */
    private String mState;
    /**
     * 注册时间
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
    private String formPwd1;
    
    @TableField(exist=false)
    private String formPwd2;
    
    @TableField(exist=false)
    private String formCode;

    public Integer getMemberId() {
        return memberId;
    }

    public void setMemberId(Integer memberId) {
        this.memberId = memberId;
    }

    public String getmIdent() {
        return mIdent;
    }

    public void setmIdent(String mIdent) {
        this.mIdent = mIdent;
    }

    public String getmNick() {
        return mNick;
    }

    public void setmNick(String mNick) {
        this.mNick = mNick;
    }

    public String getmEmail() {
        return mEmail;
    }

    public void setmEmail(String mEmail) {
        this.mEmail = mEmail;
    }

    public String getmPassword() {
        return mPassword;
    }

    public void setmPassword(String mPassword) {
        this.mPassword = mPassword;
    }

    public String getmAutograph() {
        return mAutograph;
    }

    public void setmAutograph(String mAutograph) {
        this.mAutograph = mAutograph;
    }

    public String getmHeader() {
        return mHeader;
    }

    public void setmHeader(String mHeader) {
        this.mHeader = mHeader;
    }

    public Integer getmIntegral() {
        return mIntegral;
    }

    public void setmIntegral(Integer mIntegral) {
        this.mIntegral = mIntegral;
    }

    public String getmState() {
        return mState;
    }

    public void setmState(String mState) {
        this.mState = mState;
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
        return this.memberId;
    }

	public String getFormPwd1() {
		return formPwd1;
	}

	public void setFormPwd1(String formPwd1) {
		this.formPwd1 = formPwd1;
	}

	public String getFormPwd2() {
		return formPwd2;
	}

	public void setFormPwd2(String formPwd2) {
		this.formPwd2 = formPwd2;
	}

	public String getFormCode() {
		return formCode;
	}

	public void setFormCode(String formCode) {
		this.formCode = formCode;
	}

	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", mIdent=" + mIdent + ", mNick=" + mNick + ", mEmail=" + mEmail
				+ ", mPassword=" + mPassword + ", mAutograph=" + mAutograph + ", mHeader=" + mHeader + ", mIntegral="
				+ mIntegral + ", mState=" + mState + ", createTime=" + createTime + ", isDel=" + isDel + ", formPwd1="
				+ formPwd1 + ", formPwd2=" + formPwd2 + ", formCode=" + formCode + "]";
	}

}
