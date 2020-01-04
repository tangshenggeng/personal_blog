package com.kpp.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.util.StringUtils;





public class ExamineChinese {
	/**
	 * @param str 待校验字符串
     * @return true 包含中文字符  false 不包含中文字符
     * @throws EmptyException
	 * */
	public static boolean isContainChinese(String str) {
		 
        if (StringUtils.isEmpty(str)) {
            return false;
        }
        Pattern p = Pattern.compile("[\u4E00-\u9FA5|\\！|\\，|\\。|\\（|\\）|\\《|\\》|\\“|\\”|\\？|\\：|\\；|\\【|\\】]");
        Matcher m = p.matcher(str);
        if (m.find()) {
            return true;
        }
        return false;
    }

}
