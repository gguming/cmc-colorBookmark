const jwtMiddleware = require("../../../config/jwtMiddleware");
const userProvider = require("../../app/User/userProvider");
const userService = require("../../app/User/userService");
const baseResponse = require("../../../config/baseResponseStatus");
const {response, errResponse} = require("../../../config/response");
const { smtpTransport } = require('../../../config/email');
const {logger} = require("../../../config/winston");
const passport = require('passport')
const KakaoStrategy = require('passport-kakao').Strategy
const axios = require('axios');
const {emit} = require("nodemon");
const crypto = require("crypto");
const nodemailer = require("nodemailer");

const regPassword = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}/;
const regexEmail = require("regex-email");
const {check} = require("./userController");
const regPhoneNumber = /^\d{3}\d{3,4}\d{4}$/;


/**
 * API No. 0
 * API Name : 테스트 API
 * [GET] /app/test
 */
exports.getTest = async function (req, res) {
    return res.send(response(baseResponse.SUCCESS))
}

/**
 * API No. 1
 * API Name : 유저 생성 (회원가입) API
 * [POST] /app/users
 */
exports.postUsers = async function (req, res) {

    /**
     * Body: email, password, nickname
     */
    const {email, password, nickname} = req.body;

    // 빈 값 체크
    if (!email)
        return res.send(response(baseResponse.SIGNUP_EMAIL_EMPTY));
    if (!password)
        return res.send(response(baseResponse.SIGNUP_PASSWORD_EMPTY));
    if (!nickname)
        return res.send(response(baseResponse.SIGNUP_NICKNAME_EMPTY));

    // 길이 체크
    if (email.length > 30)
        return res.send(response(baseResponse.SIGNUP_EMAIL_LENGTH));
    if (password.length < 7 || password.length > 20) {
        return res.send(response(baseResponse.SIGNUP_PASSWORD_LENGTH));
    }

    // 형식 체크 (by 정규표현식)
    if (!regexEmail.test(email))
        return res.send(response(baseResponse.SIGNUP_EMAIL_ERROR_TYPE));

    // 기타 등등 - 추가하기

    const signUpResponse = await userService.createUser(
        email,
        password,
        nickname
    );

    return res.send(signUpResponse);
};

/**
 * API No. 2
 * API Name : 로그인 API
 * [POST] /app/login
 * body : email, passsword
 */
exports.login = async function (req, res) {

    const {email, password} = req.body;

    if (!email)
        return res.send(response(baseResponse.SIGNUP_EMAIL_EMPTY));
    if (!password)
        return res.send(response(baseResponse.SIGNUP_PASSWORD_EMPTY));

    if (!regexEmail.test(email))
        return res.send(response(baseResponse.SIGNUP_EMAIL_ERROR_TYPE));

    // if(!regPassword.test(password))
    //     return res.send(errResponse(baseResponse.SIGNUP_PASSWORD_ERROR_TYPE));

    // 길이 체크
    if (email.length > 30)
        return res.send(response(baseResponse.SIGNUP_EMAIL_LENGTH));
    if (password.length < 7 || password.length > 20) {
        return res.send(response(baseResponse.SIGNUP_PASSWORD_LENGTH));
    }


    const signInResponse = await userService.postSignIn(email, password);

    return res.send(signInResponse);
};

// 이메일 중복체크 api
exports.emailCheck = async function (req, res) {

    const email = req.query.email;

    if (!email)
        return res.send(response(baseResponse.SIGNUP_EMAIL_EMPTY));

    if (!regexEmail.test(email))
        return res.send(response(baseResponse.SIGNUP_EMAIL_ERROR_TYPE));

    const emailRows = await userProvider.emailCheck(email);
    console.log(emailRows.length)

    if (emailRows.length >= 1){
        return res.send(response(baseResponse.FAILURE));
    }
    return res.send(response(baseResponse.SUCCESS));
};


/**
    API No. 3
    API Name : 로그아웃 API
    [GET] /app/logout
*/
exports.logOut = async function(req, res) {
    const userIdFromJWT = req.verifiedToken.userId;

    const token = req.headers['x-access-token'];
    const checkJWT = await userProvider.checkJWT(userIdFromJWT);
    if (checkJWT.length < 1) {
        return res.send(response(baseResponse.NOT_LOGIN));
    } else if (token != checkJWT[0].jwt) {
        return res.send(response(baseResponse.TOKEN_VERIFICATION_FAILURE));
    }

    const logOutResponse = await userService.deleteJWT(userIdFromJWT);
    return res.send(logOutResponse);
}


