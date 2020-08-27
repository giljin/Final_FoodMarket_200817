package com.study.springboot.domain;

import java.util.Map;

public class Criteria {
	private String u_email;
	private String o_number;
	private int page;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;
	private String attrubute;
	private String param;
	private String query;

	public void setMap(Map<String, String> map) {
		this.setAttrubute(map.get("attribute"));
		this.setParam(map.get("param"));
		this.setQuery(map.get("query"));
	}

	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}

	public void setU_email(String u_email) {
		this.u_email = u_email;
	}

	public String getO_number() {
		return o_number;
	}

	public void setO_number(String o_number) {
		this.o_number = o_number;
	}

	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	public int getPage() {
		return page;
	}

	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + "" + ", rowStart=" + getRowStart()
				+ ", rowEnd=" + getRowEnd() + ", email=" + u_email + "]";
	}

	public int getRowStart() {
		rowStart = ((page - 1) * perPageNum) + 1;
		return rowStart;
	}

	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public String getQuery() {
		return query;
	}

	public void setQuery(String query) {
		this.query = query;
	}

	public String getAttrubute() {
		return attrubute;
	}

	public void setAttrubute(String attrubute) {
		this.attrubute = attrubute;
	}

}
