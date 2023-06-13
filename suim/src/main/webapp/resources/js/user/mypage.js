var birthYear = document.getElementById("birthYear").value;
var birthMonth = document.getElementById("birthMonth").value;
var birthDay = document.getElementById("birthDay").value;

document.getElementById("birth-date-input").value = birthYear + birthMonth + birthDay;

const form = document.getElementById("updateForm");
const birthErrorMsgEl = document.getElementById("info_birth");

form.addEventListener("submit", function (event) {
    event.preventDefault(); // 기본 전송 동작 중지

    const birthArr = [
        document.getElementById("birth-year").value,
        document.getElementById("birth-month").value,
        document.getElementById("birth-day").value
    ];

    // 유효성 검사
    const isBirthValid = checkBirthValid(birthArr);
    if (!isBirthValid) {
        birthErrorMsgEl.style.color = 'rgba(255,0,0, 0.8)';
        birthErrorMsgEl.textContent = "생년월일을 다시 확인해주세요";
        return; // 전송 중지
    }

    // 전송할 작업 수행
    form.submit();
});

function checkBirthValid(birthArr) {
    const y = birthArr[0];
    const m = birthArr[1];
    const d = birthArr[2];

    // 생년월일 모두 선택 완료 시
    if (y > 0 && m > 0 && d > 0) {
        if ((m == 4 || m == 6 || m == 9 || m == 11) && d == 31) {
            return false;
        } else if (m == 2) {
            if (((y % 4 == 0) && (y % 100 != 0)) || (y % 400 == 0)) { // 윤년
                if (d > 29) { // 윤년은 29일까지
                    return false;
                }
            } else { // 평년
                if (d > 28) { // 평년은 28일까지
                    return false;
                }
            }
        }
    }

    return true; // 유효한 날짜
}

const birthYearEl = document.getElementById("birth-year");
const birthMonthEl = document.getElementById("birth-month");
const birthDayEl = document.getElementById("birth-day");

const isOptionExisted = {
    year: false,
    month: false,
    day: false
};


birthYearEl.addEventListener('focus', function () {
    // Year options creation (on first click)
    if (!isOptionExisted.year) {
        isOptionExisted.year = true;
        for (let i = 2004; i >= 1960; i--) {
            const yearOption = document.createElement('option');
            yearOption.setAttribute('value', i);
            yearOption.innerText = i;
            birthYearEl.appendChild(yearOption);
        }
    }
});

birthMonthEl.addEventListener('focus', function () {
    // Month options creation (on first click)
    if (!isOptionExisted.month) {
        isOptionExisted.month = true;
        for (let i = 1; i <= 12; i++) {
            const monthOption = document.createElement('option');
            const month = i < 10 ? '0' + i : i;
            monthOption.setAttribute('value', month);
            monthOption.innerText = month;
            birthMonthEl.appendChild(monthOption);
        }
    }
});

birthDayEl.addEventListener('focus', function () {
    // Day options creation (on first click)
    if (!isOptionExisted.day) {
        isOptionExisted.day = true;
        for (let i = 1; i <= 31; i++) {
            const dayOption = document.createElement('option');
            const day = i < 10 ? '0' + i : i;
            dayOption.setAttribute('value', day);
            dayOption.innerText = day;
            birthDayEl.appendChild(dayOption);
        }
    }
});

const birthArr = [birthYear, birthMonth, birthDay];

birthYearEl.addEventListener('change', () => {
    birthArr[0] = birthYearEl.value;
    updateBirthDate();
});

birthMonthEl.addEventListener('change', () => {
    birthArr[1] = birthMonthEl.value;
    updateBirthDate();
});

birthDayEl.addEventListener('change', () => {
    birthArr[2] = birthDayEl.value;
    updateBirthDate();
});

function updateBirthDate() {
    const birthDateInput = document.querySelector('#birth-date-input');
    const formattedDate = birthArr.join('');
    birthDateInput.value = formattedDate;
}
	
	
	
	
	    function searchAddr() {
	    var themeObj = {
	   //bgColor: "", //바탕 배경색
	   //searchBgColor: "#black", //검색창 배경색
	   //contentBgColor: "", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
	   //pageBgColor: "", //페이지 배경색
	   //textColor: "", //기본 글자색
	   queryTextColor: "#black" //검색창 글자색
	   //postcodeTextColor: "", //우편번호 글자색
	   //emphTextColor: "", //강조 글자색
	   //outlineColor: "", //테두리
	    };
	
	    var width = 500; 
	    var height = 600; 
	
	
	    new daum.Postcode({
	
	        width: width, 
	        height: height,
	
		oncomplete : function(data) {
	
	
	        var addr = ''; // 주소 변수
	        var extraAddr = ''; // 참고항목 변수
	
	        if (data.userSelectedType === 'R') {
	            addr = data.roadAddress;
	        } else { 
	            addr = data.jibunAddress;
	        }
	
	        if(data.userSelectedType === 'R'){
	
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraAddr += data.bname;
	            }
	            if(data.buildingName !== '' && data.apartment === 'Y'){
	                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	
	            if(extraAddr !== ''){
	                extraAddr = ' (' + extraAddr + ')';
	            }
	
	            document.getElementById("area").value = extraAddr;
	
	        } else {
	            document.getElementById("area").value = '';
	        }
	
	        //document.getElementById('zipCode').value = data.zonecode;
	        document.getElementById("area").value = addr;
	        document.getElementById("area").focus();
	
	
		}
	    , theme: themeObj
	    }).open({
	        left: (window.screen.width / 2) - (width / 2),
	        top: (window.screen.height / 2) - (height / 2)
	    });
	};
	
	
	var profileImg = document.getElementById("profile_img2");
	
	//Add event listener for file input change
	document.getElementById("drop_profile_img2").addEventListener("change", function(event) {
	// Get the selected file
	var file = event.target.files[0];
	
	// Create a FileReader object to read the file
	var reader = new FileReader();
	
	// Set up the onload event handler
	reader.onload = function(e) {
	 // Set the image source to the loaded data URL
	 profileImg.style.backgroundImage = "url(" + e.target.result + ")";
	};
	
	// Read the file as a data URL
	reader.readAsDataURL(file);
	});

function checkPhoneDuplicate(phone) {
	  return $.ajax({
	    url: "/member/emailCheck",
	    type: "post",
	    data: {
	      phone: phone
	    }
	  });
	}

