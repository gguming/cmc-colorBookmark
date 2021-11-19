module.exports = function(app){
    const user = require('./userController');
    const jwtMiddleware = require('../../../config/jwtMiddleware');
    const passport = require('passport');

    // 1. 유저 생성 (회원가입) API
    app.post('/app/users', user.postUsers);

    // 2. 로그인 + JWT 발급 API
    app.post('/app/login', user.login);

    // 3. 유저 이메일 중복체크 API
    app.get('/app/users/email',user.emailCheck)
    //
    // // 3. 로그아웃 API
    // app.get('/app/logout', jwtMiddleware, user.logOut);
    //
    // 4. 유저 설정값 변경 API
    app.patch('/app/users/status',jwtMiddleware, user.patchUserStatus);
    //
    //5. 유저 미니코드 생성 ( 기존 값 null )  API
    app.patch('/app/users/miniCode',jwtMiddleware,user.updateMiniCode)
    //
    // //6. JWT 검증 API -자동 로그인
    // app.get('/app/auto-login', jwtMiddleware, user.check);
    //
    // API No 7. 카카오 로그인 및 회원가입 API
    app.get('/users/kakao-login', user.kakaoLogin);
    app.get('/kakao', passport.authenticate('kakao-login'));
    app.get('/auth/kakao/callback', passport.authenticate('kakao-login', {
        successRedirect: '/',
        failureRedirect : '/',
    }), (req, res) => {res.redirect('/');});

    //
    // API No 8. 비밀번호 찾기 API (이메일 임시 비밀번호 발급)
    app.post('/users/find-password', user.findPassword);
    //
    // API No. 8. 닉네임 변경
    app.patch('/app/users/nickname', jwtMiddleware, user.patchNickname);

    // API No 9. 유저 탈퇴 API (+JWT)
    app.patch('/app/users/:userId/status', jwtMiddleware, user.withdrawUserStatus);
};