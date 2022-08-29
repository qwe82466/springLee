<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


	<!-- header 복붙 -->
	<%@ include file="../includes/header.jsp" %>

		<!-- Page Heading -->
        <h1 class="h3 mb-2 text-gray-800">Board Read</h1><br />
       
        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Board Read Page</h6>
            </div>
            <div class="card-body">
                <div class="mr-3 ml-3 mb-4">
                    <div class="form-group row">
                    	<label>Bno</label>
                        <input type="text" class="form-control" name="bno" value="${board.bno}" readonly="readonly"/>
                    </div>
                    <div class="form-group row">
                    	<label>Title</label>
                        <input type="text" class="form-control" name="title" value="${board.title}" readonly="readonly"/>
                    </div>
                    <div class="form-group row">
                    	<label>Content</label>
                    	<textarea class="form-control" rows="3" name="content" readonly="readonly">${board.content}</textarea>
                    </div>
                    <div class="form-group row">
                    	<label>Writer</label>
                        <input type="text" class="form-control" name="writer" value="${board.writer}" readonly="readonly"/>
                    </div>
                </div>
                <div class="mr-1 ml-1">
                	<button class="btn btn-warning" data-service="modify">Modify</button>
                	<button class="btn btn-info" data-service="list" >List</button>
                </div>
                
                <form id="btnForm" action="/board/modify" method="get">
                	<input type="hidden" name="bno" value="${board.bno}" id="bno" />
                	<input type="hidden" name="pageNum" value="${cri.pageNum}"  />
                	<input type="hidden" name="listQty" value="${cri.listQty}"  />
                	<input type="hidden" name="sel" value="${cri.sel}"  />
                	<input type="hidden" name="keyword" value="${cri.keyword}"  />
                </form>
                
            </div>
        </div>
        <!--  content 내용물 끝나는 부분  -->
	
		<script type="text/javascript">
		$(document).ready(function(){
			let btnForm = $("#btnForm");
			$("button[data-service='modify']").on("click", function(){
				btnForm.attr("action", "/board/modify").submit(); 
			});
			$("button[data-service='list']").on("click", function(){
				btnForm.find("#bno").remove();	// bno 히든태그 삭제 
				btnForm.attr("action", "/board/list"); // action 속성값 list로 변경
				btnForm.submit(); 
			});
			
		});
		</script>
	
	
	<!-- footer 복붙 -->        
	<%@ include file="../includes/footer.jsp" %>
	