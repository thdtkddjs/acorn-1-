<%@page import="com.gura.acorn.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	boolean isExist = (Boolean)request.getAttribute("isExist");
%>    
<%if(!isExist){ %>
	{"isExist" : false}
<%}else{ %>
	{"isExist" : true}
<%} %>