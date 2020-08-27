package com.study.springboot.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class PointDTO {
	private int idx;
	private String p_email;
	private int get_point;
	private int use_point;
	private int remain_point;
	private Date p_date;
}
