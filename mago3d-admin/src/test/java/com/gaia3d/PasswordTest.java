package com.gaia3d;

import org.junit.Test;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.crypto.bcrypt.BCrypt;

public class PasswordTest {

	@Test
	public void test() {
		String salt = BCrypt.gensalt();
		ShaPasswordEncoder shaPasswordEncoder = new ShaPasswordEncoder(512);
		shaPasswordEncoder.setIterations(1000);
		String encryptPassword = shaPasswordEncoder.encodePassword("test", salt);
		System.out.println("salt = " + salt);
		System.out.println(encryptPassword);
		
		String dbsalt = "test";
		ShaPasswordEncoder dbShaPasswordEncoder = new ShaPasswordEncoder(512);
		dbShaPasswordEncoder.setIterations(1000);
		String dbEncryptPassword = dbShaPasswordEncoder.encodePassword("test", dbsalt);
		System.out.println("salt = " + dbsalt);
		System.out.println("db password = " + dbEncryptPassword);
	}

}
	