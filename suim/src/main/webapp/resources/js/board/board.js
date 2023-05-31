
// 검색어 삭제 버튼을 클릭할 때 이벤트를 추가합니다.
document.getElementById("search_init").addEventListener("click", function() {
  // keyword 입력 필드를 찾아옵니다.
  var keywordInput = document.getElementById("keyword");
  
  // keyword 입력 필드의 값을 비웁니다.
  keywordInput.value = "";
});

// 검색어 입력 필드에 마우스를 가져다 놓을 때 이벤트를 추가합니다.
document.getElementById("keyword").addEventListener("mouseover", function() {
  // 검색어 삭제 버튼을 찾아옵니다.
  var deleteButton = document.getElementById("search_init");
  
  // 검색어 삭제 버튼을 보이도록 설정합니다.
  deleteButton.style.display = "block";
});

// 검색어 입력 필드에서 마우스를 떼었을 때 이벤트를 추가합니다.
document.getElementById("keyword").addEventListener("mouseout", function() {
  // 검색어 삭제 버튼을 찾아옵니다.
  var deleteButton = document.getElementById("search_init");
  
  // 검색어 삭제 버튼을 숨깁니다.
  deleteButton.style.display = "none";
});


// 수정하기 버튼과 삭제하기 버튼을 클릭했을 때 실행할 선언적 함수



