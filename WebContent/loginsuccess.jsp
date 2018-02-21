<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:import url="header.jsp">
<c:param name="title" value="Critique U - Log In Success"></c:param>
</c:import>

	<div class="bg-contact2" style="background-image: url('${pageContext.request.contextPath}/images/bg-02.jpg');">
		<div class="container-contact2">
			<div class="wrap-contact2">
				
				<span class="contact2-form-title" style="padding-bottom: 50px !important; font-size: 24px !important; font-family: Poppins-Regular !important;">
						<img src="${pageContext.request.contextPath}/images/critique-u-vector-serif.svg" height="80px" style="margin-bottom: 40px;"/>
						
						
						<p>You are logged in.</p>
						<br/>
						<p>Request variable: <%= request.getAttribute("email") %></p>
						<% HttpSession mySession = request.getSession();  %>
						<p>Session Object variable: <%= mySession.getAttribute("email") %></p>
						
						
				</span>
				
				
			</div>
		</div>
	</div>
	
<c:import url="footer.jsp"></c:import>