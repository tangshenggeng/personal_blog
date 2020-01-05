package com.kpp.integralRecharge.beans;

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
 * @since 2020-01-05
 */
@TableName("tb_integral_recharge")
public class IntegralRecharge extends Model<IntegralRecharge> {

    private static final long serialVersionUID = 1L;

    /**
     * 积分流动id
     */
    @TableId(value = "recharge_id", type = IdType.AUTO)
    private Integer rechargeId;
    /**
     * 流动标识
     */
    private String rechargeIdent;
    /**
     * 流动状态（正常or异常）
     */
    private String rechargeState;
    /**
     * 客户唯一标识
     */
    private String memIdent;
    /**
     * 充值之前的积分
     */
    private Integer beforeIntegral;
    /**
     * 支付的金额
     */
    private Integer payMoney;
    /**
     * 充值之后的积分
     */
    private Integer afterIntegral;
    /**
     * 时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;
    /**
     * 是否删除
     */
    @TableField(fill = FieldFill.INSERT)
    @TableLogic
    private Integer isDel;


    public Integer getRechargeId() {
        return rechargeId;
    }

    public void setRechargeId(Integer rechargeId) {
        this.rechargeId = rechargeId;
    }

    public String getRechargeIdent() {
        return rechargeIdent;
    }

    public void setRechargeIdent(String rechargeIdent) {
        this.rechargeIdent = rechargeIdent;
    }

    public String getRechargeState() {
        return rechargeState;
    }

    public void setRechargeState(String rechargeState) {
        this.rechargeState = rechargeState;
    }

    public String getMemIdent() {
        return memIdent;
    }

    public void setMemIdent(String memIdent) {
        this.memIdent = memIdent;
    }

    public Integer getBeforeIntegral() {
        return beforeIntegral;
    }

    public void setBeforeIntegral(Integer beforeIntegral) {
        this.beforeIntegral = beforeIntegral;
    }

    public Integer getPayMoney() {
        return payMoney;
    }

    public void setPayMoney(Integer payMoney) {
        this.payMoney = payMoney;
    }

    public Integer getAfterIntegral() {
        return afterIntegral;
    }

    public void setAfterIntegral(Integer afterIntegral) {
        this.afterIntegral = afterIntegral;
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
        return this.rechargeId;
    }

    @Override
    public String toString() {
        return "IntegralRecharge{" +
        ", rechargeId=" + rechargeId +
        ", rechargeIdent=" + rechargeIdent +
        ", rechargeState=" + rechargeState +
        ", memIdent=" + memIdent +
        ", beforeIntegral=" + beforeIntegral +
        ", payMoney=" + payMoney +
        ", afterIntegral=" + afterIntegral +
        ", createTime=" + createTime +
        ", isDel=" + isDel +
        "}";
    }
}
