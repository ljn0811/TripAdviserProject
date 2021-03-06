<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/views/common/header.jsp" %>
<%
	String id = "admin";	//세션에서 로그인한 사용자의 객체를 불러와서 초기화할예정 임시로 스트링객체선언
%>
<script>
    function fn_comment_confirm() {
        var comment = $('textarea[name=comment]').val();
        
        if(comment.trim().length == 0) {
            alert("코멘트 내용을 입력해주세요.");
            return false;
        }
        else {
            var conf = confirm("코멘트 작성을 하시겠습니까?");
            if(conf == true) {
            return true;
            }
            else {
                return false;
            }
        }
    }

    function fn_scrap(trvNo) {
        var conf = confirm("이 여행상품을 마이스크랩에 담으시겠습니까?");

        if(conf == true) {
            location.href = "<%=request.getContextPath() %>/myPage/scrap?trvNo=" + trvNo;
        }
    }

    function fn_modify() {
        //상품수정서블릿으로 연결
        location.href = "<%=request.getContextPath() %>/travel/travelModify?trvNo=1";
    }

    function fn_delete() {
        var conf = confirm("이 여행상품을 삭제하시겠습니까?");

        if(conf == true) {
            location.href = "<%=request.getContextPath() %>/travel/travelDelete?trvNo=1";
        }
    }

    function fn_comment_modify(commentNo) {
        var selNo = commentNo + 1;
        console.log(selNo);
        //$("#travel-comment-container .comment-container:nth-child(" + selNo + ") .comment-content p:nth-child(2)").attr("hidden = 'hidden'");
        //$("#travel-comment-container .comment-container:nth-child(" + selNo + ") .comment-content table").removeAttr("hidden");
        $("#travel-comment-container .comment-container .comment-content p").attr("hidden");
        $("#travel-comment-container .comment-container:nth-child(4) .comment-content table").removeAttr("hidden");
    }

    function fn_comment_delete(commentNo) {
        var conf = confirm("이 코멘트를 삭제하시겠습니까?");

        if(conf == true) {
            location.href = "<%=request.getContextPath() %>/travel/commentDelete?commentNo=" + commentNo;
        }
    }
