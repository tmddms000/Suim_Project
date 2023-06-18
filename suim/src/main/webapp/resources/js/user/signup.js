  
   	    function validate() {

    	        //아이디 유효성 검사
    	        const idInputEl = document.querySelector('#id');
    	        let regExp = /^[a-z0-9]{6,15}$/;
    	        toastr.options = {
    	                "positionClass": "toast-center-center"
    	            };

    	        if(!regExp.test(idInputEl.value)) {
    	            // alert("아이디를 다시 확인해주세요");
    	            toastr.error("아이디를 다시 확인해주세요");
    	            idInputEl.focus();
    	            return false;
    	        }

    	        //비밀번호 유효성 검사
    	        const pwInputEl = document.querySelector('#password')
    	        let pwRegExp = /^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$/;

    	        if(!pwRegExp.test(pwInputEl.value)) {
    	            // alert("비밀번호를 다시 확인해주세요");
    	            toastr.error("비밀번호를 다시 확인해주세요");
    	            pwInputEl.focus();
    	            return false;
    	        }

    	        //비밀번호 확인 유효성 검사
    	        const pwReInputEl = document.querySelector('#password-check')
    	        if(pwInputEl.value != pwReInputEl.value) {
    	            // alert("비밀번호가 일치하지 않습니다");
    	            toastr.error("비밀번호가 일치하지 않습니다.");
    	            pwReInputEl.focus();
    	            return false;
    	        }


    	    //이름 유효성 검사
    	    const nameInputEl = document.querySelector('#name');
    	    const nameRegExp = /^(?:(?!.*\s{2})[가-힣]|[a-zA-Z])[\s가-힣a-zA-Z]*[가-힣a-zA-Z](?<!\s)$/;

    	    if(!nameRegExp.test(nameInputEl.value)) {
    	        // alert("이름을 다시 확인해주세요");
    	        toastr.error("이름을 다시 확인해주세요");
    	        nameInputEl.focus();
    	        return false;
    	    }

    	    //이메일 유효성 검사
    	    const emailInputEl = document.querySelector('#email');

    	    let emailRegExp = /^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$/;

    	    if(!emailRegExp.test(emailInputEl.value)) {
    	        // alert("이메일을 다시 확인해주세요");
    	        toastr.error("이메일을 다시 확인해주세요");
    	        emailInputEl.focus();
    	        return false;
    	    }

    	    //휴대폰 유효성 검사
    	        // 핸드폰 정규식 검사
    	        const phoneInputEl = document.querySelector('#phone');
    	        const regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;

    	        if(!regPhone.test(phoneInputEl.value)) {
    	            // alert("휴대폰 번호를 다시 확인해주세요");
    	            toastr.error("휴대폰 번호를 다시 확인해주세요");
    	            phoneInputEl.focus();
    	            return false;
    	        }

    	  
    	    //생년월일 유효성 검사
    	    const formattedDate = birthArr.join('');
    	    console.log(formattedDate);
    	    if (formattedDate.includes(-1)) {
    	        // alert("생년월일을 다시 확인해주세요");
    	        toastr.error("생년월일을 다시 확인해주세요");
    	        return false;
    	        };

    	        
    	        return true;
    	    };
    	    
		    //비밀번호 유효성 검사
		    let pwVal = "", pwReVal = "", isPwValid = false
		    const pwInputEl = document.querySelector('#password')
		    const pwErrorMsgEl = document.querySelector('#info_pw')
		    pwInputEl.addEventListener('change', () => {
		    const pwRegExp = /^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$/
		    pwVal = pwInputEl.value
		    if(pwRegExp.test(pwVal)) { // 정규식 조건 만족 O
		        isPwValid = true
		        pwErrorMsgEl.textContent = ""
		    } 
		    else { // 정규식 조건 만족 X
		        isPwValid = false
		        pwErrorMsgEl.textContent = errMsg.pw;
		    }
		    checkPwValid();
		    });
		
		    // 비밀번호 체크 섹션
		    const pwReInputEl = document.querySelector('#password-check')
		    const pwReErrorMsgEl = document.querySelector('#info_pw_check')
		    pwReInputEl.addEventListener('change', () => {
		    pwReVal = pwReInputEl.value
		    checkPwValid();
		    });
		
		    function checkPwValid() {
		  if(pwReVal === "") { // 미입력
		    pwReErrorMsgEl.textContent = ""
		  }
		  else if(pwVal === pwReVal) { // 비밀번호 재입력 일치
		    if(isPwValid) {
		    pwReErrorMsgEl.style.color = 'rgb(113, 197, 98)';
		    pwReErrorMsgEl.textContent = errMsg.pwRe.success;
		    } else {
		    pwReErrorMsgEl.style.color = 'rgba(255,0,0, 0.8)';
		    pwReErrorMsgEl.textContent = errMsg.pwRe.check;
		    }
		    
		  } 
		  else { // 비밀번호 재입력 불일치
		    pwReErrorMsgEl.style.color = 'rgba(255,0,0, 0.8)';
		    pwReErrorMsgEl.textContent = errMsg.pwRe.fail
		  }
		}
		    // 이름 유효성 검사
		    const nameInputEl = document.querySelector('#name');
		    const nameErrorMsgEl = document.querySelector('#info_name');
		    
		    nameInputEl.addEventListener('change', () => {
		    //한글, 영어 이름 가능하게 
		    const nameRegExp = /^(?:(?!.*\s{2})[가-힣]|[a-zA-Z])[\s가-힣a-zA-Z]*[가-힣a-zA-Z](?<!\s)$/;
		    
		
		    if(nameRegExp.test(nameInputEl.value)) {
		        nameErrorMsgEl.style.color = 'rgb(113, 197, 98)';
		        nameErrorMsgEl.textContent = errMsg.name.success;
		    } else {
		        nameErrorMsgEl.style.color = 'rgba(255,0,0, 0.8)';
		        nameErrorMsgEl.textContent = errMsg.name.fail;
		    }
		
		    });

    	    
    	    // 생년월일 유효성검사
    	    const birthYearEl = document.querySelector('#birth-year');
    	    const birthMonthEl = document.querySelector('#birth-month');
    	    const birthDayEl = document.querySelector('#birth-day');
    	    const submitButton = document.querySelector('.submit-btn');

    	        // option list creation check
    	        let isOptionExisted = {
    	        year: false,
    	        month: false,
    	        day: false
    	        };
    	        // [year, month, day]
    	        const birthArr = [-1, -1, -1]
    	        const birthErrorMsgEl = 
    	        document.querySelector('#info__birth .error-msg')

    	        birthYearEl.addEventListener('change', () => {
    	        birthArr[0] = birthYearEl.value
    	        // 유효 날짜 여부 확인
    	        checkBirthValid(birthArr)
    	        });

    	        birthMonthEl.addEventListener('change', () => {
    	        birthArr[1] = birthMonthEl.value
    	        checkBirthValid(birthArr)
    	        });

    	        birthDayEl.addEventListener('change', () => {
    	        birthArr[2] = birthDayEl.value
    	        checkBirthValid(birthArr)
    	        });

    	        /* 유효한 날짜인지 여부 확인 (윤년/평년) */
    	        function checkBirthValid(birthArr) {
    	        isBirthValid = true;
    	        y = birthArr[0]
    	        m = birthArr[1]
    	        d = birthArr[2]
    	        // 생년월일 모두 선택 완료 시
    	        if(y > 0 && m > 0 && d > 0) {
    	            if ((m == 4 || m == 6 || m == 9 || m == 11) && d == 31) { 
    	            isBirthValid = false;
    	            }
    	            else if (m == 2) {
    	            if(((y % 4 == 0) && (y % 100 != 0)) || (y % 400 == 0)) { // 윤년
    	                if(d > 29) { // 윤년은 29일까지
    	                isBirthValid = false;
    	                }
    	            } else { // 평년
    	                if(d > 28) { // 평년은 28일까지
    	                isBirthValid = false;
    	                }
    	            }
    	            }

    	            if(isBirthValid) { // 유효한 날짜
    	            birthErrorMsgEl.textContent = "";
    	            } else { // 유효하지 않은 날짜
    	            birthErrorMsgEl.style.color = 'rgba(255,0,0, 0.8)';
    	            birthErrorMsgEl.textContent = "생년월일을 다시 확인해주세요";
    	            }
    	         }
    	        }

    	        birthYearEl.addEventListener('focus', function () {
    	        // Year options creation (on first click)
    	        if (!isOptionExisted.year) {
				        isOptionExisted.year = true;
				        for (let i = 2023; i >= 1970; i--) {
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
