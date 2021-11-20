module.exports = {

    // Success
    SUCCESS : { "isSuccess": true, "code": 1000, "message":"성공" },
    FAILURE : { "isSuccess": true, "code": 1001, "message":"실패" },
    USER_STATUS_UPDATE_SUCCESS : { "isSuccess": true, "code": 1002, "message":"유저 상태값 변경 성공" },
    USER_DELETE_SUCCESS : { "isSuccess": true, "code": 1003, "message":"회원 탈퇴 성공" },
    DIARY_SELECT_SUCCESS : { "isSuccess": true, "code": 1004, "message":"다이어리 조회 성공" },
    DIARY_POSTING_SUCCESS : { "isSuccess": true, "code": 1005, "message":"다이어리 등록 성공" },
    DIARY_UPDATE_SUCCESS  : { "isSuccess": true, "code": 1006, "message":"다이어리 수정 성공" },
    DIARYIMG_UPDATE_SUCCESS : { "isSuccess": true, "code": 1007, "message":"다이어리 이미지 수정 성공" },
    USER_COMBACK_SUCCESS : { "isSuccess": true, "code": 1008, "message":"회원 복귀 성공" },
    DIARY_TODAY_VIEW_SUCCESS : { "isSuccess": true, "code": 1009, "message":"오늘 날짜 다이어리 조회 성공" },
    DIARY_RECENT_VIEW_SUCCESS : { "isSuccess": true, "code": 1010, "message":"최신 날짜 다이어리 조회 성공" },
    HOME_COLOR_POSTING_SUCCESS : { "isSuccess": false, "code": 1011, "message": "홈컬러 등록 완료" },
    USER_COLOR_UPDATE_SUCCESS : { "isSuccess": false, "code": 1012, "message": "유저 컬러 변경 완료" },

    // Common
    TOKEN_EMPTY : { "isSuccess": false, "code": 2000, "message":"JWT 토큰을 입력해주세요." },
    TOKEN_VERIFICATION_FAILURE : { "isSuccess": false, "code": 3000, "message":"JWT 토큰 검증 실패" },
    TOKEN_VERIFICATION_SUCCESS : { "isSuccess": true, "code": 1008, "message":"JWT 토큰 검증 성공" }, // ?

    //Request error
    SIGNUP_EMAIL_EMPTY : { "isSuccess": false, "code": 2001, "message":"이메일을 입력해주세요" },
    SIGNUP_EMAIL_LENGTH : { "isSuccess": false, "code": 2002, "message":"이메일은 30자리 미만으로 입력해주세요." },
    SIGNUP_EMAIL_ERROR_TYPE : { "isSuccess": false, "code": 2003, "message":"이메일을 형식을 정확하게 입력해주세요." },
    SIGNUP_PASSWORD_EMPTY : { "isSuccess": false, "code": 2004, "message": "비밀번호를 입력 해주세요." },
    SIGNUP_PASSWORD_LENGTH : { "isSuccess": false, "code": 2005, "message":"비밀번호는 6~20자리를 입력해주세요." },
    SIGNUP_NICKNAME_EMPTY : { "isSuccess": false, "code": 2006, "message":"닉네임을 입력 해주세요." },
    SIGNUP_NICKNAME_LENGTH : { "isSuccess": false,"code": 2007,"message":"닉네임은 최대 20자리를 입력해주세요." },

    SIGNIN_EMAIL_EMPTY : { "isSuccess": false, "code": 2008, "message":"이메일을 입력해주세요" },
    SIGNIN_EMAIL_LENGTH : { "isSuccess": false, "code": 2009, "message":"이메일은 30자리 미만으로 입력해주세요." },
    SIGNIN_EMAIL_ERROR_TYPE : { "isSuccess": false, "code": 2010, "message":"이메일을 형식을 정확하게 입력해주세요." },
    SIGNIN_PASSWORD_EMPTY : { "isSuccess": false, "code": 2011, "message": "비밀번호를 입력 해주세요." },

    USER_USERID_EMPTY : { "isSuccess": false, "code": 2012, "message": "userId를 입력해주세요." },
    USER_USERID_NOT_EXIST : { "isSuccess": false, "code": 2013, "message": "해당 회원이 존재하지 않습니다." },

    USER_USEREMAIL_EMPTY : { "isSuccess": false, "code": 2014, "message": "이메일을 입력해주세요." },
    USER_USEREMAIL_NOT_EXIST : { "isSuccess": false, "code": 2015, "message": "해당 이메일을 가진 회원이 존재하지 않습니다." },
    USER_ID_NOT_MATCH : { "isSuccess": false, "code": 2016, "message": "유저 아이디 값을 확인해주세요" },
    USER_NICKNAME_EMPTY : { "isSuccess": false, "code": 2017, "message": "변경할 닉네임 값을 입력해주세요" },
    USER_STATUS_EMPTY : { "isSuccess": false, "code": 2018, "message": "회원 상태값을 입력해주세요" },
    SIGNIN_PASSWORD_ERROR_TYPE : { "isSuccess": false, "code": 2019, "message":"비밀번호 형식을 정확하게 입력해주세요." },
    USER_STATUS_EMPTY : { "isSuccess": false, "code": 2020, "message": "회원 탈퇴 여부를 입력해주세요." },
    SIGNIN_COLOR_ERROR_TYPE : { "isSuccess": false, "code": 2021, "message":"컬러 형식을 정확하게 입력해주세요." },
    USER_DIARYID_EMPTY : { "isSuccess": false, "code": 2022, "message": "diaryId를 입력해주세요." },
    USER_ID_DIARYID_NOT_MATCH : { "isSuccess": false, "code": 2023, "message": "해당 유저 아이디가 작성한 다이어리가 아닙니다." },
    DIARY_COLOR_EMPTY : { "isSuccess": false, "code": 2024, "message": "색상을 입력해주세요." },
    DIARY_COLORNAME_EMPTY : { "isSuccess": false, "code": 2025, "message": "감정색상 이름을 입력해주세요." },
    DIARY_CONTENT_EMPTY : { "isSuccess": false, "code": 2026, "message": "오늘의 다이어리를 입력해주세요." },
    DIARY_RECORDCONTENT_EMPTY : { "isSuccess": false, "code": 2027, "message": "오늘의 녹음 다이어리를 입력해주세요." },
    DIARY_COLORNAME_LENGTH : { "isSuccess": false, "code": 2028, "message": "감정 색상 제목은 100자 이내로 작성해 주세요." },
    DIARY_DIARYIMG_EMPTY : { "isSuccess": false, "code": 2029, "message": "사진을 입력해주세요" },
    SIGNUP_DATE_ERROR_TYPE : { "isSuccess": false, "code": 2030, "message":"날짜 형식을 정확하게 입력해주세요." },
    USER_DIARYIMGID_EMPTY : { "isSuccess": false, "code": 2031, "message":"다이어리 이미지 인덱스 값을 입력해 주세요." },
    USER_DIARYIMG_NOT_EXIST : { "isSuccess": false, "code": 2032, "message":"일치하는 다이어리 이미지 값이 없습니다." },


    // Response error
    SIGNUP_REDUNDANT_EMAIL : { "isSuccess": false, "code": 3001, "message":"중복된 이메일입니다." },
    SIGNUP_REDUNDANT_NICKNAME : { "isSuccess": false, "code": 3002, "message":"중복된 닉네임입니다." },

    SIGNIN_EMAIL_WRONG : { "isSuccess": false, "code": 3003, "message": "이메일이 잘못 되었습니다." },
    SIGNIN_PASSWORD_WRONG : { "isSuccess": false, "code": 3004, "message": "비밀번호가 잘못 되었습니다." },
    SIGNIN_INACTIVE_ACCOUNT : { "isSuccess": false, "code": 3005, "message": "비활성화 된 계정입니다. 고객센터에 문의해주세요." },
    SIGNIN_WITHDRAWAL_ACCOUNT : { "isSuccess": false, "code": 3006, "message": "탈퇴 된 계정입니다. 고객센터에 문의해주세요." },
    AUTH_EMAIL_EMPTY : { "isSuccess": false, "code": 3007, "message": "인증받을 이메일을 입력해주세요." },
    AUTH_EMAIL_LENGTH : { "isSuccess": false, "code": 3008, "message":"인증받을 이메일은 30자리 미만으로 입력해주세요." },
    AUTH_EMAIL_ERROR_TYPE : { "isSuccess": false, "code": 3009, "message":"인증받을 이메일의 형식을 정확하게 입력해주세요." },
    KAKAO_TOKEN_EMPTY : { "isSuccess": false, "code": 3009, "message":"kakao 토큰 값을 입력해주세요." },
    NOT_LOGIN : { "isSuccess": false, "code": 3010, "message": "로그인된 계정이 없습니다." },
    SIGNIN_JWT_TOKEN_NOT_EXIST : { "isSuccess": false, "code": 3011, "message": "입력된 JWT TOKEN이 없습니다." },
    ACCESS_TOKEN_EMPTY : { "isSuccess": false, "code": 3012, "message": "입력된 ACCESS TOKEN이 없습니다." },
    ACCESS_TOKEN_ERROR : { "isSuccess": false, "code": 3013, "message": "유효하지 않은 ACCESS TOKEN입니다." },
    SENDING_TEMPORARY_EMAIL_FAILED : { "isSuccess": false, "code": 3014, "message": "임시 비밀번호 발급 이메일 전송 실패" },
    CHECK_MINI_STATUSCODE : { "isSuccess": false, "code": 3015, "message": "2차 비밀번호 설정값을 on으로 변경해주세요." },
    HOME_COLOR_ALREADY_DONE : { "isSuccess": false, "code": 3016, "message": "홈컬러가 이미 설정되었습니다." },
    USER_DIARY_NOT_EXIST :  { "isSuccess": false, "code": 3018, "message": "등록된 감정색이 없습니다." },
    USER_DATE_EMPTY : { "isSuccess": false, "code": 3020, "message": "입력된 DATE값이 없습니다." },
    USER_DATEID_EMPTY : { "isSuccess": false, "code": 3021, "message": "입력된 DATEID값이 없습니다." },
    DIARY_NOT_EXIST : { "isSuccess": false, "code": 3021, "message": "기록된 DIARY가 없습니다." },
    DIARY_IMAGE_NOT_EXIST : { "isSuccess": false, "code": 3021, "message": "기록된 DIARY IMG가 없습니다." },
    SIGNIN_WITHDRAWAL_ACCOUNT : { "isSuccess": false, "code": 3022, "message": "탈퇴된 계정입니다." },
    ALREADY_LOGIN : { "isSuccess": false, "code": 3023, "message": "이미 로그인된 상태 입니다." },
    SIGNUP_MINICODE_LENGTH : { "isSuccess": false, "code": 3024, "message": "미니코드는 4자리 숫자로 입력해 주세요" },
    USER_MINICODE_EMPTY : { "isSuccess": false, "code": 3025, "message": "미니코드를 입력해주세요." },
    KAKAO_SIGNIN_ERROR : { "isSuccess": false, "code": 3026, "message": "카카오 로그인 실패" },
    AUTH_EMAIL_LENGTH : { "isSuccess": false, "code": 3027, "message":"입력한 감정색 이름은 100자리 미만으로 입력해주세요." },
    DIARY_ALREADY_EXIST : { "isSuccess": false, "code": 3028, "message":"해당 날자의 다이어리가 이미 존재합니다." },
    USER_ID_DIARYIMGID_NOT_MATCH : { "isSuccess": false, "code": 3029, "message":"로그인 계정과 다이어리 이미지 계정이 일치하지 않습니다." },
    DIARY_DIARYIMGURL_EMPTY : { "isSuccess": false, "code": 3030, "message":"다이어리 이미지 주소값을 입력해 주세요." },
    NO_HISTORY_DATA : { "isSuccess": false, "code": 3031, "message":"기존에 입력한 감정 데이터가 없습니다." },
    DIARYID_OUT_OF_RANGE : { "isSuccess": false, "code": 3032, "message":"다이어리 인덱스 값이 전체 다이어리 범위를 넘었습니다." },
    CALENDER_OUT_OF_RANGE : { "isSuccess": false, "code": 3033, "message":"조회하신 page는 전체 달력 범위를 넘었습니다. 2021년 ~ 2031년" },
    DIARYIMGID_OUT_OF_RANGE : { "isSuccess": false, "code": 3034, "message":"다이어리 이미지 인덱스 값이 전체 다이어리 범위를 넘었습니다." },

    //Connection, Transaction 등의 서버 오류
    DB_ERROR : { "isSuccess": false, "code": 4000, "message": "데이터 베이스 에러"},
    SERVER_ERROR : { "isSuccess": false, "code": 4001, "message": "서버 에러"},
 
 
}