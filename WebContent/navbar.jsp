<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
          
        <div class="navbar-header pull-left">     
          	<a class="navbar-brand" href="<%= response.encodeUrl(request.getContextPath() + "/Controller") %>">
      			<img src="${pageContext.request.contextPath}/images/critique-u-vector-serif-mono.svg" style="height: 45px; margin-top: -12px;" />
      		</a>
        </div>
        <div class="navbar-header pull-right">
           <button type="button" class="navbar-toggle" 
                  data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
            
        <p class="navbar-text">
          	${sessionScope.email}
          	<b style="margin-left: 5px; margin-right: 5px; display: inline-block;"> | </b>
          	<a href="#" id="logout">Logout</a>
        </p>
		
    
        </div>
          
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li style="margin-top: 3px;" class="active"><a href="<%= response.encodeUrl(request.getContextPath() + "/Controller") %>">Home</a></li>
            <li style="margin-top: 3px;"><a href="#">My Art</a></li>
            <li style="margin-top: 3px;"><a href="#">Browse</a></li>
            <li style="margin-top: 3px;"><a href="#">About</a></li>
            <li style="margin-top: 3px;"><a href="#">Contact</a></li>
          </ul>
        </div>

</div>
</nav>


