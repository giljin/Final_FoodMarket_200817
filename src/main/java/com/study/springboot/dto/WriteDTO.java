package com.study.springboot.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class WriteDTO {
	private int idx;
	private String w_title;
	private String w_email;
	private int w_grade;
	private String w_content;
	private Date w_date;
	private String w_filename;
	private int o_idx;
	
}
