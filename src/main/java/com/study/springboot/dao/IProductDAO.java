package com.study.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.ProductDTO;

@Mapper
public interface IProductDAO {
	public List<ProductDTO> listProductDao(Criteria cri);
    public ProductDTO viewProductDao(String idx);
    public ProductDTO specialProductDao();
    public List<ProductDTO> searchProductDao(String p_name);
    public List<ProductDTO> categoryProductDao(String category);
    public int writeProductDao(Map<String, String> map);
    public int deleteProductDao(@Param("id") String idx);
    public int updateProductDao(Map<String, String> map);
    public int articleProductCount();
    public int specialUpdateDao(String special, String idx);
    public List<ProductDTO> searchProductManagementDao(Criteria cri);
    public ProductDTO findProductDao(String p_name);

}
