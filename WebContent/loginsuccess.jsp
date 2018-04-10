<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<c:if test="${sessionScope.email == null}">
    <jsp:forward page="/home.jsp" />
</c:if>

<c:import url="header.jsp">
<c:param name="title" value="Critique U - My Art"></c:param>
<c:param name="bodyid" value=""></c:param>
</c:import>
<c:import url="navbar2.jsp"></c:import>

<sql:setDataSource var="ds" dataSource="jdbc/critiqueudb" />
<sql:query dataSource="${ds}" sql="select * from artwork where email='${sessionScope.email}' order by datetime desc limit 8;" var="results" />

	<div class="bg-contact2" style="background-image: url('${pageContext.request.contextPath}/images/bg-02.jpg');">
		<div class="container-contact2" style="padding-top: 100px;">
			<div class="wrap-contact2" style="top: 0px;">
				
				<span class="contact2-form-title" style="padding-bottom: 50px !important; font-size: 24px !important; font-family: Poppins-Regular !important;">
						
						<!--
							<img src="${pageContext.request.contextPath}/images/critique-u-vector-serif.svg" height="80px" style="margin-bottom: 40px;"/>
							<p>You are logged in.</p>
							<br/>
							<p>Request variable: <%= request.getAttribute("email") %></p>
							<% HttpSession mySession = request.getSession();  %>
							<p>Session Object variable: <%= mySession.getAttribute("email") %></p><br/>
						 -->
						
					<c:choose>
						<c:when test="${sessionScope.uploadflag == 'success'}">
							<div class='alert alert-success alert-dismissible'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a><p><strong>Success!</strong> New artwork has been uploaded to your portfolio.</p></div>
							<c:set var="uploadflag" value="" scope="session"  />
						</c:when>
						<c:when test="${sessionScope.uploadflag == 'failure'}">
							<div class='alert alert-danger alert-dismissible'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a><p><strong>Error.</strong> There was a problem uploading your artwork.</p></div>
							<c:set var="uploadflag" value="" scope="session"  />
						</c:when>
					</c:choose>
						
						
						
						
					<div class='alert alert-info alert-dismissible'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a><p>Welcome to your CritiqueU <strong><i>My Art</i></strong> dashboard.</p><p>Upload new artwork and review your portfolio here.</p></div>
					
					
					<ul class="row" id="artwork-grid-container">
						<!-- Display 'upload image' box first in the grid -->
						<li class="col-md-4" style="margin-bottom: 20px;">
							<div class="container-artwork">
								<a href="#" data-toggle="tooltip" title="Upload new artwork"><img class="grid-dashboard cover image-artwork" alt="upload new artwork" src="${pageContext.request.contextPath}/images/add_icon.png" style="display: table-cell; vertical-align: middle; padding: 40px; opacity: .4;">
								</img>
								<div class="middle-artwork">

							    
									<button type="button" id="mymodal" class="btn btn-primary btn-lg text-artwork" data-toggle="modal" data-target="#upload-modal" >
							  			<span class="btn-icon">
									                <i class="fa fa-upload fa-stack-1x fa-inverse"></i>
									        </span>
									</button>
																    
							  	</div>
							  	</a>
									
							</div>
						</li>
						
						
						
						
						<c:forEach var="image" items="${results.rows}">
							<c:set scope="page" var="imageName" value="${image.image_stem}.${image.image_extension}"></c:set>
							
							<li class="col-md-4" style="margin-bottom: 20px;">
									
								<div class="container-artwork">
								  <img class="grid-dashboard cover image-artwork" src="https://s3.us-east-2.amazonaws.com/critique-u/${sessionScope.email}/${imageName}" />
								  <div class="middle-artwork">

								    
										<button type="button" id="mymodal" class="btn btn-primary btn-lg text-artwork" onclick="createModal1('${image.email}', '${image.title}', 'https://s3.us-east-2.amazonaws.com/critique-u/${sessionScope.email}/${imageName}', '${image.description}', '${pageContext.request.contextPath}', '${image.work_in_progress}')">
								  			<span class="btn-icon">
										                <i class="fa fa-search fa-stack-1x fa-inverse"></i>
									        </span>
										</button>
																	    
								  </div>
								</div>
								
								
								
								<p>
									${image.title}
								</p>
							</li>
																
						</c:forEach>
						
						
						
						
					</ul>
				</span>
				
				<div id="somediv" style="display: block; text-align: center;">
					<a href="javascript:void(0);" id="load-more-button">load more...</a>
				</div>
				
			</div>
		</div>
	</div>
	
