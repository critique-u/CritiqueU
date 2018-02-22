<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<c:if test="${sessionScope.email == null}">
    <jsp:forward page="/home.jsp" />
</c:if>

<c:import url="header.jsp">
<c:param name="title" value="Critique U - Log In Success"></c:param>
</c:import>
<c:import url="navbar.jsp"></c:import>

<sql:setDataSource var="ds" dataSource="jdbc/critiqueudb" />
<sql:query dataSource="${ds}" sql="select * from artwork where email='${sessionScope.email}' limit 10;" var="results" />

	<div class="bg-contact2" style="background-image: url('${pageContext.request.contextPath}/images/bg-02.jpg');">
		<div class="container-contact2" style="padding-top: 65px;">
			<div class="wrap-contact2" style="top: 0px;">
				
				<span class="contact2-form-title" style="padding-bottom: 50px !important; font-size: 24px !important; font-family: Poppins-Regular !important;">
						<img src="${pageContext.request.contextPath}/images/critique-u-vector-serif.svg" height="80px" style="margin-bottom: 40px;"/>
						
						
						<p>You are logged in.</p>
						<br/>
						<p>Request variable: <%= request.getAttribute("email") %></p>
						<% HttpSession mySession = request.getSession();  %>
						<p>Session Object variable: <%= mySession.getAttribute("email") %></p><br/>
						
						<c:forEach var="image" items="${results.rows}">
							<p>
								${image.title} by ${image.email}
							</p>
						</c:forEach>
						
						
						
						
				</span>
				
				
			</div>
		</div>
	</div>
	
<c:import url="footer.jsp"></c:import>