<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- header 복붙 -->
<%@ include file="../includes/header.jsp"%>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800">Board</h1>
<br />

<!-- DataTales Example -->
<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary"
			style="line-height: 2rem">
			Board List Page
			<button id="writeBtn" type="button"
				class="btn btn-primary btn-sm float-right">New Board</button>
		</h6>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>#번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="board" items="${list}">
						<tr>
							<td>${board.bno}</td>
							<td><a class="move" href="${board.bno}">${board.title}</a></td>
							<td>${board.writer}</td>
							<td><fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss"
									value="${board.reg}" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- end table -->


			<!-- 검색 박스  -->
			<div class="row">
				<div class="col-lg-6">
					<form id="searchForm" action="/board/list" method="get">
						<select name="sel">
							<option value="">----</option>
							<option value="T">제목</option>			
							<option value="C">내용</option>
							<option value="W">작성자</option>
							<option value="TC">제목 OR 내용</option>
							<option value="TW">제목 OR 작성자</option>
							<option value="CW">내용 OR 작성자</option>
							<option value="TWC">제목 OR 작성자 OR 내용</option>
						</select> 
							<input type="text" name="keyword" /> 
							<input type="hidden"name="pageNum" value="${pager.cri.pageNum}" />
							<input type="hidden" name="listQty" value="${pager.cri.listQty}" />
						<button class="btn btn-secondary">검색</button>
		<!-- 보드리스트로  -->
					</form>
				</div>
			</div>






			<!--  페이지 번호 Pagination  -->
			<div class="row float-right">
				<div class="col-sm-12 col-md-7">

					<ul class="pagination">
						<c:if test="${pager.prev}">
							<li class="page-item "><a class="page-link" href="${pager.startPage-1}" tabindex="-1">Previous</a></li>
						</c:if>
						<c:forEach var="num" begin="${pager.startPage}" end="${pager.endPage}">
							<li class="page-item ${pager.cri.pageNum == num ? "active":""}">
								<a class="page-link" href="${num}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pager.next}">
							<li class="page-item"><a class="page-link" href="${pager.endPage+1}">Next</a></li>
						</c:if>
					</ul>
				</div>
			</div>

			<form id="pagingForm" action="/board/list">
				<input type="hidden" name="pageNum" value="${pager.cri.pageNum}" />
				<input type="hidden" name="listQty" value="${pager.cri.listQty}" />
				<input type="hidden" name="sel" value="${pager.cri.sel}" /> <input
					type="hidden" name="keyword" value="${pager.cri.keyword}" />
			</form>


			<!--  모달 추가  -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="myModalLabel">Modal title</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">처리가 완료되었습니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
							<button type="button" class="btn btn-primary">Save
								changes</button>
						</div>
					</div>
				</div>
			</div>
			<!-- end 모달 -->



		</div>
	</div>
	<!-- end cardbody -->
</div>
<!--  content 내용물 끝나는 부분  -->

<!-- footer 복붙 -->
<%@ include file="../includes/footer.jsp"%>

<script type="text/javascript">
	$(document)
			.ready(
					function() {

						let result = "${result}";

						modalCheck(result);

						function modalCheck(result) {
							if (result == '') {
								return;
							}
							if (parseInt(result) > 0) { // 값이 있으면 (bno 값 넘겨주니 숫자로 체크)
								$(".modal-body").html(
										"게시글 " + parseInt(result)
												+ "번이 등록되었습니다.");
							}
							$("#myModal").modal("show"); // 모달 띄우기
						}

						// New Board 버튼 이벤트 등록 : 클릭시 글 등록페이지로 이동 
						$("#writeBtn").click(function() {
							self.location = "/board/write";
						});

						// 페이지 번호 누르면 이동하는 처리 
						let pagingForm = $("#pagingForm"); // 숨긴 폼태그 가져오기 
						//pagination class 중 a태그 

						$(".pagination a").on(
								"click",
								function(e) {
									e.preventDefault(); // a 태그의 기본 이동 기능 취소 
									console.log("a click!!click!!!");

									pagingForm.attr("action", "/baord/list")
									// form 태그의 pageNum value 속성값을
									// 이벤트 발생시킨 a태그의 href 속성값으로 변경
									pagingForm.find("input[name='pageNum']")
											.val($(this).attr("href"));
									pagingForm.submit(); //숨긴 폼태그 submit시키기

								});

						//제목클릭시 read로 넘어가는 처리 
						$(".move")
								.on(
										"click",
										function(e) {
											e.preventDefault();
											console.log("move!!!");
											//pagingForm에 히든 input bno 값 추가하기 (태그 동적 생성)

											pagingForm
													.append("<input type='hidden' name='bno' value='"
															+ $(this).attr(
																	"href")
															+ "'/>"); //추가하는거ㅔㅇ요 어레이리스트에 애드~ 뒤로 붙는거에요 뒤로 ! 

											//pagingForm에 action 속성값을 board/read 로 변경
											pagingForm.attr("action",
													"/board/read");
											// submit() 
											pagingForm.submit();
										});

						//검색 폼 처리
						let searchForm = $("#searchForm"); // 1.문서전체를 가져와주세요
						$("#searchForm button").on("click", function(e) { //2.서치폼 내부에 버튼을 클릭하는 순간
									if (!searchForm.find("option:selected") .val()) {//3.셀렉트 안에 밸류를 가져왔는데 없다면.
										alert("검색 종류를 선택하세요..."); //4. 알람띄우기
										return false; //5. submit이동 막기
									}
									if (!searchForm.find( "input[name='keyword']").val()) {//3. 키워드가 없다면
										alert("키워드를 입력해주세요.."); //4. 알람띄우기
										return false; //5. submit이동 막기
									}
									searchForm.find("input[name='pageNum']") .val("1"); //1. 1페이지로 바꾸기
									searchForm.submit();

								});

					});
</script>



