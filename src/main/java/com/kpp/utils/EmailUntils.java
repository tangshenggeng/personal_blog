package com.kpp.utils;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

public class EmailUntils {

	private static final String hostName = "smtp.qq.com";
    private static final String userInfo = "dmvfubeyzanbbich"; //服务器验证码 -- 非发件人邮箱密码
    
    private static final String chartset = "UTF-8";
    //发件人
    private static final String senderEmail = "wuyetianyi@qq.com";
    //发件人昵称
    private static final String senderNick = "KPP个人博客";
    //主题
    private static final String emailSubject = "来自“KPP个人博客”的通知";
    
    /**
     * 邮件发送工具类(单个)
     * 
     * */
    public static boolean sendEmail(String receive ,String code) {
        try {
            HtmlEmail email = new HtmlEmail();
            // 配置信息
            email.setHostName(hostName);
            email.setFrom(senderEmail,senderNick);
            email.setAuthentication(senderEmail,userInfo);
            email.setCharset(chartset);
            email.setSubject(emailSubject);
            String sendHtml = "尊敬的客户您好！<hr>【KPP个人博客】激活码为：<span style='color:blue;'>"+code+"</span>，本激活码的有效时间为5分钟，请勿告知他人！";
            email.setHtmlMsg(sendHtml);
            // 收件人
            if (null != receive) {
               email.addTo(receive);
            }
            //发送
            try {
				email.send();
				return true;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
            
        } catch (EmailException e) {
            e.printStackTrace();
            return false;
        } 
    }
   
   
}