</script>
<style>
	#travel-comment-container .comment-container:nth-child() {
	
}
</style>
<section id='travel-detail-container'>
    <article id='travel-product-container'>
        <div id='travel-album'>
            <img id="represent" src="<%=request.getContextPath() %>/images/test.png" width="440px" height="268px" style="margin-bottom: 8px;" />
        </div>
        <div id='travel-intro-container'>
        	<div id='travel-title'>
        		<h1>여행제목</h1><div style="display: inline-block; margin-left: 120px;"><sub>조회수: 22532</sub></div>
        	</div>
        	<div id='travel-evul'>
        		<h5>★ <span>4.3</span>평점</h5>
        	</div>
        	<div id='travel-date'>
        		<p>06.23 ~ 09.01</p>
        	</div>
        	<div id='travel-address'>
        		<p>ㅇㅇㅇ도 ㅇㅇ시 ㅇㅇ동 888-22</p>
        	</div>
        	<div id='travel-price'>
        		<p><span hidden="hidden">가격: 000000원(숙박카테고리만)</span>&nbsp;</p>
        	</div>
        	<div id='travel-review'>
        		<p>리뷰글영역</p>
        	</div>
        	<div id='travel-btn'>
        		<button onclick="fn_scrap()" class="btn btn-primary">스크랩</button>
        		<%if(id.equals("admin") || id.equals("trvWriter")) {//여행상품작성자 본인으로 로그인해있거나 관리자로 로그인했을시 버튼생성%>
        		<div>
        			<button onclick="fn_modify()" class="btn btn-light">상품수정</button>
        			<button onclick="fn_delete()" class="btn btn-light">상품삭제</button>
        		</div>
        		<%} %>
        	</div>
        </div>
        <div id="google-map">
            google-map-container
        </div>
    </article>
    <hr />
    
    <!-- <article id='travel-description'>
        본문(여행상품세부묘사)
        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
    </article>
     -->
    
    <article id='travel-comment-container'>
    	<form action="<%=request.getContextPath() %>/travel/inputComment" method="post" class="form-inline" onsubmit="return fn_comment_confirm()">
			평점 :&nbsp;<input type="radio" name="evaluation" id="star1" value="1" />
			<label for="star1">★</label>&nbsp;
			<input type="radio" name="evaluation" id="star2"  value="2" />
			<label for="star2">★★</label>&nbsp;
			<input type="radio" name="evaluation" id="star3" value="3" />
			<label for="star3">★★★</label>&nbsp;
			<input type="radio" name="evaluation" id="star4" value="4" />
			<label for="star4">★★★★</label>&nbsp;
			<input type="radio" name="evaluation" id="star5" value="5" checked /> 
			<label for="star5">★★★★★</label>
			<br>
			<label class="sr-only" for="comment">Comment</label>
			<div id='travel-comment-input-container' style="display: flex;">
				<div style="display:inline-block;">
					<textarea name="comment" class="form-control" style="max-width: 657px; height: 100%; margin: 0;" cols="70" rows="2" maxlength="100" placeholder="코멘트입력"></textarea>
				</div>
				<div style="display: inline-block;">
					<div style="display: block;">&nbsp;</div>
					<div style="display:inline-block;"><input type="submit" class="btn btn-light" value="코멘트작성" /></div>
				</div>
			</div>
		</form>
		<hr />
		<!-- 세션아이디랑 코멘트작성자와 비교해서 맞거나 admin계정이면 hidden삭제 아니면 hidden속성추가해서 넣기  -->
		<%if(1>0) {	//이 여행상품에 코멘트가있을시 값들을 로드한다.%>
		<%for(int i=0; i<4; i++) {%>
			<div class="comment-container">
				<div class='comment-profile'>
					<img src="<%=request.getContextPath() %>/images/travel_detail_imgs/profile_default.gif" alt="" width="74px" height="84px" style="margin: 1px" />
					<div class="comment-writer"><span>isaia11</span></div>
				</div>
				<div class="comment-date">
					<span><sub>2019.02.09</sub></span>
				</div>
				<div class="comment-content">
					<p>★</p>
					<p>	테스트코멘트테스트코멘트테스트코멘트테스트코멘트테스트코멘트테스트코멘트테스트코멘트테스트코멘트테스트코멘트테스트코멘트테스트코멘트테스트코멘트테스트코멘트테스트코멘트테스트코멘트테스트코멘트테스트코멘트테스트코멘트</p>
					<table hidden>
						<tr>
							<td rowspan="2">
								<textarea name="comment" class="form-control" cols="70" rows="2" maxlength="100" placeholder="코멘트입력"></textarea>
							</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td><input type="submit" class="btn btn-light" value="코멘트수정" /></td>
						</tr>
					</table>
				</div>
				<div class="comment-btn-container">
					<p>&nbsp;</p>
					<%if(id.equals("admin") || id.equals("commentWriter")) {//로그인한사용자가 코멘트작성자 이거나 관리자일시 버튼생성%>
					<div class="comment-btn">
						<button class='btn btn-primary' onclick="fn_comment_modify(<%=i %>)">수정</button> <button class='btn btn-light' onclick="fn_comment_delete(<%=i %>)">삭제</button>
					</div>
					<%} else{ %>
					<span class="comment-btn">
						&nbsp;
					</span>
					<%} %>
				</div>
			</div>
		<%} %>
		<div class="comment-container">
			<div class='comment-profile'>
				<img src="<%=request.getContextPath() %>/images/travel_detail_imgs/profile_default.gif" alt="" width="74px" height="84px" style="margin: 1px" />
				<div class="comment-writer">admin</div>
			</div>
			<div class="comment-date">
				<span><sub>2019.02.09</sub></span>
			</div>
			<div class="comment-content">
				<p>★</p>
				<p>코멘트 틀</p>
			</div>
			<div class="comment-btn-container">
				<p>&nbsp;</p>
				<%if(id.equals("admin") || id.equals("commentWriter")) {%>
					<span class="comment-btn">
						<button class='btn btn-primary' onclick="fn_comment_modify(5)">수정</button> <button class='btn btn-light' onclick="fn_comment_delete(5)">삭제</button>
					</span>
					<%} else{ %>
					<span class="comment-btn">
						&nbsp;
					</span>
				<%} %>
			</div>
		</div>
		<nav id="pageBar">
			<ul class="pagination justify-content-center">
				<li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
				<li class="page-item"><a class="page-link" href="#">1</a></li>
				<li class="page-item"><a class="page-link" href="#">2</a></li>
				<li class="page-item"><a class="page-link" href="#">3</a></li>
				<li class="page-item"><a class="page-link" href="#">4</a></li>
				<li class="page-item"><a class="page-link" href="#">5</a></li>
				<li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
			</ul> 
		</nav>
		<%} %>
    </article>
</section>


<%@ include file="/views/common/footer.jsp" %>