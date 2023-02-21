package com.gura.acorn.es;

public class ESTestDto {
	private String date;
	private String address;
	private String user;
	
	public ESTestDto() {}

	public ESTestDto(String date, String address, String user) {
		super();
		this.date = date;
		this.address = address;
		this.user = user;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}
}
