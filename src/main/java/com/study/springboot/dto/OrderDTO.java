package com.study.springboot.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class OrderDTO {
	   private int idx;
	   private String o_number;
	   private String o_order;
	   private String o_ordername;
	   private String o_reciver;
	   private String o_title;
	   private String o_state;
	   private int o_count;
	   private int o_price;
	   private String o_dlv_charge;
	   private String o_addr;
	   private String o_phone; 
	   private Date o_date;
	   private int o_point;
	   private int p_total;
	   private String p_filename;
}
