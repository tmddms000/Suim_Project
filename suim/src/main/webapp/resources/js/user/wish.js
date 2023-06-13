	function heart(id, hno) {
		var type = "unlike" // 하트가 칠해져 있다면 "unlike", 칠해져 있지 않다면 "like" 지정
		
	    $.ajax({
	        url: "/heart.ho", // 서블릿으로 전송
	        type: "get",
	        data: {
	            hno: hno, // 메뉴번호랑 타입(like, unlike) 전달
	            type: type,
	            id : id
	        },
	        success: function(response) {
	            if (response === "success") { // 성공적인 응답일 경우
	            	toastr.success("성공");
	            	$("tr[data-id='" + hno + "']").remove();
	            	var listSize = parseInt($("#listSize").text());
	                listSize--;
	                $("#listSize").text(listSize);
	                if (listSize === 0) {
	                    var messageRow = '<tr><td colspan="8" class="text-center">작성된 게시글이 없습니다.</td></tr>';
	                    $("tbody").append(messageRow);
	                }
	          }
	        },
	        });
	      }