<!-- ${image.image_stem} modal template -->
	<div class="modal fade" id="artwork-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <span class="contact2-form-title" style="text-align: left; padding-bottom: 10px !important; font-size: 24px !important; font-family: Poppins-Regular !important; width: 72%;">
				<span id="artwork-modal-title">
					default artwork title
				</span>
				<p>by <span id="artwork-modal-artist">default artist name (email)</span></p>	
			</span>
			<p>
				<a id="go-to-critiques" style="font-size: 18px !important; font-family: Poppins-Regular !important; text-align: right; display: inline-block; width: 100%;" class="js-scroll-trigger-modal" href=""><i class="fa fa-eye" style="position: relative; padding-right: 10px;"></i>artwork critiques</a>
			</p>
			
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <div class="row">
  				<div class="col-8" id="artwork-modal-image"><img src="" style="width: 100%;"></img></div>
  				<div class="col-4">
  					<div id="wip">
  						<p>
							<span style="color: #ffffff; background-color: #cf4d20; font-size: 14px !important; font-family: Poppins-Regular !important; text-align: center; display: inline-block; width: 100%;" class="js-scroll-trigger-modal"><i class="fa fa-paint-brush" style="position: relative; padding-right: 10px;"></i>WORK IN PROGRESS</span>
						</p>
  					</div>
  					<div id="artwork-modal-description">default image description</div>
  				</div>
			</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- upload image modal -->
	<div class="modal fade" id="upload-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <span class="contact2-form-title" style="text-align: left; padding-bottom: 10px !important; font-size: 24px !important; font-family: Poppins-Regular !important; width: 72%;">
				<span id="artwork-modal-title">
					Upload new artwork
				</span>	
			</span>
			
			
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <div class="row">
  				<div class="col-12" id="artwork-modal-image">
	  				<form class="contact2-form validate-form" id="my-critique-form" method="post" enctype="multipart/form-data" action="<%= response.encodeUrl(request.getContextPath() + "/Controller") %>"">
							<input type="hidden" name="action" value="uploadimage" />
							
							
							<ul class="row">
								<li class="col-md-12" style="padding-top: 30px;">
									<input type="file" name="image-to-upload" accept="image/*">
								</li>
								
								<li class="col-md-12" style="padding-top: 30px;">
									<div class="wrap-input2 validate-input" data-validate="Valid email is required">
										<input class="input2" type="text" name="title"/>
										<span class="focus-input2" data-placeholder="ARTWORK TITLE"></span>
									</div>
								</li>
								
								<li class="col-md-12">
									<div class="wrap-input2 validate-input" data-validate = "Message is required" style="margin-top: 20px;">
										<textarea class="input2" name="artwork-description" maxlength="500"></textarea>
										<span class="focus-input2" data-placeholder="ARTWORK DESCRIPTION"></span>
									</div>
								</li>
								<li class="col-md-12">
									<div style="margin-top: 5px;">
										<input type="checkbox" name="work-in-progress"><span style="margin-left: 5px; font-size: small; opacity: .7;">WORK IN PROGRESS</span>
									</div>
								</li>
							</ul>
							<div class="container-contact2-form-btn">
									<div class="wrap-contact2-form-btn">
										<div class="contact2-form-bgbtn"></div>
										<button type="submit" class="contact2-form-btn">UPLOAD ARTWORK</button>
									</div>
							</div>
								
  				
  				
  				
  				
  				
  				
  				
  				
  					
					  

					  
					  
					  
					  
					  
					  
					  
					  
					  
					  
					  
					  
					</form>
  				</div>
  				
			</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
										
	
<c:import url="footer.jsp"></c:import>