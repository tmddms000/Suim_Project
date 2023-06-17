// 이벤트 게시판용 js


        $(function() {
            // select 태그 변경 이벤트 리스너
            $("#categorySelect").change(function() {
                var selectedOption = $(this).val(); // 선택한 옵션 값

                // 모든 행을 숨김 처리
                $("#event-table tbody tr").hide();

                if (selectedOption === "") {
                    // 선택한 옵션이 전체 이벤트인 경우 모든 행을 보여줌
                    $("#event-table tbody tr").show();
                } else {
                    // 선택한 옵션에 해당하는 카테고리 행만 보여줌
                    $("#event-table tbody tr").each(function() {
                        var category = $(this).find("td:nth-child(2)").text();
                        if (category === selectedOption) {
                            $(this).show();
                        }
                    });
                }
            });
        });
