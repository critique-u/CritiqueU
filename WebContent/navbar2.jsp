<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Navigation -->
<c:choose>
	<c:when test="${sessionScope.email == null}">
	     <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
	      <div class="container">
	        <a class="navbar-brand js-scroll-trigger" id="critiqueu-logo" href="#page-top"><img src="${pageContext.request.contextPath}/images/critique-u-vector-serif-mono.svg" style="height: 60px; margin-top: -5px;" /></a>
	        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
	          Menu
	          <i class="fa fa-bars"></i>
	        </button>
	        <div class="collapse navbar-collapse" id="navbarResponsive">
	          <ul class="navbar-nav text-uppercase ml-auto">
	            <li class="nav-item">
	              <a class="nav-link js-scroll-trigger" href="#about">ABOUT</a>
	            </li>
	            <li class="nav-item">
	              <a class="nav-link" href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=login") %>">LOG IN</a>
	            </li>
	            <li class="nav-item">
	              <a class="nav-link" href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=createaccount") %>">SIGN UP</a>
	            </li>
	          </ul>
	        </div>
	      </div>
	    </nav>   
	</c:when>
	<c:otherwise>
	     <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
	      <div class="container">
	        <a class="navbar-brand js-scroll-trigger" id="critiqueu-logo" href="#page-top"><img src="${pageContext.request.contextPath}/images/critique-u-vector-serif-mono.svg" style="height: 60px; margin-top: -5px;" /></a>
	        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
	          Menu
	          <i class="fa fa-bars"></i>
	        </button>
	        <div class="collapse navbar-collapse" id="navbarResponsive">
	          <ul class="navbar-nav text-uppercase ml-auto">
	            <li class="nav-item">
	              <a class="nav-link js-scroll-trigger" href="#">My Art</a>
	            </li>
	            <li class="nav-item">
	              <a class="nav-link js-scroll-trigger" href="#">Browse</a>
	            </li>
	            <span class="nav-item">
		          <span class="nav-text">${sessionScope.email}</span>
	        	</span>
	        	<span class="nav-item">
		          <span class="nav-spacer">|</span>
	        	</span>
	        	<li class="nav-item">
		          <a class="nav-link" style="margin-left: -5px;" href="#" id="logout">Logout</a>
	        	</li>
	          </ul>
	        </div>
	      </div>
	    </nav>
	</c:otherwise>
</c:choose>