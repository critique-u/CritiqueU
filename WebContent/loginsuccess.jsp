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
						
					<ul class="row" id="artwork-grid-container">
						<!-- Display 'upload image' box first in the grid -->
						<li class="col-md-4" style="margin-bottom: 20px;">
							<div class="grid-dashboard cover" style="background-color: #e6e6e6; display: table-cell; vertical-align: middle">
								upload new artwork
							</div>
						</li>
						
						
						
						
						<c:forEach var="image" items="${results.rows}">
							<c:set scope="page" var="imageName" value="${image.image_stem}.${image.image_extension}"></c:set>
							
							<li class="col-md-4" style="margin-bottom: 20px;">
									
								<div class="container-artwork">
								  <img class="grid-dashboard cover image-artwork" src="https://s3.us-east-2.amazonaws.com/critique-u/${sessionScope.email}/${imageName}" />
								  <div class="middle-artwork">

								    
										<button type="button" id="mymodal" class="btn btn-primary btn-lg text-artwork" onclick="createModal2('${image.email}', '${image.title}', 'https://s3.us-east-2.amazonaws.com/critique-u/${sessionScope.email}/${imageName}', '${image.description}', '${pageContext.request.contextPath}')">
								  			&#x2B67;
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
	        <span class="contact2-form-title" style="text-align: left; padding-bottom: 10px !important; font-size: 24px !important; font-family: Poppins-Regular !important; width: 78%;">
				<span id="artwork-modal-title">
					default artwork title
				</span>
				<p>by <span id="artwork-modal-artist">default artist name (email)</span></p>	
			</span>
			<a style="font-size: 18px !important; font-family: Poppins-Regular !important; text-align: right; display: inline-block;" class="js-scroll-trigger-modal" href="#critique-now">critique now &#128393;</a>
			
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <div class="row">
  				<div class="col-8" id="artwork-modal-image"><img src="" style="width: 100%;"></img></div>
  				<div class="col-4" id="artwork-modal-description">default image description</div>
			</div>
			
			<section id="critique-now" style="padding: 0px;">
				<form class="contact2-form validate-form" id="my-critique-form" method="post" action="<%= response.encodeUrl(request.getContextPath() + "/Controller") %>"">
						<input type="hidden" name="action" value="submitcritique" />
						
						
						<ul class="row" style="margin-top: 20px;">
						
						
							<!-- composition -->
							<li class="col-md-4" style="background-color: #FFFFFF; padding-top: 10px;">
								
								Composition<br/>
								<span id="stars-composition" class="user-rating" style="padding-top: 5px;">
									<input type="radio" name="composition-rating" value="5"><span class="star"></span>
								    <input type="radio" name="composition-rating" value="4"><span class="star"></span>
								    <input type="radio" name="composition-rating" value="3"><span class="star"></span>	
								    <input type="radio" name="composition-rating" value="2"><span class="star"></span>
								    <input type="radio" name="composition-rating" value="1"><span class="star"></span>
								</span>
								
							</li>
							<li class="col-md-8" style="background-color: #FFFFFF; padding-top: 38px;">
								<div class="wrap-input2 validate-input" data-validate = "Message is required" style="top: -10px;">
									<textarea class="input2" name="composition-comments" maxlength="500" style="background-color: #FFFFFF;"></textarea>
									<span class="focus-input2" data-placeholder="Composition Comments"></span>
								</div>
							</li>
							
							
							<!-- line -->
							<li class="col-md-4" style="background-color: #f7f4f4; padding-top: 10px;">
								
								Line<br/>
								<span id="stars-line" class="user-rating" style="padding-top: 5px;">
									<input type="radio" name="line-rating" value="5"><span class="star"></span>
								    <input type="radio" name="line-rating" value="4"><span class="star"></span>
								    <input type="radio" name="line-rating" value="3"><span class="star"></span>	
								    <input type="radio" name="line-rating" value="2"><span class="star"></span>
								    <input type="radio" name="line-rating" value="1"><span class="star"></span>
								</span>
								
							</li>
							<li class="col-md-8" style="background-color: #f7f4f4; padding-top: 38px;">
								<div class="wrap-input2 validate-input" data-validate = "Message is required" style="top: -10px;">
									<textarea class="input2" name="line-comments" maxlength="500" style="background-color: #f7f4f4;"></textarea>
									<span class="focus-input2" data-placeholder="Line Comments"></span>
								</div>
							</li>
							
							
							<!-- form -->
							<li class="col-md-4" style="background-color: #FFFFFF; padding-top: 10px;">
								
								Form<br/>
								<span id="stars-line" class="user-rating" style="padding-top: 5px;">
									<input type="radio" name="form-rating" value="5"><span class="star"></span>
								    <input type="radio" name="form-rating" value="4"><span class="star"></span>
								    <input type="radio" name="form-rating" value="3"><span class="star"></span>	
								    <input type="radio" name="form-rating" value="2"><span class="star"></span>
								    <input type="radio" name="form-rating" value="1"><span class="star"></span>
								</span>
								
							</li>
							<li class="col-md-8" style="background-color: #FFFFFF; padding-top: 38px;">
								<div class="wrap-input2 validate-input" data-validate = "Message is required" style="top: -10px;">
									<textarea class="input2" name="form-comments" maxlength="500" style="background-color: #FFFFFF;"></textarea>
									<span class="focus-input2" data-placeholder="Form Comments"></span>
								</div>
							</li>
							
							
							<!-- color -->
							<li class="col-md-4" style="background-color: #f7f4f4; padding-top: 10px;">
								
								Color<br/>
								<span id="stars-color" class="user-rating" style="padding-top: 5px;">
									<input type="radio" name="color-rating" value="5"><span class="star"></span>
								    <input type="radio" name="color-rating" value="4"><span class="star"></span>
								    <input type="radio" name="color-rating" value="3"><span class="star"></span>	
								    <input type="radio" name="color-rating" value="2"><span class="star"></span>
								    <input type="radio" name="color-rating" value="1"><span class="star"></span>
								</span>
								
							</li>
							<li class="col-md-8" style="background-color: #f7f4f4; padding-top: 38px;">
								<div class="wrap-input2 validate-input" data-validate = "Message is required" style="top: -10px;">
									<textarea class="input2" name="color-comments" maxlength="500" style="background-color: #f7f4f4;"></textarea>
									<span class="focus-input2" data-placeholder="Color Comments"></span>
								</div>
							</li>
							
							
							<!-- craft -->
							<li class="col-md-4" style="background-color: #FFFFFF; padding-top: 10px;">
								
								Craft/Technique<br/>
								<span id="stars-craft" class="user-rating" style="padding-top: 5px;">
									<input type="radio" name="craft-rating" value="5"><span class="star"></span>
								    <input type="radio" name="craft-rating" value="4"><span class="star"></span>
								    <input type="radio" name="craft-rating" value="3"><span class="star"></span>	
								    <input type="radio" name="craft-rating" value="2"><span class="star"></span>
								    <input type="radio" name="craft-rating" value="1"><span class="star"></span>
								</span>
								
							</li>
							<li class="col-md-8" style="background-color: #FFFFFF; padding-top: 38px;">
								<div class="wrap-input2 validate-input" data-validate = "Message is required" style="top: -10px;">
									<textarea class="input2" name="craft-comments" maxlength="500" style="background-color: #FFFFFF;"></textarea>
									<span class="focus-input2" data-placeholder="Craft/Technique Comments"></span>
								</div>
							</li>
							
							
							<!-- successfulness -->
							<li class="col-md-4" style="background-color: #f7f4f4; padding-top: 10px;">
								
								Overall Successfulness<br/>
								<span id="stars-successfulness" class="user-rating" style="padding-top: 5px;">
									<input type="radio" name="successfulness-rating" value="5"><span class="star"></span>
								    <input type="radio" name="successfulness-rating" value="4"><span class="star"></span>
								    <input type="radio" name="successfulness-rating" value="3"><span class="star"></span>	
								    <input type="radio" name="successfulness-rating" value="2"><span class="star"></span>
								    <input type="radio" name="successfulness-rating" value="1"><span class="star"></span>
								</span>
								
							</li>
							<li class="col-md-8" style="background-color: #f7f4f4; padding-top: 38px;">
								<div class="wrap-input2 validate-input" data-validate = "Message is required" style="top: -10px;">
									<textarea class="input2" name="successfulness-comments" maxlength="500" style="background-color: #f7f4f4;"></textarea>
									<span class="focus-input2" data-placeholder="Overall Comments"></span>
								</div>
							</li>
						
						</ul>
						
						
						
						
						
						<p class="my-login-error" id="critique-error" style="margin-top: 20px; margin-bottom: 20px;"></p>
						<div class="container-contact2-form-btn">
							<div class="wrap-contact2-form-btn" style="margin-top: 20px; margin-bottom: 20px;">
								<div class="contact2-form-bgbtn"></div>
								<button type="submit" class="contact2-form-btn" id="my-critique-submit-button">SUBMIT MY CRITIQUE</button>
							</div>
						</div>
					</form>
				</section>
			
			
			
			
			
			
			
			
			
			
			
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
										
	
<c:import url="footer.jsp"></c:import>