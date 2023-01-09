package com.gura.acorn.shop.dto;

import org.apache.ibatis.type.Alias;

@Alias("shopReviewDto")
public class ShopReviewDto {
	private int num;
	private String writer;
	private String content;
	private String target_id;
	private int ref_group;
	private int review_group;
	private String deleted;
	private String grade; //필요 시 다른테이블 dto로 이동
	private String regdate;
	private String profile;
	private int startRowNum;
	private int endRowNum;
	
	public ShopReviewDto() {}

	public ShopReviewDto(int num, String writer, String content, String target_id, int ref_group, int review_group,
			String deleted, String grade, String regdate, String profile, int startRowNum, int endRowNum) {
		super();
		this.num = num;
		this.writer = writer;
		this.content = content;
		this.target_id = target_id;
		this.ref_group = ref_group;
		this.review_group = review_group;
		this.deleted = deleted;
		this.grade = grade;
		this.regdate = regdate;
		this.profile = profile;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTarget_id() {
		return target_id;
	}

	public void setTarget_id(String target_id) {
		this.target_id = target_id;
	}

	public int getRef_group() {
		return ref_group;
	}

	public void setRef_group(int ref_group) {
		this.ref_group = ref_group;
	}

	public int getReview_group() {
		return review_group;
	}

	public void setReview_group(int review_group) {
		this.review_group = review_group;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public int getStartRowNum() {
		return startRowNum;
	}

	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}

	public int getEndRowNum() {
		return endRowNum;
	}

	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}
}
