package com.gaia3d.parser;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.junit.Test;

import com.gaia3d.domain.DataAttributeFilter;

public class DataAttributeFileJsonParser {

	@Test
	public void test() throws Exception {
		String attributeDir = "D:\\mago3d\\data\\attribute\\";
		
		File attributeDirFile = new File(attributeDir);
		if(!attributeDirFile.exists()) {
			System.out.println("디렉토리가 존재하지 않습니다.");
			return;
		}
		
		File[] fileList = attributeDirFile.listFiles(new DataAttributeFilter());
		for(File file : fileList) {
			// 1 data_key 를 가지고 정보를 조회
			// attribute table 조회
			// insert or update
			
			String fileName = file.getName();
			System.out.println("@@@@@@@@@@@@@@@ fileName = " + fileName);
			int startIndex = fileName.indexOf("F4D_");
			int endIndex = fileName.toLowerCase().indexOf("_attribute");
			String dataKey = fileName.substring(startIndex + 4, endIndex);
			System.out.println("@@@@@@@@@@@@@@@ dataKey = " + dataKey);
			
			byte[] jsonData = Files.readAllBytes(Paths.get(file.getAbsolutePath()));
			String attribute = new String(jsonData);
			
			System.out.println("@@@@@@@@@@@@@ attribute = " + attribute);
		}
	}
}
