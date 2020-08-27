package com.study.springboot.dto;

import java.sql.Date;

import lombok.Data;

//20200731
@Data
public class Product_Qna_DTO {
    /** 글 번호 **/
    private int idx;

    /** 글 카테고리 **/
    private String q_category = "";
    
    /** 상품명 **/
    private String p_name = "";
    
    /** 글 작성자 아이디 **/
    private String q_email = "";
    
    /** 글 작성자 **/
    private String q_name = "";
    
    /** 글 제목 **/
    private String q_title= "";
    
    /** 글 내용 **/
    private String q_content = "";

    /** 등록시간 **/
    private Date q_date;
    
    /*
     * 계층형 게시판을 위한 추가 필드
     * originNo, groupOrd, groupLayer 
     */
    
    /** 원글 번호 **/
    private int originNo;
 
    /** 답글 계층 **/
    private int groupLayer;
    
    private int groupOrd;
}
