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
    
    function createModal2(title, imageUrl, imageDescription, contextPath)
    {
    	console.log("using simpler createModal2 function");
    	
    	//set the inner HTML on each particular div/span id
    	$('#artwork-modal-title').html(title);
    	$('#artwork-modal-image').html("<img src='" + imageUrl + "' style='width: 100%;'></img>");
    	$('#artwork-modal-description').html(imageDescription);
    	
    	//display the modal
  		$('#artwork-modal').modal('show');
    };
	
	
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
							'<button type="button" id="mymodal" class="btn btn-primary btn-lg text-artwork" onclick="createModal(' + imagesObject[image].email.toString() + ', ' + urlString.toString() + ', ' + imagesObject[image].description.toString() + '">' +
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
    									'<button type="button" id="mymodal" class="btn btn-primary btn-lg text-artwork" onclick="createModal2(&apos;' + imagesObject[image].title + '&apos;, &apos;' + urlString + '&apos;, &apos;' + imagesObject[image].description + '&apos;, &apos;' + imagesObject[image].contextPath + '&apos;)">' +
    							  			'&#x2B67;' +
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
    });
    </script>

</body>
</html>