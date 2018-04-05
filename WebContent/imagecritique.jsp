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
<sql:query dataSource="${ds}" sql="select * from critique where email='${param.artist}' and title='${param.title}' order by datetime desc;" var="critiqueResults" />
<sql:query dataSource="${ds}" sql="select * from artwork where email='${param.artist}' and title='${param.title}';" var="imageResult" />
	<div class="bg-contact2" style="background-image: url('${pageContext.request.contextPath}/images/bg-02.jpg');">
		<div class="container-contact2" style="padding-top: 100px;">
			<div class="wrap-contact2" style="top: 0px;">
			
			<span class="contact2-form-title" style="text-align: left; padding-bottom: 10px !important; font-size: 24px !important; font-family: Poppins-Regular !important;">
				<span style="float: right; display: inline-block;"><a style="font-size: 18px !important; font-family: Poppins-Regular !important;" class="js-scroll-trigger" href="#critiques"><i class="fa fa-eye" style="position: relative; padding-right: 10px;"></i>view critiques</a></span>
				${param.title}
				<p>by ${param.artist}</p>
				
			</span>
			<br/>
			<!-- Image being critiqued -->
			<c:forEach var="imageData" items="${imageResult.rows}" end="0">
     			<div class="row">
	  				<div class="col-8" id="artwork-modal-image"><img src="https://s3.us-east-2.amazonaws.com/critique-u/${param.artist}/${imageData.image_stem}.${imageData.image_extension}" style="width: 100%;"></img></div>
	  				<div class="col-4" id="artwork-modal-description">${imageData.description}</div>
				</div>
			</c:forEach>
			<c:set scope="page" var="toggleColor" value="#f7f4f4"></c:set>
			
			<!-- this section will contain critiques for the above image -->
			
				<span class="contact2-form-title" id="critiques" style="padding-top: 20px !important; padding-bottom: 0px !important; font-size: 24px !important; font-family: Poppins-Regular !important;">
							
							<!--
								<img src="${pageContext.request.contextPath}/images/critique-u-vector-serif.svg" height="80px" style="margin-bottom: 40px;"/>
								<p>You are logged in.</p>
								<br/>
								<p>Request variable: <%= request.getAttribute("email") %></p>
								<% HttpSession mySession = request.getSession();  %>
								<p>Session Object variable: <%= mySession.getAttribute("email") %></p><br/>
							 -->

					<ul class="row">

							<c:forEach var="critique" items="${critiqueResults.rows}">
								
								<li class="col-md-12" style="margin-bottom: 40px; background-color: ${toggleColor}; padding-top: 15px; padding-bottom: 15px;">
										
									<div class="container-artwork" style="text-align: left;">
									  	<span class="contact2-form-title" style="text-align: left; padding-bottom: 10px !important; font-size: 18px !important; font-family: Poppins-Regular !important;">
											<b>ARTWORK CRITIQUE</b>
											<p>written by ${critique.criticEmail}</p>
										</span>
										<p>
									  		<b style="margin-right: 10px;">Composition</b><br/>
									  		<span id="stars-line" class="user-rating" style="padding-top: 0px;">
												<input type="radio" name="composition-rating-by-${critique.criticEmail}" value="5" disabled="true" <c:if test="${critique.composition=='5'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="composition-rating-by-${critique.criticEmail}" value="4" disabled="true" <c:if test="${critique.composition=='4'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="composition-rating-by-${critique.criticEmail}" value="3" disabled="true" <c:if test="${critique.composition=='3'}">checked</c:if>><span class="star"></span>	
											    <input type="radio" name="composition-rating-by-${critique.criticEmail}" value="2" disabled="true" <c:if test="${critique.composition=='2'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="composition-rating-by-${critique.criticEmail}" value="1" disabled="true" <c:if test="${critique.composition=='1'}">checked</c:if>><span class="star"></span>
											</span>
										</p>
										<p>
									  		${critique.compositionComments}
										</p>
										<p style="margin-top: 30px;">
									  		<b style="margin-right: 10px;">Line</b><br/>
									  		<span id="stars-line" class="user-rating" style="padding-top: 0px;">
												<input type="radio" name="line-rating-by-${critique.criticEmail}" value="5" disabled="true" <c:if test="${critique.line=='5'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="line-rating-by-${critique.criticEmail}" value="4" disabled="true" <c:if test="${critique.line=='4'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="line-rating-by-${critique.criticEmail}" value="3" disabled="true" <c:if test="${critique.line=='3'}">checked</c:if>><span class="star"></span>	
											    <input type="radio" name="line-rating-by-${critique.criticEmail}" value="2" disabled="true" <c:if test="${critique.line=='2'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="line-rating-by-${critique.criticEmail}" value="1" disabled="true" <c:if test="${critique.line=='1'}">checked</c:if>><span class="star"></span>
											</span>
										</p>
										<p>
									  		${critique.lineComments}
										</p>
										<p style="margin-top: 30px;">
									  		<b style="margin-right: 10px;">Form</b><br/>
									  		<span id="stars-line" class="user-rating" style="padding-top: 0px;">
												<input type="radio" name="form-rating-by-${critique.criticEmail}" value="5" disabled="true" <c:if test="${critique.form=='5'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="form-rating-by-${critique.criticEmail}" value="4" disabled="true" <c:if test="${critique.form=='4'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="form-rating-by-${critique.criticEmail}" value="3" disabled="true" <c:if test="${critique.form=='3'}">checked</c:if>><span class="star"></span>	
											    <input type="radio" name="form-rating-by-${critique.criticEmail}" value="2" disabled="true" <c:if test="${critique.form=='2'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="form-rating-by-${critique.criticEmail}" value="1" disabled="true" <c:if test="${critique.form=='1'}">checked</c:if>><span class="star"></span>
											</span>
										</p>
										<p>
									  		${critique.formComments}
										</p>
										<p style="margin-top: 30px;">
									  		<b style="margin-right: 10px;">Color</b><br/>
									  		<span id="stars-line" class="user-rating" style="padding-top: 0px;">
												<input type="radio" name="color-rating-by-${critique.criticEmail}" value="5" disabled="true" <c:if test="${critique.color=='5'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="color-rating-by-${critique.criticEmail}" value="4" disabled="true" <c:if test="${critique.color=='4'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="color-rating-by-${critique.criticEmail}" value="3" disabled="true" <c:if test="${critique.color=='3'}">checked</c:if>><span class="star"></span>	
											    <input type="radio" name="color-rating-by-${critique.criticEmail}" value="2" disabled="true" <c:if test="${critique.color=='2'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="color-rating-by-${critique.criticEmail}" value="1" disabled="true" <c:if test="${critique.color=='1'}">checked</c:if>><span class="star"></span>
											</span>
										</p>
										<p>
									  		${critique.colorComments}
										</p>
										<p style="margin-top: 30px;">
									  		<b style="margin-right: 10px;">Craft/Technique</b><br/>
									  		<span id="stars-line" class="user-rating" style="padding-top: 0px;">
												<input type="radio" name="craft-rating-by-${critique.criticEmail}" value="5" disabled="true" <c:if test="${critique.craft=='5'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="craft-rating-by-${critique.criticEmail}" value="4" disabled="true" <c:if test="${critique.craft=='4'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="craft-rating-by-${critique.criticEmail}" value="3" disabled="true" <c:if test="${critique.craft=='3'}">checked</c:if>><span class="star"></span>	
											    <input type="radio" name="craft-rating-by-${critique.criticEmail}" value="2" disabled="true" <c:if test="${critique.craft=='2'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="craft-rating-by-${critique.criticEmail}" value="1" disabled="true" <c:if test="${critique.craft=='1'}">checked</c:if>><span class="star"></span>
											</span>
										</p>
										<p>
									  		${critique.craftComments}
										</p>
										<p style="margin-top: 30px;">
									  		<b style="margin-right: 10px;">Overall Successfulness</b><br/>
									  		<span id="stars-line" class="user-rating" style="padding-top: 0px;">
												<input type="radio" name="successfulness-rating-by-${critique.criticEmail}" value="5" disabled="true" <c:if test="${critique.successfulness=='5'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="successfulness-rating-by-${critique.criticEmail}" value="4" disabled="true" <c:if test="${critique.successfulness=='4'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="successfulness-rating-by-${critique.criticEmail}" value="3" disabled="true" <c:if test="${critique.successfulness=='3'}">checked</c:if>><span class="star"></span>	
											    <input type="radio" name="successfulness-rating-by-${critique.criticEmail}" value="2" disabled="true" <c:if test="${critique.successfulness=='2'}">checked</c:if>><span class="star"></span>
											    <input type="radio" name="successfulness-rating-by-${critique.criticEmail}" value="1" disabled="true" <c:if test="${critique.successfulness=='1'}">checked</c:if>><span class="star"></span>
											</span>
										</p>
										<p>
									  		${critique.comments}
										</p>
	
									</div>
								</li>
								
								<c:choose>
									  <c:when test="${toggleColor == '#f7f4f4'}">
									    <c:set scope="page" var="toggleColor" value="#ffffff"></c:set>
									  </c:when>
									  <c:otherwise>
									    <c:set scope="page" var="toggleColor" value="#f7f4f4"></c:set>
									  </c:otherwise>
								</c:choose>
																	
							</c:forEach>	
						</ul>
					</span>
				
				<!--  the load more button used for user artwork
					<div id="somediv" style="display: block; text-align: center;">
						<a href="javascript:void(0);" id="load-more-button">load more...</a>
					</div>
				-->
			</div>
		</div>
	</div>
	
<!-- ${image.image_stem} modal template -->
	<div class="modal fade" id="artwork-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="artwork-modal-title">default image title</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <div class="row">
  				<div class="col-8" id="artwork-modal-image"><img src="" style="width: 100%;"></img></div>
  				<div class="col-4" id="artwork-modal-description">default image description</div>
			</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Save changes</button>
	      </div>
	    </div>
	  </div>
	</div>
										
	
<c:import url="footer.jsp"></c:import>