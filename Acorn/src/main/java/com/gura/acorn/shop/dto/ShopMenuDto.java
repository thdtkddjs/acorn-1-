package com.gura.acorn.shop.dto;

import org.apache.ibatis.type.Alias;

@Alias("shopMenuDto")
public class ShopMenuDto {
	   private int num;
	   private int menuNum;
	   private String name;
	   private int price;
	   private String content;
	   private String imagePath;
	   private int startRowNum;
	   private int endRowNum;
	   
	   public ShopMenuDto() {}
	   
		public ShopMenuDto(int num, int menuNum, String name, int price, String content, String imagePath, int startRowNum,
				int endRowNum) {
			super();
			this.num = num;
			this.menuNum = menuNum;
			this.name = name;
			this.price = price;
			this.content = content;
			this.imagePath = imagePath;
			this.startRowNum = startRowNum;
			this.endRowNum = endRowNum;
		}

		public int getNum() {
			return num;
		}

		public void setNum(int num) {
			this.num = num;
		}

		public int getMenuNum() {
			return menuNum;
		}

		public void setMenuNum(int menuNum) {
			this.menuNum = menuNum;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public int getPrice() {
			return price;
		}

		public void setPrice(int price) {
			this.price = price;
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
