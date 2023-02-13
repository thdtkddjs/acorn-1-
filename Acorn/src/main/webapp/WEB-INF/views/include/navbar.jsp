<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<div class="header_inner" style="border : 1px solid #ededed">
		<div class="sm_menu">
			<img src="${pageContext.request.contextPath}/resources/images/hidden_menu.png" alt="" />
		</div>
		<c:choose>
			<c:when test="${ empty sessionScope.id}">
				<a href="${pageContext.request.contextPath}" class="logo_text">
					<p class="cloud_effect">FOOD CLOUD</p>
				</a>
				<div class="top_menu">
					<div id="simple-list-example" class="top_nav simple-list-example-scrollspy">
						<a href="${pageContext.request.contextPath}/">HOME</a>
						<a href="#simple-list-item-1" id="category">CATEGORY</a>
						<a href="#simple-list-item-2" id="hot_place">HOT PLACE</a>
						<a href="#simple-list-item-3" id="research">RESEARCH</a>
    		    </div>
					<div class="search_menu">
						<div class="search_bar">
							<form action="${pageContext.request.contextPath}/index/"
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
				<a href="${pageContext.request.contextPath}" class="logo_text">
					<p class="cloud_effect">FOOD CLOUD</p>
				</a>
				<div class="top_menu">
						<div id="simple-list-example" class="top_nav simple-list-example-scrollspy">
						<a href="${pageContext.request.contextPath}/">HOME</a>
						<a href="#simple-list-item-1" id="category">CATEGORY</a>
						<a href="#simple-list-item-2" id="hot_place">HOT PLACE</a>
						<a href="#simple-list-item-3" id="research">RESEARCH</a>
            </div>
            <div class="search_menu">
              <div class="search_bar">
                <form action="${pageContext.request.contextPath}/index/"
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
				<a href="${pageContext.request.contextPath}" class="logo_text">
					<p class="cloud_effect">FOOD CLOUD</p>
				</a>
				<div class="top_menu">
					<div id="simple-list-example" class="top_nav simple-list-example-scrollspy">
						<a href="${pageContext.request.contextPath}/">HOME</a>
						<a href="#simple-list-item-1" id="category">CATEGORY</a>
						<a href="#simple-list-item-2" id="hot_place">HOT PLACE</a>
						<a href="#simple-list-item-3" id="research">RESEARCH</a>
         			</div>
					<div class="search_menu">
						<div class="search_bar">
							<form action="${pageContext.request.contextPath}/index/"
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