<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:import url="header.jsp">
<c:param name="title" value="Critique U - Log In"></c:param>
</c:import>

	<div class="bg-contact2" style="background-image: url('${pageContext.request.contextPath}/images/bg-02.jpg');">
		<div class="container-contact2">
			<div class="wrap-contact2">
				<form class="contact2-form validate-form" method="post" action="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=dologin") %>"">
					<span class="contact2-form-title" style="padding-bottom: 50px !important; font-size: 24px !important; font-family: Poppins-Regular !important;">
						<img src="${pageContext.request.contextPath}/images/critique-u-vector-serif.svg" height="80px" style="margin-bottom: 40px;"/>
						<br/>Log In
						<p>Don't have an account? <a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=createaccount") %>">Create one</a>!</p>
					</span>
					<input type="hidden" name="action" value="dologin" />
					<div class="wrap-input2 validate-input" data-validate="Valid email is required">
						<input class="input2" type="text" name="email" value="<%= request.getAttribute("email") %>" autofocus/>
						<span class="focus-input2" data-placeholder="EMAIL"></span>
					</div>

					<div class="wrap-input2 validate-input" data-validate = "Valid password is required">
						<input class="input2" type="password" name="password" value="<%= request.getAttribute("password") %>"/>
						<span class="focus-input2" data-placeholder="PASSWORD"></span>
					</div>
					<p class="my-login-error"><%= request.getAttribute("message") %></p>
					<div class="container-contact2-form-btn">
						<div class="wrap-contact2-form-btn">
							<div class="contact2-form-bgbtn"></div>
							<button type="submit" class="contact2-form-btn">LOG IN</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
<c:import url="footer.jsp"></c:import>
