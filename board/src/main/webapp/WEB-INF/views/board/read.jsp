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
        
        
     <!-- 댓글 css 약식 -->
        <style> 
           .reply_container {
              margin: 0.5rem auto; 
              display: flex;
              flex-direction: column; 
           }
           .reply_li {
              margin: 1rem 0; 
              display: flex; 
              flex-direction: column;
              width: 100%;
           }
           .replyer_reg_ctn {
              margin: 0.4rem 0; 
              display: flex; 
              flex-direction: row; 
              justify-content: space-between;
              width: 100%; 
           }
           .reply_div {
              font-size: 1rem;
              width: 100%; 
           }
           .replyer_div {
              font-weight: bold;
              font-size: 0.9rem;
           }
           .replyReg_div {
              font-size: 0.7rem; 
           }
           .reply_inputbox {
              display: flex; 
              flex-direction: column;
              font-size: 0.7rem;
              width: 100%; 
           }
           .rbox_div {
              margin: 0.2rem 0; 
                width: 100%; 
           }
        </style>
        
        <!-- 댓글 DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Reply</h6>
            </div>
            <div class="card-body">
                <div class="mr-3 ml-3 mb-4">
                   <div class="reply_container">
                         <div class="reply_li">
                            <div class="replyer_reg_ctn">
                                <div class="replyer_div">replyer </div>
                                <div class="replyReg_div">2022.08.31</div>
                             </div>
                             <div>
                                <div class="reply_div">reply : 댓글내용.......................</div>
                             </div>
                          </div>
                          
                          <div class="reply_li">
                            <div class="replyer_reg_ctn">
                                <div class="replyer_div">replyer </div>
                                <div class="replyReg_div">2022.08.31</div>
                             </div>
                             <div>
                                <div class="reply_div">reply : 댓글내용.......................</div>
                             </div>
                          </div>
                    </div>
                    <hr />
                    <div class="reply_inputbox form-group">
                         <div class="rbox_div"><textarea class="form-control" rows="3" name="reply"  id ="reply" placeholder="댓글작성.."></textarea></div>
                         <div class="rbox_div"><input type="text" class="form-control" name="replyer" id="replyer" placeholder="작성자"/></div>
                         <div class="rbox_div"><button id="saveReplyBtn" class="btn btn-warning"  type="button">Save Reply</button></div>
                    </div>
                </div>
            </div>
        </div> <!-- end 댓글card -->
	
		<script type="text/javascript">
		$(document).ready(function(){
				let bnoVal = "${board.bno}"; 	//글고유번호 가져옴
				console.log("bnoVal: "+ bnoVal );
				
			showReplyList(); //댓글 목록 가져와 뿌리기 호출
			
			//댓글 목록 가져와 뿌려주기 함수
			function showReplyList() {
				console.log("show reply list 호출!!");
				
				//전체 댓글 가져오기 요청
				$.ajax({
				
						
					type: "GET",
					url : "/reply/list/"+bnoVal + ".json",
					data : {bno: bnoVal},
					success: function(result) {
						console.log("요청성공...");
						console.log(result);
						//onsole.log(result[0].reply);
						
						//sucess 일때만 붙혀줘야함
						makeList(result);
						
					},
					error: function(e) {
						console.log("요청실패...");
						console.log(e);
					}
					
					
					
				});
			}
				
			let replyContainer = $(".reply_container");
				
			function makeList(result){
				console.log("makelist");
				console.log("makelist: "+result.length);
				
				//댓글이 없을 경우
				if(result == null || result.length ==0){
					replyContainer.html("<div class='reply_li'>등록된 댓글이 없습니다..</div>");
					
					return ; //makeList 강제종료
				}
				
				let str ="";
				for(let i=0; i < result.length; i++){
					/*
					
					<div class='reply_li'> <div class='replyer_reg_ctn'>
                    <div class='replyer_div'>replyer </div>
                    <div class='replyReg_div'>2022.08.31</div></div>
                    <div><div class='reply_div'>reply : 댓글내용.......................</div>
					</div></div>
					
					*/
					str +=	"<div class='reply_li'> <div class='replyer_reg_ctn'>";
					str +=  "<div class='replyer_div'>"+result[i].replyer+"</div>";
					str += 	" <div class='replyReg_div'>"+timeFormat(result[i].reg)+"</div></div>";
					str +=  "  <div><div class='reply_div'>reply :"+result[i].reply+"</div></div></div>";
					
				}
				replyContainer.html(str);
				
			}
				
			//시간 함수 :  오늘댓글은 시간, 오늘 이전 댓글은 날짜
			function timeFormat(regVal){
				let today = new Date();
				let diff = today.getTime() -regVal;
				let dateObj = new Date(regVal);
				if(diff < (1000*60*60*24)){ //24h보다 작으면
					let hh = dateObj.getHours();
					let mi = dateObj.getMinutes();
					let ss = dateObj.getSeconds();
					return (hh> 9? "" : "0") + hh + ":"
					+(mi >9 ? "": "0") + mi +":"
					+(ss >9 ? '' : "0") + ss;
				}else{
					let yy =dateObj.getFullYear();
					let mm =dateObj.getMonth() +1;
					let dd =dateObj.getDate();
					return yy + "/" + (mm >9 ? "" : "0") + mm + "/" + (dd >9 ? "": "0")+dd;
				}
			}
				
				
				
				
				
				
			$("#saveReplyBtn").on("click",  function() { // 댓글 저장버튼 이벤트 등록
				//console.log("save button click!!!!!");
				let replyForm= $("replyForm")
				//console.log("replyForm");
				//보낼 데이터 js 객체로 만들기 (제이슨 형태로)
			 	let replyVal = $("#reply").val();
				let replyerVal = $("#replyer").val();
				console.log("replyVal: "+ replyVal )
				console.log("replyerVal: "+ replyerVal)
				//객체화 
				let reqData ={reply: replyVal , replyer: replyerVal, bno: bnoVal}
				console.log("reqData: "+ reqData)
				console.log(reqData)
				$.ajax({
					type : "POST",
					url : "/reply/add",
					data : JSON.stringify(reqData),
					contentType: "application/json;charset=utf-8",
					success : function(result, status, xhr){
						//result = 컨트롤러에서 다시 값 받아주는 것..
						console.log("요청성공!!!!");
						console.log(result);
						console.log(status);
						//댓글작성 누르면 다시 보여주기
						showReplyList();
						
						
					},
					error: function(e) {
						console.log("요청 에러....");
						console.log(e);
					}
					
					
				});
				

			});

		});
		//타입버튼으로 지정해주면 넘어가지 않는다. OR fuction(e) e.priventEvent 해줘야함.
		</script>
	
	
	
	
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
	