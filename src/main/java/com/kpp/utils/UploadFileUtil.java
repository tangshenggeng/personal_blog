package com.kpp.utils;

import java.io.File;
import java.io.InputStream;
import java.util.Date;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class UploadFileUtil {
	// 图片上传
		public  String uploadImgFile(CommonsMultipartFile uploadFile,String savePath) {
			try {
				String filename = uploadFile.getOriginalFilename();
				String substring = filename.substring(filename.lastIndexOf("."));
				if (substring.equals(".jpg") || substring.equals(".png")) {
					long size = uploadFile.getSize();
					if (size > 1048576) {
						return "error";
					}
					long time = new Date().getTime();
					String newName = UUIDUtil.createFiveLength()+time + substring;
					File file = new File(savePath + "/" + newName);
					InputStream inputStream = uploadFile.getInputStream();
					FileUtils.copyInputStreamToFile(inputStream, file);
					if (inputStream != null) {
						inputStream.close();
					}
					return newName;
				}
				return "error";
			} catch (Exception e) {
				e.printStackTrace();
				return "error";
			}
		}
		// 图片上传
		public  String uploadVideoFile(CommonsMultipartFile uploadFile,String savePath) {
			try {
				String filename = uploadFile.getOriginalFilename();
				String substring = filename.substring(filename.lastIndexOf("."));
				if (substring.equals(".mp4") || substring.equals(".m4v")) {
					long size = uploadFile.getSize();
					if (size > 52428800) {
						return "error";
					}
					long time = new Date().getTime();
					String newName = time + substring;
					File file = new File(savePath + "/" + newName);
					InputStream inputStream = uploadFile.getInputStream();
					FileUtils.copyInputStreamToFile(inputStream, file);
					if (inputStream != null) {
						inputStream.close();
					}
					return newName;
				}
				return "error";
			} catch (Exception e) {
				e.printStackTrace();
				return "error";
			}
		}
}
