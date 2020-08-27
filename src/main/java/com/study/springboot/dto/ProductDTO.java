package com.study.springboot.dto;

import lombok.Data;

@Data
public class ProductDTO {
	private int idx;
	private String p_name;
	private int p_price;
	private int p_discount_ratio;
	private int p_discount_price;
	private String category;
	private int weight;
	private int p_count;
	private String p_content;
	private String special;
	private String p_filename;
}
