//20200803
package com.study.springboot.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class Order_Qna_DTO {
    private int idx;
    private int originno;
    private int groupLayer;
    private String o_number;
	private String oq_category;
	private String oq_name;
	private String oq_email;
	private String oq_title;
	private String oq_content;
	private Date oq_date;
    private int groupOrd;
}
