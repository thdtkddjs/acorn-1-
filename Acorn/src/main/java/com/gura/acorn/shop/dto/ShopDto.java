package com.gura.acorn.shop.dto;

import org.apache.ibatis.type.Alias;

@Alias("shopDto")
public class ShopDto {
	   private int num;
	   private String title;
	   private String content;
	   private String imagePath;
	   private String categorie;
	   private int reviewCount;
	   private int likeCount;
	   private int dislikeCount;
	   private String telNum;
	   private String addr;
	   private double latitude;
	   private double longitude;
	   private int startRowNum;
	   private int endRowNum;
	   
	   public ShopDto() {}

	public ShopDto(int num, String title, String content, String imagePath, String categorie, int reviewCount,
			int likeCount, int dislikeCount, String telNum, String addr, double latitude, double longitude,
			int startRowNum, int endRowNum) {
		super();
		this.num = num;
		this.title = title;
		this.content = content;
		this.imagePath = imagePath;
		this.categorie = categorie;
		this.reviewCount = reviewCount;
		this.likeCount = likeCount;
		this.dislikeCount = dislikeCount;
		this.telNum = telNum;
		this.addr = addr;
		this.latitude = latitude;
		this.longitude = longitude;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getCategorie() {
		return categorie;
	}

	public void setCategorie(String categorie) {
		this.categorie = categorie;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public int getDislikeCount() {
		return dislikeCount;
	}

	public void setDislikeCount(int dislikeCount) {
		this.dislikeCount = dislikeCount;
	}

	public String getTelNum() {
		return telNum;
	}

	public void setTelNum(String telNum) {
		this.telNum = telNum;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
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
