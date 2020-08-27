package com.study.springboot.service.product;

import java.util.List;
import java.util.Map;

import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.ProductDTO;

public interface IProductService {
	
	public ProductDTO viewProduct(String idx);
	public ProductDTO sepcialProduct();
	public List<ProductDTO> searchProductDao(String p_name);
	public List<ProductDTO> categoryProduct(String category);
	
	public List<ProductDTO> listProduct(Criteria cri);
	public List<ProductDTO> searchProductManagement(Map<String, String> map, Criteria cri);
	public int specialUpdate(String special, String idx);
	public int writeProduct(Map<String, String> map);
	public int updateProduct(Map<String, String> map);
	public int deleteProductDao(String idx);
	public int ProductCount();
	public ProductDTO findProduct(String p_name);
}
