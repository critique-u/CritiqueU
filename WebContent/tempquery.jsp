<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<c:import url="header.jsp">
<c:param name="title" value="Critique U - Temp Query"></c:param>
</c:import>

<%-- "ds" var is a name that we can just make up to use --%>
<sql:setDataSource var="ds" dataSource="jdbc/critiqueudb" />
<sql:query dataSource="${ds}" sql="select * from artwork limit 10;" var="results" />

	<div class="bg-contact2" style="background-image: url('${pageContext.request.contextPath}/images/bg-02.jpg');">
		<div class="container-contact2">
			<div class="wrap-contact2">
				
				<span class="contact2-form-title" style="padding-bottom: 50px !important; font-size: 24px !important; font-family: Poppins-Regular !important;">
						<img src="${pageContext.request.contextPath}/images/critique-u-vector-serif.svg" height="80px" style="margin-bottom: 40px;"/>		
				</span>
				
				<c:forEach var="image" items="${results.rows}">
					<p>
						${image.title} by ${image.email}
					</p>
				</c:forEach>
				<c:forEach var="image" items="${results.rows}">
					<p>
						${image.title} by ${image.email}
					</p>
				</c:forEach>
				<c:forEach var="image" items="${results.rows}">
					<p>
						${image.title} by ${image.email}
					</p>
				</c:forEach>
				<c:forEach var="image" items="${results.rows}">
					<p>
						${image.title} by ${image.email}
					</p>
				</c:forEach>
				<c:forEach var="image" items="${results.rows}">
					<p>
						${image.title} by ${image.email}
					</p>
				</c:forEach>
				<c:forEach var="image" items="${results.rows}">
					<p>
						${image.title} by ${image.email}
					</p>
				</c:forEach>
				<c:forEach var="image" items="${results.rows}">
					<p>
						${image.title} by ${image.email}
					</p>
				</c:forEach>
				
				
				
			</div>
		</div>
	</div>

<c:import url="footer.jsp"></c:import>