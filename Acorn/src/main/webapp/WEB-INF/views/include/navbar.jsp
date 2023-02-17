<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
	<div class="header_inner" style="border : 1px solid #ededed">
		<div class="sm_menu">
			<img src="${pageContext.request.contextPath}/resources/images/hidden_menu.png" alt="" />
		</div>
		<c:choose>
			<c:when test="${ empty sessionScope.id}">
				<a href="${pageContext.request.contextPath}/" class="logo_text">
					<p class="cloud_effect">FOOD CLOUD</p>
				</a>
				<div class="top_menu">
					<div id="simple-list-example" class="top_nav simple-list-example-scrollspy">
						<a href="#simple-list-item-1">TOP</a>
						<a href=${param.thisPage eq "index" ? "#simple-list-item-2" : "../shop/list" } id="category">CATEGORY</a>
						<c:if test="${param.thisPage eq 'index' }">
							<a href="#simple-list-item-3" id="hot_place">HOT PLACE</a>
						</c:if>
						<a href=${param.thisPage eq "index" ? "#simple-list-item-4" : "#" } id="research">RESEARCH</a>
    		    </div>
					<div class="search_menu">
						<div class="search_bar">
							<form action="${pageContext.request.contextPath}/shop/search"
								method="post">
								<div class="search_box">
									<button type="submit" style="display: contents">
										<img class="search_img"
											src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"
											alt="" />
									</button>
									<input class="search_input" type="text" name="keyword"
										value="${keyword}" placeholder="검색어 입력...">
								</div>
							</form>
						</div>
					</div>
					<div class="top_user">
					<a href="${pageContext.request.contextPath}/users/signup_form"  class="sign_up btn btn-outline-success">SIGN-UP</a>
						<a id="login" href="javascript:"  class="login btn btn-outline-dark">LOGIN</a>
					</div>
				</div>
			</c:when>
			<c:when test="${sessionScope.id eq 'admin'}">
				<a href="${pageContext.request.contextPath}/" class="logo_text">
					<p class="cloud_effect">FOOD CLOUD</p>
				</a>
				<div class="top_menu">
						<div id="simple-list-example" class="top_nav simple-list-example-scrollspy">
						<a href="#simple-list-item-1">TOP</a>
						<a href=${param.thisPage eq "index" ? "#simple-list-item-2" : "../shop/list" } id="category">CATEGORY</a>
						<a href=${param.thisPage eq "index" ? "#simple-list-item-3" : "#" } id="hot_place">HOT PLACE</a>
						<a href=${param.thisPage eq "index" ? "#simple-list-item-4" : "#" } id="research">RESEARCH</a>
            </div>
            <div class="search_menu">
              <div class="search_bar">
                <form action="${pageContext.request.contextPath}/shop/search"
                  method="post">
                  <div class="search_box">
                    <button type="submit" style="display: contents">
                      <img class="search_img"
                        src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"
                        alt="" />
                    </button>
                    <input class="search_input" type="text" name="keyword"
                      value="${keyword}" placeholder="검색어 입력...">
                  </div>
                </form>
              </div>
            </div>
			<div class="top_user">
				<a href="${pageContext.request.contextPath}/users/info" class="user_menu rainbow_effect user_menu badge">${sessionScope.id }</a>
				<a id="logout" href="javascript:" class="logout_menu btn btn-outline-danger" style="padding-top:0px;">LOGOUT</a>
			</div>
				</div>
			</c:when>
			<c:otherwise>
				<a href="${pageContext.request.contextPath}/" class="logo_text">
					<p class="cloud_effect">FOOD CLOUD</p>
				</a>
				<div class="top_menu">
					<div id="simple-list-example" class="top_nav simple-list-example-scrollspy">
						<a href="#simple-list-item-1">TOP</a>
						<a href=${param.thisPage eq "index" ? "#simple-list-item-2" : "../shop/list" } id="category">CATEGORY</a>
						<a href=${param.thisPage eq "index" ? "#simple-list-item-3" : "#" } id="hot_place">HOT PLACE</a>
						<a href=${param.thisPage eq "index" ? "#simple-list-item-4" : "#" } id="research">RESEARCH</a>
         			</div>
					<div class="search_menu">
						<div class="search_bar">
     						<form action="${pageContext.request.contextPath}/shop/search"
								method="post">
								<div class="search_box">
									<button type="submit" style="display: contents">
										<img class="search_img"
											src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"
											alt="" />
									</button>
									<input class="search_input" type="text" name="keyword"
										value="${keyword}" placeholder="검색어 입력...">
								</div>
							</form>
						</div>
					</div>
					<div class="top_user">
						<a href="${pageContext.request.contextPath}/users/info" class="user_menu badge text-bg-primary">${sessionScope.id }</a>
						<a id="logout" href="javascript:" class="logout_menu btn btn-outline-danger" style="padding-top:0px;">LOGOUT</a>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<script>
    	let isLogin=${ not empty id };
	    if(!isLogin){
			document.querySelector("#login").addEventListener("click", function(){
				const url = document.location.href;	
				console.log(url);
				var url1 = url.split("/");
				console.log(url1);
				var url2 = "/"+url1[3];
				for(var i = 4; i < url1.length; i++) {
					 url2 = url2+"/"+url1[i];
				}
				console.log(url2);
				
				const encodedUrl = encodeURIComponent(url2);
				console.log(encodedUrl);
				
				
				location.href= "${pageContext.request.contextPath}/users/loginform?url="+url2;
			});
		}else{
			document.querySelector("#logout").addEventListener("click", function(){
			const url = document.location.href;	
			console.log(url);
			var url1 = url.split("/");
			console.log(url1);
			var url2 = "/"+url1[3];
			for(var i = 4; i < url1.length; i++) {
				 url2 = url2+"/"+url1[i];
			}
			console.log(url2);
			
			const encodedUrl = encodeURIComponent(url2);
			console.log(encodedUrl);
			
			
			location.href= "${pageContext.request.contextPath}/users/logout?url="+url2;
			});
		}
    </script>