<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!-- 헤더 -->
    <%@ include file="../includes/header.jsp" %>  
    
     <h1 class="h3 mb-2 text-gray-800">Board write</h1><br />
       
        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Board Write Page</h6>
            </div>
            <div class="card-body">
	            	<form  id="writeForm" action="/board/write"  method="post">
		                <div class="mr-3 ml-3 mb-4">
		                  
		                    
		                    <div class="form-group row">
		                       <label>title</label>
		                        <input type="text" class="form-control" name="title"  />
		                    </div>
		                    
		                    <div class="form-group row">
		                       <label>content</label>
		                       <textarea rows="3"  class="form-control" name="content" ></textarea>
		                        
		                    </div>
		                    
		                    <div class="form-group row">
		                       <label>writer</label>
		                        <input type="text" class="form-control" name="writer"   />
		                    </div>
		                </div>
		                <div class="mr-3 ml-3 mb-4">
		                	<button type="submit" data-service="write" class="btn btn-warning" >submit</button>
		                	<button type="reset"  class="btn btn-danger" >reset</button>
		                	<button type="button" data-service="list"  class="btn btn-info" >List</button>
                		</div>
		            </form>
            </div>
        </div>
        <!--  content 내용물 끝나는 부분  -->
    
    	<!-- 버튼에 따른 이벤트 처리 스크립트 추가 -->
    	<script type="text/javascript">
    	$(document).ready(function(){
    		let formObj= $("#write
    				Form")	//form 태그 가져오기
    		
    		$("button").on("click", function(e){		
    			e.preventDefault(); 	//기본 동작 취소 (submit 이동기능 취소)	
    			//console.log(e);
    			let service = $(this).data("service");
    			console.log(service);
    			
    			if(service == 'write'){
    				formObj.attr("action","/board/write");	
    			}else if(service == 'list'){
    				//formObj.attr("action","/board/list");
    				self.location = "/board/list";
    				return ;
    			}
    			//js로 폼의 submit 버튼 효과와 동일
    			formObj.submit();
    			
    		});
    	});
    	
    	
    	</script>
    
    
    
    
    
    
    
    
    
    
    <!-- 푸터 -->
    <%@ include file="../includes/footer.jsp" %>  