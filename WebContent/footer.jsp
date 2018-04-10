<!--===============================================================================================-->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/popper.js"></script>
	
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/js/main.js"></script>
	
	
<!-- Bootstrap core JavaScript -->
    <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Contact form JavaScript -->
    <script src="${pageContext.request.contextPath}/js/jqBootstrapValidation.js"></script>

    <!-- Custom scripts for this template -->
    <script src="${pageContext.request.contextPath}/js/agency.js"></script>	
	
	
	
	
	
	

	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());

	  gtag('config', 'UA-23581568-13');
	</script>
	
	<script type="text/javascript">
	function createModal(title, imageUrl, imageDescription, contextPath)
    {
		console.log("context path: " + contextPath);
		console.log("title: " + title);
		console.log("description: " + imageDescription);
    	//dynamically create html of "#artwork-modal" depending on which image was clicked
    	var modalHTML =
   		'<div class="modal-dialog modal-lg" role="document">' +
    	    '<div class="modal-content">' +
  	      		'<div class="modal-header">' +
  	        		'<h5 class="modal-title" id="exampleModalLabel">' + title + '</h5>' +
  	        		'<button type="button" class="close" data-dismiss="modal" aria-label="Close">' +
  	        			'<span aria-hidden="true">&times;</span>' +
  	        		'</button>' +
  	      		'</div>' +
  	      		'<div class="modal-body">' +
  	        		'<div class="row">' +
  						'<div class="col-8"><img src="' + imageUrl + '" style="width: 100%;"></img></div>' +
  						'<div class="col-4">' + imageDescription +'<br/><br/>critique summary placeholder (star average?)</div>' +
					'</div>' +
  	      		'</div>' +
  	      		'<div class="modal-footer">' +
  	        		'<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>' +
  	        		'<button type="button" class="btn btn-primary">Save changes</button>' +
  	      		'</div>' +
  	    	'</div>' +
  		'</div>';
	  		
    	//set the inner HTML of the modal div
	  		$('#artwork-modal').html(modalHTML);
    	
    	//display the modal
	  		$('#artwork-modal').modal('show');	
    };
    
    function createModal2(artist, title, imageUrl, imageDescription, contextPath, wip)
    {
    	console.log("using simpler createModal2 function");
    	
    	//set the inner HTML on each particular div/span id
    	$('#artwork-modal-title').html(title);
    	$('#artwork-modal-artist').html(artist);
    	$('#artwork-modal-image').html("<img src='" + imageUrl + "' style='width: 100%;'></img>");
    	$('#artwork-modal-description').html(imageDescription);
    	
    	console.log("wip: " + wip);
    	
    	if(wip == "false")
   		{
    		$('#wip').html("");
   		}
    	else
   		{
    		$('#wip').html('<p><span style="color: #ffffff; background-color: #d51111; font-size: 14px !important; font-family: Poppins-Regular !important; text-align: center; display: inline-block; width: 100%;" class="js-scroll-trigger-modal"><i class="fa fa-paint-brush" style="position: relative; padding-right: 10px;"></i>WORK IN PROGRESS</span></p>');
   		}  
    	
    	clearCritique();
    	
    	//display the modal
  		$('#artwork-modal').modal('show');
    };
    
    function createModal1(artist, title, imageUrl, imageDescription, contextPath, wip)
    {
    	console.log("using simpler createModal1 function");
    	
    	//set the inner HTML on each particular div/span id
    	$('#artwork-modal-title').html(title);
    	$('#artwork-modal-artist').html(artist);
    	$('#artwork-modal-image').html("<img src='" + imageUrl + "' style='width: 100%;'></img>");
    	$('#artwork-modal-description').html(imageDescription);
    	$('#go-to-critiques').attr("href", '${pageContext.request.contextPath}/Controller?action=image&title=' + title + '&artist=' + artist);
    	
		console.log("wip: " + wip);
    	
    	if(wip == "false")
   		{
    		$('#wip').html("");
   		}
    	else
   		{
    		$('#wip').html('<p><span style="color: #ffffff; background-color: #d51111; font-size: 14px !important; font-family: Poppins-Regular !important; text-align: center; display: inline-block; width: 100%;" class="js-scroll-trigger-modal"><i class="fa fa-paint-brush" style="position: relative; padding-right: 10px;"></i>WORK IN PROGRESS</span></p>');
   		}  
    	
    	//display the modal
  		$('#artwork-modal').modal('show');
    };
    
    
    //<a href='${pageContext.request.contextPath}/Controller?action=image&title=" + title + "&artist=" + artistEmail + "'>
    
    function clearCritique()
    {
    	console.log("inside clearCritique function");
    	console.log("before: " + $('[name="composition-rating"]:checked').val());
    	
    	$('input[name="composition-rating"]').prop('checked', false);
    	$('input[name="line-rating"]').prop('checked', false);
    	$('input[name="form-rating"]').prop('checked', false);
    	$('input[name="color-rating"]').prop('checked', false);
    	$('input[name="craft-rating"]').prop('checked', false);
    	$('input[name="successfulness-rating"]').prop('checked', false);
    	
    	console.log("after: " + $('[name="composition-rating"]:checked').val());
    	
    	$('.input2').val("");
    	
    	$('#submit-message').html("");
    }
	
	
    $(document).ready(function() {
    	//logout function to pass data by POST method
         $('#logout').click(function()
		 {
        	 console.log("inside js");
        	 var url = '${pageContext.request.contextPath}' + "/Controller";
        	 var form = $('<form action="' + url + '" method="post">' +
        	   '<input type="text" name="action" value="logout" />' +
        	   '</form>');
        	 $('body').append(form);
        	 form.submit();
         });
         
        //declare a global to track index. This will be incremented after each server request 
        var index = 8;
        var browseIndex = 9;
        
        $( "#my-critique-submit-button" ).click(function( event ) {
        	 
        	
        	  // Stop form from submitting normally
        	  event.preventDefault();
        	  
        	  console.log("INSIDE BUTTON HANDLER");
        	 
        	  // Get some values from elements on the page:
        	  var $form = $('#my-critique-form'),
        	  	artistEmail = $("#artwork-modal-artist").html(),
        	  	title = $("#artwork-modal-title").html(),
        	    postAction = $form.find( "input[name='action']" ).val(),
        	    compositionRating = $('[name="composition-rating"]:checked').val(),
        	    compositionComments = $('[name="composition-comments"]').val(),
        	    lineRating = $('[name="line-rating"]:checked').val(),
        	    lineComments = $('[name="line-comments"]').val(),
        	    formRating = $('[name="form-rating"]:checked').val(),
        	    formComments = $('[name="form-comments"]').val(),
        	    colorRating = $('[name="color-rating"]:checked').val(),
        	    colorComments = $('[name="color-comments"]').val(),
        	    craftRating = $('[name="craft-rating"]:checked').val(),
        	    craftComments = $('[name="craft-comments"]').val(),
        	    successfulnessRating = $('[name="successfulness-rating"]:checked').val(),
        	    successfulnessComments = $('[name="successfulness-comments"]').val(),
        	    url = $form.attr( "action" );
        	  
        	  console.log(url);
        	 
        	  // Send the data using post
        	  var posting = $.post( url,
        			  { "action": postAction,
        		  		"composition-rating": compositionRating,
        		  		"composition-comments": compositionComments,
        		  		"line-rating": lineRating,
        		  		"line-comments": lineComments,
        		  		"form-rating": formRating,
        		  		"form-comments": formComments,
        		  		"color-rating": colorRating,
        		  		"color-comments": colorComments,
        		  		"craft-rating": craftRating,
        		  		"craft-comments": craftComments,
        		  		"successfulness-rating": successfulnessRating,
        		  		"successfulness-comments": successfulnessComments,
        		  		"artist-email": artistEmail,
        	  			"title": title }
        	  );
        	 
        	  // Put the results in a div
        	  posting.done(function( data ) {
        	    //var content = $( data ).find( "#content" );
        	    //$( "#result" ).empty().append( content );
        	    //console.log(data);
        	    //window.location.replace("${pageContext.request.contextPath}/Controller?action=image&title=" + title + "&artist=" + artistEmail);
        	    console.log(data);
        	    if(data == "success")
       	    	{
        	    	$("#submit-message").html("<div class='alert alert-success alert-dismissible'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a><strong>Success!</strong> Critique submitted. </div><div style='margin: auto; text-align: center;'><a href='${pageContext.request.contextPath}/Controller?action=image&title=" + title + "&artist=" + artistEmail + "'><i class='fa fa-eye' style='position: relative; padding-right: 10px; padding-left: 20px;'></i>view all critiques for this artwork</a></div>");
     	    		//$("#my-critique-form").html("");
       	    	}
        	    else
       	    	{
        	    	$("#submit-message").html("<div class='alert alert-danger alert-dismissible'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a><strong>Error!</strong> An error has occured in submitting your critique. </div><div style='margin: auto; text-align: center;'><a href='${pageContext.request.contextPath}/Controller?action=image&title=" + title + "&artist=" + artistEmail + "'><i class='fa fa-eye' style='position: relative; padding-right: 10px; padding-left: 20px;'></i>view all critiques for this artwork</a></div>");
         	    		//$("#my-critique-form").html("");
       	    	}
        	    
        	  });
        });
      	
         
        //ajax test on button click
       	$('#load-more-button').click(function()
       	{
       		console.log("ajax test.");
       		var url = '${pageContext.request.contextPath}' + "/Controller";
       		var params = "?action=more&index="+index;
       		$.get(url+params, function(responseText, status)
      		{   
       			console.log(responseText);
       			// Execute Ajax GET request on URL of "someservlet" and execute the following function with Ajax response text...
       			var imagesObject = JSON.parse(responseText);
       			
       			//console.log(imagesObject[0].title);
       			console.log(imagesObject[8] === undefined);
       			console.log(imagesObject[2] === undefined);
       			
       			for(image in imagesObject)
    			{
    				//console.log(imagesObject[image].title);
    				
    				var urlString = "https://s3.us-east-2.amazonaws.com/critique-u/" + imagesObject[image].email + "/" + imagesObject[image].url;
    				
    				//console.log(urlString);
    				
    				var htmlString = '<li class="col-md-4" style="margin-bottom: 20px;">' +
					'<div class="container-artwork">' +
					  '<img class="grid-dashboard cover image-artwork" src="https://s3.us-east-2.amazonaws.com/critique-u/' + imagesObject[image].email.toString() + '/' + imagesObject[image].title.toString() + '"/>' +
					  	'<div class="middle-artwork">' +
							'<button type="button" id="mymodal" class="btn btn-primary btn-lg text-artwork" onclick="createModal1(' + imagesObject[image].email.toString() + ', ' + urlString.toString() + ', ' + imagesObject[image].description.toString() + '">' +
					  			'<span class="btn-icon">' +
									'<i class="fa fa-search fa-stack-1x fa-inverse"></i>' +
								'</span>' +
							'</button>' +
					  '</div>' +
					'</div>' +
					'<p>' +
						imagesObject[image].title.toString() +
					'</p>' +
				'</li>';
    				
    				$("#artwork-grid-container").append(
    						'<li class="col-md-4" style="margin-bottom: 20px;">' +
    							'<div class="container-artwork">' +
    							  '<img class="grid-dashboard cover image-artwork" src="https://s3.us-east-2.amazonaws.com/critique-u/' + imagesObject[image].email + '/' + imagesObject[image].url + '"/>' +
    							  	'<div class="middle-artwork">' +
    									'<button type="button" id="mymodal" class="btn btn-primary btn-lg text-artwork" onclick="createModal1(&apos;' + imagesObject[image].email + '&apos;, &apos;' + imagesObject[image].title + '&apos;, &apos;' + urlString + '&apos;, &apos;' + imagesObject[image].description + '&apos;, &apos;' + imagesObject[image].contextPath + '&apos;, &apos;' + imagesObject[image].wip + '&apos;)">' +
    									'<span class="btn-icon">' +
    									'<i class="fa fa-search fa-stack-1x fa-inverse"></i>' +
    								'</span>' +
    									'</button>' +
    							  '</div>' +
    							'</div>' +
    							'<p>' +
    								imagesObject[image].title.toString() +
    							'</p>' +
    						'</li>');

    			}
                //$("#somediv").append(responseText + " " + status); // Locate HTML DOM element with ID "somediv" and set its text content with the response text.
                if(status == 'success')
               	{
                	index += 9;
               	}
                //if the last element in the returned json is not defined, then we're at the end of the artwork list
                if(imagesObject[8] === undefined)
               	{
                	//change the "load more" div to disappear or read "that's it", etc.
               		$("#somediv").html('<a id="somebutton">-- that\'s it --</a>');
               	}
            });
       	});
       		
      //ajax test on button click
       	$('#load-more-browse-button').click(function()
       	{
       		console.log("ajax browse test.");
       		var url = '${pageContext.request.contextPath}' + "/Controller";
       		var params = "?action=browsemore&index="+browseIndex;
       		$.get(url+params, function(responseText, status)
      		{   
       			console.log(responseText);
       			// Execute Ajax GET request on URL of "someservlet" and execute the following function with Ajax response text...
       			var imagesObject = JSON.parse(responseText);
       			
       			//console.log(imagesObject[0].title);
       			console.log(imagesObject[8] === undefined);
       			console.log(imagesObject[2] === undefined);
       			
       			for(image in imagesObject)
    			{
    				//console.log(imagesObject[image].title);
    				
    				var urlString = "https://s3.us-east-2.amazonaws.com/critique-u/" + imagesObject[image].email + "/" + imagesObject[image].url;
    				
    				//console.log(urlString);
    				
    				var htmlString = '<li class="col-md-4" style="margin-bottom: 20px;">' +
					'<div class="container-artwork">' +
					  '<img class="grid-dashboard cover image-artwork" src="https://s3.us-east-2.amazonaws.com/critique-u/' + imagesObject[image].email.toString() + '/' + imagesObject[image].title.toString() + '"/>' +
					  	'<div class="middle-artwork">' +
							'<button type="button" id="mymodal" class="btn btn-primary btn-lg text-artwork" onclick="createModal2(' + imagesObject[image].email.toString() + ', ' + urlString.toString() + ', ' + imagesObject[image].description.toString() + '">' +
					  			'&#x2B67;' +
							'</button>' +
					  '</div>' +
					'</div>' +
					'<p>' +
						imagesObject[image].title.toString() +
					'</p>' +
				'</li>';
    				
    				$("#artwork-grid-container").append(
    						'<li class="col-md-4" style="margin-bottom: 20px;">' +
    							'<div class="container-artwork">' +
    							  '<img class="grid-dashboard cover image-artwork" src="https://s3.us-east-2.amazonaws.com/critique-u/' + imagesObject[image].email + '/' + imagesObject[image].url + '"/>' +
    							  	'<div class="middle-artwork">' +
    									'<button type="button" id="mymodal" class="btn btn-primary btn-lg text-artwork" onclick="createModal2(&apos;' + imagesObject[image].email + '&apos;, &apos;' + imagesObject[image].title + '&apos;, &apos;' + urlString + '&apos;, &apos;' + imagesObject[image].description + '&apos;, &apos;' + imagesObject[image].contextPath + '&apos;, &apos;' + imagesObject[image].wip + '&apos;)">' +
    							  			'<span class="btn-icon"><i class="fa fa-pencil fa-stack-1x fa-inverse"></i></span>' +
    									'</button>' +
    							  '</div>' +
    							'</div>' +
    							'<p>' +
    								imagesObject[image].title.toString() + " by " + imagesObject[image].email.toString() + 
    							'</p>' +
    						'</li>');

    			}
                //$("#somediv").append(responseText + " " + status); // Locate HTML DOM element with ID "somediv" and set its text content with the response text.
                if(status == 'success')
               	{
                	browseIndex += 9;
               	}
                //if the last element in the returned json is not defined, then we're at the end of the artwork list
                if(imagesObject[8] === undefined)
               	{
                	//change the "load more" div to disappear or read "that's it", etc.
               		$("#somediv").html('<a id="somebutton">-- that\'s it --</a>');
               	}
            });
       	});	
       		
       		
       		
       		
    });
    </script>

</body>
</html>