/*
    API No. 4
    API Name : 유저 설정값 변경 API
    [PATCH] /app/users/status
*/
exports.patchUserStatus = async function (req, res) {

    const userId = req.verifiedToken.userId

    var {alarmStatus, miniCodeStatus, NameStatus, BGMStatus} = req.body;

    if (!userId) {
        return res.send(response(baseResponse.USER_USERID_EMPTY));
    }

    // 탈퇴한 계정인지 체크
    const userStatusRows = await userProvider.retrieveUserStatus(userId);
    console.log(userStatusRows)
    if(userStatusRows[0].status === "D")
        return res.send(response(baseResponse.SIGNIN_WITHDRAWAL_ACCOUNT));

    else {

        if (!alarmStatus) {
            alarmStatus = userStatusRows[0].alarmStatus
        }
        if (!miniCodeStatus) {
            miniCodeStatus = userStatusRows[0].miniCodeStatus
        }
        console.log(miniCodeStatus)
        if (!NameStatus) {
            NameStatus = userStatusRows[0].NameStatus
        }
        if (!BGMStatus) {
            BGMStatus = userStatusRows[0].BGMStatus
        }

        const editUserStatus = await userService.editUserStatus(userId, alarmStatus, miniCodeStatus, NameStatus, BGMStatus);
        return res.send(editUserStatus);
    }

}



/**
 * API No. 5
 * API Name : 미니코드 설정 API
 * [PATCH] /app/users/miniCode
 * body : miniCode
 */
exports.updateMiniCode = async function (req, res) {

    const userId = req.verifiedToken.userId

    // 탈퇴한 계정인지 체크
    const userStatusRows = await userProvider.retrieveUserStatus(userId);
    if(userStatusRows[0].status === "D")
        return res.send(response(baseResponse.SIGNIN_WITHDRAWAL_ACCOUNT));

    const miniCodeStatus = userStatusRows[0].miniCodeStatus
    console.log(miniCodeStatus)
    if (miniCodeStatus == 'N')
        return res.send(response(baseResponse.CHECK_MINI_STATUSCODE));

    const {miniCode} = req.body;

    if (!userId) {
        return res.send(response(baseResponse.USER_USERID_EMPTY));
    }

    if (!miniCode) {
        return res.send(response(baseResponse.USER_MINICODE_EMPTY));
    }

    if (miniCode.length >= 5) {
        return res.send(response(baseResponse.SIGNUP_MINICODE_LENGTH));
    }

    const MiniCodeResult = await userService.updateMiniCode(userId, miniCode);
    return res.send(MiniCodeResult);

};


/**
 * API No. 5
 * API Name : 닉네임 수정
 * [PATCH] /app/users/nickname
 * body : nickname, miniCode
 */
exports.patchNickname = async function (req, res) {

    // jwt - userId, path variable :userId

    const userId = req.verifiedToken.userId

    if (!userId) {
        return res.send(response(baseResponse.USER_USERID_EMPTY));
    }

    // 탈퇴한 계정인지 체크
    const userStatusRows = await userProvider.retrieveUserStatus(userId);
    console.log(userStatusRows[0].status)
    if(userStatusRows[0].status === "D")
        return res.send(response(baseResponse.SIGNIN_WITHDRAWAL_ACCOUNT));

    const miniCodeStatus = userStatusRows[0].miniCodeStatus
    if (miniCodeStatus == 'N'){
        const nickname = req.body.nickname;
        if (!nickname) return res.send(errResponse(baseResponse.USER_NICKNAME_EMPTY));

        const editUserInfo = await userService.editUserNickname(userId, nickname)
        return res.send(editUserInfo);
    }

    const {nickname, miniCode} = req.body;
    if (!nickname) return res.send(errResponse(baseResponse.USER_NICKNAME_EMPTY));
    if (!miniCode) return res.send(errResponse(baseResponse.USER_MINICODE_EMPTY));
    
    const checkMiniCode = await userProvider.checkMiniCode(userId, miniCode);
    if(checkMiniCode.length > 0){
        const editUserInfo = await userService.editUserNickname(userId, nickname)
        return res.send(editUserInfo);
    }
    return errResponse(baseResponse.DB_ERROR);
};

/**
 * API No. 6
 * API Name : JWT 토큰 검증 API
 * [GET] /app/auto-login
 * header : x-access-token
 */
exports.check = async function (req, res) {
    // jwt - userId

    const userIdFromJWT = req.verifiedToken.userId;

    const token = req.headers['x-access-token'];
    const checkJWT = await userProvider.checkJWT(userIdFromJWT);

    if (!userIdFromJWT) {
        return res.send(errResponse(baseResponse.SIGNIN_JWT_TOKEN_NOT_EXIST));
    } else if (token == checkJWT[0].jwt) {
        return res.send(response(baseResponse.SUCCESS, {"userId": userIdFromJWT}));
    } else {
        return res.send(response(baseResponse.TOKEN_VERIFICATION_FAILURE));
    }
};


