<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup_form.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<style>
.container{
	width : 624px;
	height : 600px;
	box-shadow: 0px 5px 20px 0px grey;
	margin-top : 150px;
	border-radius : 20px;
	padding-top : 50px;
}
h1{
	text-align : center;
}
.submit_btn{
	width : 100px;
}
.form-control{
	width : 400px;
	margin-left:100px;
	
}
</style>
<body class="text-center">
	<div class="container">
		<a href="${pageContext.request.contextPath}/index" class="logo_text">
			<img class="logo" src="${pageContext.request.contextPath}/resources/images/1_acorn_logo.png" alt="" />
		</a>		
	    <h1>SIGN-UP</h1>
	    <form action="${pageContext.request.contextPath}/users/signup" method="post" id="myForm">
	      <div>
	         <label class="control-label" for="id">ID</label>
	         <input class="form-control" type="text" name="id" id="id"/>      
	      </div>
	      <div>
	         <label class="control-label" for="pwd">PASSWORD</label>
	         <input class="form-control" type="password" name="pwd" id="pwd"/>   
	      </div>
	      <div>
	         <label class="control-label" for="pwd2">PASSWORD CONFIRM</label>
	         <input class="form-control" type="password" name="pwd2" id="pwd2"/>
	      </div>
	      <div>
	         <label class="control-label" for="email">E-MAIL</label>
	         <input class="form-control" type="text" name="email" id="email"/>
	      </div>
	      <button class="submit_btn btn btn-primary" type="submit">SIGN-UP</button>
	   </form>
	</div>   
<script>
	$("#email").on("input", function(){
	    $(this).removeClass("is-valid is-invalid");
    	const inputEmail=$(this).val();
    	const reg=/@/;
    
    	if(!reg.test(inputEmail)){
        	$(this).addClass("is-invalid");
        	isEmailValid=false;
     	}else{
        	$(this).addClass("is-valid");
        	isEmailValid=true;
     	}
  	});
    
    $("#signupForm").on("submit", function(){
        const isFormValid = isEmailValid;
        if(!isFormValid){
           return false;
        }
     });
</script>
</body>
</html>