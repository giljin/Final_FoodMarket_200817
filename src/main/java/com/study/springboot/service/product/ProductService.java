package com.study.springboot.service.product;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IProductDAO;
import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.ProductDTO;

@Service
public class ProductService implements IProductService{

	@Autowired
	IProductDAO P_dao;
	
	@Override
	public ProductDTO viewProduct(String idx) {
		return P_dao.viewProductDao( idx );
	}

	@Override
	public ProductDTO sepcialProduct() {
		return P_dao.specialProductDao();
	}

	@Override
	public List<ProductDTO> searchProductDao(String p_name) {
		return P_dao.searchProductDao( p_name );
	}

	@Override
	public List<ProductDTO> categoryProduct(String category) {
		return P_dao.categoryProductDao( category );
	}
	
	@Override
	   public int writeProduct(Map<String, String> map) {
	      return P_dao.writeProductDao(map);
	   }

	   @Override
	   public List<ProductDTO> listProduct(Criteria cri) {
	      return P_dao.listProductDao(cri);
	   }

	   @Override
	   public int ProductCount() {
	      return P_dao.articleProductCount();
	   }

	   @Override
	   public List<ProductDTO> searchProductManagement(Map<String, String> map, Criteria cri) {
	      String attr = map.get("attribute");
	      System.out.println( attr );
	      if( attr.equals("상품명") ) {
	         attr = "P_NAME";
	      }else if( attr.equals("상품코드") ) {
	         attr = "IDX";
	      }
	      
	      String param = map.get("param");
	      String category = map.get("category");
	      String query = "";
	      if( param==null || param=="" ) {
	         if( category!=null ) {
	            query = "WHERE category = '"+ category + "'";
	         }
	      }else {
	         if( category!=null ) {
	            query = "WHERE " + attr + " = '" + param + "' AND category = '"+ category + "'";
	         }else {
	            query = "WHERE " + attr + " = '" + param + "'";
	         }
	      }
	      
	      System.out.println(query);
	      map.put("query", query);
	      cri.setMap(map);
	      
	      return P_dao.searchProductManagementDao(cri);
	   }

	   @Override
	   public int deleteProductDao(String idx) {
	      return P_dao.deleteProductDao(idx);
	   }

	   @Override
	   public int updateProduct(Map<String, String> map) {
	      return P_dao.updateProductDao(map);
	   }

	   @Override
	   public int specialUpdate(String special, String idx) {
	      return P_dao.specialUpdateDao(special, idx);
	   }
	   
	   @Override
	   public ProductDTO findProduct(String p_name) {
	      return P_dao.findProductDao(p_name);
	   }
}
