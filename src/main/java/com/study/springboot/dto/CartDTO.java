package com.study.springboot.dto;

import lombok.Data;

@Data
public class CartDTO {
	   private int cart_num;
	   private int user_idx;
	   private int product_idx;
	   private int product_count;
}
