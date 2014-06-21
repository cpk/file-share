// JavaScript Document
$(document).ready(function() {
	$("#avatar_show").hide();
	$("#avatar").click(function(e) {
		e.preventDefault();
		$("#avatar_show").show(200);
	});
	$("#avatar_show").mouseup(function() {
		return false
	});		
	$(document).mouseup(function(e) {
		if($(e.target).parent("#avatar").length==0) {
			$("#avatar_show").hide(200);
		}
	});
    $('a.login-window').click(function() {
        
                //Getting the variable's value from a link 
        var loginBox = $(this).attr('href');

        //Fade in the Popup
        $(loginBox).fadeIn(300);
        
        //Set the center alignment padding + border see css style
        var popMargTop = ($(loginBox).height() + 24) / 2; 
        var popMargLeft = ($(loginBox).width() + 24) / 2; 
        
        $(loginBox).css({ 
            'margin-top' : -popMargTop,
            'margin-left' : -popMargLeft
        });
        
        // Add the mask to body
        $('body').append('<div id="mask"></div>');
        $('#mask').fadeIn(300);
        
        return false;
    });
    
    // When clicking on the button close or the mask layer the popup closed
    $('a.close, #mask').click(function() { 
      $('#mask , .login-popup').fadeOut(300 , function() {
        $('#mask').remove();  
    }); 
    return false;
    });
	
	
}); 
function submitForm() {
    $.ajax({
		type:'POST',
		url:'creatnewfolder.jsp', 
		data:$('#creatnewfolder').serialize(), 
		beforeSend: function () {
            $('#user_right').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
        }, 
		success: function(data) {
			$(".loading").detach();
        	$(document).find('#user_right').html(data);
			$.ajax({
				  type:'POST',
				  url:'showfoldertree.jsp',
				  beforeSend: function () {
					  $('#user_left').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
				  }, 
				  success: function(html) {
					  $(".loading").detach();
					  $("#user_left").html(html);
			  }});
    }});
	$('#mask , .login-popup').fadeOut(300 , function() {
        $('#mask').remove();  
    });
    return false;
}
function openFolder(foldername, path){
	$.ajax({
		type:'POST',
		url:'getPath.jsp?foldername='+foldername+'&path='+path,
		beforeSend: function () {
            $('#adress_path').append('<div class="loading"><img src="img/icon/loading.gif" alt="loading..." /></div>');
        }, 
		success: function(html) {
			$(".loading").detach();
        	$("#adress_path").html(html);
			$.ajax({
				type:'POST',
				url:'openfolder.jsp',
				beforeSend: function () {
					$('#user_right').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
				}, 
				success: function(html) {
					$(".loading").detach();
					$("#user_right").html(html);
					$.ajax({
						type:'POST',
						url:'showfoldertree.jsp',
						beforeSend: function () {
							$('#user_left').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
						}, 
						success: function(html) {
							$(".loading").detach();
							$("#user_left").html(html);
					}});
   	 		}});
    }});
	return false;
}
function openFolderShare(foldername, path){
	$.ajax({
		type:'POST',
		url:'getPathShare.jsp?foldername='+foldername+'&path='+path,
		beforeSend: function () {
            $('#adress_path').append('<div class="loading"><img src="img/icon/loading.gif" alt="loading..." /></div>');
        }, 
		success: function(html) {
			$(".loading").detach();
        	$("#adress_path").html(html);
			$.ajax({
				type:'POST',
				url:'openfoldershare.jsp',
				beforeSend: function () {
					$('#user_right').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
				}, 
				success: function(html) {
					$(".loading").detach();
					$("#user_right").html(html);
					$.ajax({
						type:'POST',
						url:'showfoldertreeshare.jsp',
						beforeSend: function () {
							$('#user_left').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
						}, 
						success: function(html) {
							$(".loading").detach();
							$("#user_left").html(html);
					}});
   	 		}});
    }});
	return false;
}
function upFolder(){
	$.ajax({
		type:'POST',
		url:'upFolder.jsp',
		beforeSend: function () {
            $('#adress_path').append('<div class="loading"><img src="img/icon/loading.gif" alt="loading..." /></div>');
        }, 
		success: function(html) {
			$(".loading").detach();
        	$("#adress_path").html(html);
			$.ajax({
				type:'POST',
				url:'openfolder.jsp',
				beforeSend: function () {
					$('#user_right').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
				}, 
				success: function(html) {
					$(".loading").detach();
					$("#user_right").html(html);
					$.ajax({
						type:'POST',
						url:'showfoldertree.jsp',
						beforeSend: function () {
							$('#user_left').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
						}, 
						success: function(html) {
							$(".loading").detach();
							$("#user_left").html(html);
					}});
   	 		}});
    }});
	return false;
}
function upFolderShare(){
	$.ajax({
		type:'POST',
		url:'upFolderShare.jsp',
		beforeSend: function () {
            $('#adress_path').append('<div class="loading"><img src="img/icon/loading.gif" alt="loading..." /></div>');
        }, 
		success: function(html) {
			$(".loading").detach();
        	$("#adress_path").html(html);
			$.ajax({
				type:'POST',
				url:'openfoldershare.jsp',
				beforeSend: function () {
					$('#user_right').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
				}, 
				success: function(html) {
					$(".loading").detach();
					$("#user_right").html(html);
					$.ajax({
						type:'POST',
						url:'showfoldertreeshare.jsp',
						beforeSend: function () {
							$('#user_left').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
						}, 
						success: function(html) {
							$(".loading").detach();
							$("#user_left").html(html);
					}});
   	 		}});
    }});
	return false;
}
function goFolder(pathFolder){
	$.ajax({
		type:'POST',
		url:'goFolder.jsp?pathFolder='+pathFolder,
		beforeSend: function () {
            $('#adress_path').append('<div class="loading"><img src="img/icon/loading.gif" alt="loading..." /></div>');
        }, 
		success: function(html) {
			$(".loading").detach();
        	$("#adress_path").html(html);
			$.ajax({
				type:'POST',
				url:'openfolder.jsp',
				beforeSend: function () {
					$('#user_right').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
				}, 
				success: function(html) {
					$(".loading").detach();
					$("#user_right").html(html);
					$.ajax({
						type:'POST',
						url:'showfoldertree.jsp',
						beforeSend: function () {
							$('#user_left').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
						}, 
						success: function(html) {
							$(".loading").detach();
							$("#user_left").html(html);
					}});
   	 		}});
    }});
	return false;
}
function goFolderShare(pathFolder){
	$.ajax({
		type:'POST',
		url:'goFolderShare.jsp?pathFolder='+pathFolder,
		beforeSend: function () {
            $('#adress_path').append('<div class="loading"><img src="img/icon/loading.gif" alt="loading..." /></div>');
        }, 
		success: function(html) {
			$(".loading").detach();
        	$("#adress_path").html(html);
			$.ajax({
				type:'POST',
				url:'openfoldershare.jsp',
				beforeSend: function () {
					$('#user_right').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
				}, 
				success: function(html) {
					$(".loading").detach();
					$("#user_right").html(html);
					$.ajax({
						type:'POST',
						url:'showfoldertreeshare.jsp',
						beforeSend: function () {
							$('#user_left').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
						}, 
						success: function(html) {
							$(".loading").detach();
							$("#user_left").html(html);
					}});
   	 		}});
    }});
	return false;
}
function showUploadForm(){
	        //Getting the variable's value from a link 
        var loginBox = '#uploadFile-box';

        //Fade in the Popup
        $(loginBox).fadeIn(300);
        
        //Set the center alignment padding + border see css style
        var popMargTop = ($(loginBox).height() + 24) / 2; 
        var popMargLeft = ($(loginBox).width() + 24) / 2; 
        
        $(loginBox).css({ 
            'margin-top' : -popMargTop,
            'margin-left' : -popMargLeft
        });
        
        // Add the mask to body
        $('body').append('<div id="mask"></div>');
        $('#mask').fadeIn(300);
	return false;
}
$(document).ready(function() {
	$('a.close2, #mask').click(function() { 
      $('#mask , .uploadFile-popup').fadeOut(300 , function() {
        $('#mask').remove();  
    }); 
    return false;
    });
});
function getDataFile(value){
	var files = $(".myfileupload")[0].files;
	var string = "";
	for (var i = 0; i < files.length; i++){
		if(files[i].size > 50*1024*1024){
			alert(files[i].size);
			string += files[i].name + " is larger than 5Mb!<br />";
		}
		if(i == files.length - 1){
			$.ajax({
				type:'POST',
				url:'hiddenfield.jsp?message='+string,
				beforeSend: function () {
					$('#hiddenField').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
				}, 
				success: function(html) {
					$(".loading").detach();
					$("#hiddenField").html(html);		
			}});
		}
	}
	
}
function option(value, type, path){
	$.ajax({
		type:'POST',
		url:'option.jsp?file='+value+'&type='+type+'&path='+path,
		beforeSend: function () {
            $('#option').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
        }, 
		success: function(html) {
			$(".loading").detach();
        	$("#option").html(html);		
    }});
	$("#option").fadeIn(500);
}
function deleteFolder(name, path){
	$.ajax({
		type:'POST',
		url:'deletefolder.jsp?name='+name+'&path='+path, 
		data:$('#creatnewfolder').serialize(), 
		beforeSend: function () {
            $('#user_right').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
        }, 
		success: function(data) {
			$(".loading").detach();
        	$(document).find('#user_right').html(data);
			$.ajax({
				  type:'POST',
				  url:'showfoldertree.jsp',
				  beforeSend: function () {
					  $('#user_left').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
				  }, 
				  success: function(html) {
					  $(".loading").detach();
					  $("#user_left").html(html);
					  $("#option").fadeOut(500);
			  }});
    }});
    return false;
}
function deleteFile(name, path){
	$.ajax({
		type:'POST',
		url:'deleteFile.jsp?name='+name+'&path='+path, 
		data:$('#creatnewfolder').serialize(), 
		beforeSend: function () {
            $('#user_right').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
        }, 
		success: function(data) {
			$(".loading").detach();
        	$(document).find('#user_right').html(data);
			$.ajax({
				  type:'POST',
				  url:'showfoldertree.jsp',
				  beforeSend: function () {
					  $('#user_left').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
				  }, 
				  success: function(html) {
					  $(".loading").detach();
					  $("#user_left").html(html);
					  $("#option").fadeOut(500);
			  }});
    }});
    return false;
}
function shareFolder(name, keyShare, path){
	$.ajax({
		type:'POST',
		url:'shareFolder.jsp?name='+name+'&keyShare='+keyShare+'&path='+path, 
		beforeSend: function () {
            $('#user_right').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
        }, 
		success: function(html) {
			$(".loading").detach();
			$("#user_right").html(html);
			$.ajax({
				type:'POST',
				url:'option.jsp?file='+name+'&type=0&path='+path,
				beforeSend: function () {
					$('#option').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
				}, 
				success: function(html) {
					$(".loading").detach();
					$("#option").html(html);
					$.ajax({
						type:'POST',
						url:'showfoldertree.jsp',
						beforeSend: function () {
							$('#user_left').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
						}, 
						success: function(html) {
							$(".loading").detach();
							$("#user_left").html(html);
					}});		
			}});
			
			
    }});
    return false;
}
function shareFile(name, keyShare, path){
	$.ajax({
		type:'POST',
		url:'shareFile.jsp?name='+name+'&keyShare='+keyShare+'&path='+path, 
		data:$('#creatnewfolder').serialize(), 
		beforeSend: function () {
            $('#user_right').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
        }, 
		success: function(data) {
			$(".loading").detach();
        	$(document).find('#user_right').html(data);
			$.ajax({
				type:'POST',
				url:'option.jsp?file='+name+'&type=1&path='+path,
				beforeSend: function () {
					$('#option').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
				}, 
				success: function(html) {
					$(".loading").detach();
					$("#option").html(html);		
			}});
			$("#option").fadeIn(500);
			$.ajax({
				  type:'POST',
				  url:'showfoldertree.jsp',
				  beforeSend: function () {
					  $('#user_left').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
				  }, 
				  success: function(html) {
					  $(".loading").detach();
					  $("#user_left").html(html);
					  
			  }});
			
    }});
    return false;
}
function checkName(name){
	$.ajax({
		type:'POST',
		url:'checkName.jsp?name='+name, 
		success: function(html) {
        	$('#showSubmit').html(html);			
    }});
    return false;
}
function submitFormSearch() {
    $.ajax({
		type:'POST',
		url:'search.jsp', 
		data:$('.search').serialize(), 
		beforeSend: function () {
            $('#user_right').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
        }, 
		success: function(data) {
			$(".loading").detach();
        	$(document).find('#user_right').html(data);
			
    }});
    return false;
}
function submitFormSearchShare() {
    $.ajax({
		type:'POST',
		url:'searchShare.jsp', 
		data:$('.search').serialize(), 
		beforeSend: function () {
            $('#user_right').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
        }, 
		success: function(data) {
			$(".loading").detach();
        	$(document).find('#user_right').html(data);
			
    }});
    return false;
}
function renameFolder(name, path) {
    $.ajax({
		type:'POST',
		url:'formrename.jsp?name='+name+'&path='+path, 
		beforeSend: function () {
            $('#option_right_form_rename').append('<div align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</div>');
        }, 
		success: function(html) {
			$(".loading").detach();
        	$('#option_right_form_rename').html(html);
			
    }});
    return false;
}
function submitRename() {
    $.ajax({
		type:'POST',
		url:'renameFolder.jsp', 
		data:$('.rename').serialize(), 
		beforeSend: function () {
            $('#user_right').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
        }, 
		success: function(data) {
			$(".loading").detach();
        	$(document).find('#user_right').html(data);
			$.ajax({
				  type:'POST',
				  url:'showfoldertree.jsp',
				  beforeSend: function () {
					  $('#user_left').append('<p align=center><img src=../img/icon/loading.gif alt=Loading> <BR> Loading...</p>');
				  }, 
				  success: function(html) {
					  $(".loading").detach();
					  $("#user_left").html(html);
					  $("#option").fadeOut(500);
			  }});
    }});
    return false;
}
function checkRename(name, path){
	$.ajax({
		type:'POST',
		url:'checkrename.jsp?name='+name+'&path='+path, 
		success: function(html) {
        	$('#remane_submit').html(html);			
    }});
    return false;
}
function checkEmail(value){
	$.ajax({
		type:'POST',
		url:'checkEmail.jsp?email='+value,
		success: function(html) {
			$("#checkEmail").html(html);
	}});
}
function checkReEmail(value,email){
	$.ajax({
		type:'POST',
		url:'checkConfirmEmail.jsp?email='+email+'&reemail='+value,		
		success: function(html) {
			$("#checkReEmail").html(html);
	}});
}
function checkPass(value){
	$.ajax({
		type:'POST',
		url:'checkPass.jsp?pass='+value,		
		success: function(html) {
			$("#checkPass").html(html);
	}});
}
function checkRePass(value,pass){
	$.ajax({
		type:'POST',
		url:'confirmPass.jsp?pass='+pass+'&repass='+value,		
		success: function(html) {
			$("#checkRePass").html(html);
	}});
}
function closeOption(){
	$("#option").hide(200);
	$("input[name=radiofile]").attr("checked", false);
}