/*
    API No.
    API Name :카카오 로그인 API
    [GET] /app/auth/kakao
*/
passport.use('kakao-login', new KakaoStrategy({
    clientID: '0a8a336f06243c943b2015623c8290b6',
    callbackURL: 'http://localhost:3000/auth/kakao/callback',
}, async (accessToken, refreshToken, profile, done) =>
{
    console.log(accessToken);
    console.log(refreshToken);
    console.log(profile);
}));

exports.kakaoLogin = async function(req, res) {

    const {accessToken} = req.body;

    if (!accessToken)
        return res.send(errResponse(baseResponse.ACCESS_TOKEN_EMPTY))
    try {
        let kakao_profile;
        try {
            kakao_profile = await axios.get('https://kapi.kakao.com/v2/user/me', {
                headers: {
                    Authorization: 'Bearer ' + accessToken,
                    'Content-Type': 'application/json'
                }
            })
        } catch (err) {
            return res.send(errResponse(baseResponse.ACCESS_TOKEN));
        }

        const data = kakao_profile.data.kakao_account;
        const nickname = data.profile.nickname;
        const email = data.email;

        const emailCheckResult = await userProvider.emailCheck(email);

        // 기존에 존재하는 이메일 유저 >> 소셜 로그인 자동 진행
        if (emailCheckResult[0] != null) {
            const userInfoRows = await userProvider.getUserInfo(email);
            const kakaoSignInResponse = await userService.postSocialSignIn(email);
            return res.send(kakaoSignInResponse);
        }
        // 기존에 존재하지 않는 유저 >> 소셜 회원가입 후 로그인 진행
        else {
            const  kakaoSignUpResponse = await userService.createSocialUser(email, nickname);
            const kakaoSignInResponse = await userService.postSocialSignIn(email);
            return res.send(kakaoSignInResponse);

        }} catch(err) {
        logger.error(`App - postSignIn Service error\n: ${err.message} \n${JSON.stringify(err)}`);
        return errResponse(baseResponse.DB_ERROR);
    }
}

/**
 * API No. 8
 * API Name : 비밀번호 찾기 API
 * [POST] /users/find-password
 */

function createCode(numeric, alphabet, signal) {
    var randomStr = "";

    for (var j = 0; j < 2; j++) {
        randomStr += numeric[Math.floor(Math.random()*numeric.length)];
    }
    for (var j = 0; j < 5; j++) {
        randomStr += alphabet[Math.floor(Math.random()*alphabet.length)];
    }
    for (var j = 0; j < 1; j++) {
        randomStr += signal[Math.floor(Math.random()*signal.length)];
    }

    return randomStr
}

exports.findPassword = async function (req, res) {

    const {email} = req.body;
    if (!email)
        return res.send(errResponse(baseResponse.SIGNUP_EMAIL_EMPTY))

    // 이메일 존재 여부 확인
    const emailRows = await userProvider.emailCheck(email);
    if (emailRows.length == 0)
        return errResponse(baseResponse.USER_USEREMAIL_NOT_EXIST);

    try {
        const numeric = "0,1,2,3,4,5,6,7,8,9".split(',');
        const alphabet = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z".split(",");
        const signal = "!,@,#,$".split(",");

        const password = createCode(numeric, alphabet, signal);
        const hashedPassword = await crypto
            .createHash("sha512")
            .update(password)
            .digest("hex");

        const emailOption = {
            from : '색갈피',
            to : email,
            subject : '색갈피 임시 비밀번호 발급',
            text: `[색갈피] 임시비밀번호 : ${password} 입니다.`
        }
        console.log(password)

        await userService.patchPassword(hashedPassword, email);

        smtpTransport.sendMail(emailOption, function(err, res) {
            if (err) {
                return errResponse(baseResponse.SENDING_TEMPORARY_EMAIL_FAILED);
            } else {
                console.log('email has been sent.');
                return res.send(response(baseResponse.SUCCESS));
            }
            smtpTransport.close();
        });
        res.send('<script type="text/javascript">alert("이메일을 확인하세요."); window.location="/"; </script>');

    } catch(err) {
        logger.error(`App - Find Password Service error\n: ${err.message} \n${JSON.stringify(err)}`);
        return errResponse(baseResponse.DB_ERROR);
    }

};


/*
    API No. 9
    API Name : 유저 탈퇴 API
    [PATCH] /app/users/:usrId/status
*/

exports.withdrawUserStatus = async function (req, res) {

    const userIdFromJWT = req.verifiedToken.userId;
    const userId = req.params.userId;

    if (!userId) {
        return res.send(response(baseResponse.USER_USERID_EMPTY));
    }

    if (userIdFromJWT != userId)
        return res.send(errResponse(baseResponse.USER_ID_NOT_MATCH));

    const deleteUserResult = await userService.withdrawUser(userId);
    return res.send(deleteUserResult);

};