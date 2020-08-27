package com.study.springboot.dto;

import lombok.Data;

@Data
public class MemberDTO {
	private int idx;
	private String u_email;
	private String u_pw;
	private String u_name;
	private String u_phone;
	private String u_address;
	private int u_point;

}
