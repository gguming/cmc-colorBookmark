module.exports = function(app){
    const diary = require('./diaryController');
    const jwtMiddleware = require('../../../config/jwtMiddleware');

    // API No. 10 홈 컬러 조회 API
    app.get('/app/diarys/home', jwtMiddleware, diary.getHome);

    // API No. 11 홈 컬러 등록 API
    app.post('/app/diarys/home/color',jwtMiddleware, diary.postHomeColor);
    //
    // API No. 12 컬러 변경 API
    app.patch('/app/diarys/:diaryId/color',jwtMiddleware, diary.patchColor);

    // API No. 13 현재 달 감정기록 조회 API
    app.get('/app/diarys/current-month',jwtMiddleware, diary.getCurrentMonthDiary);

    // API No. 14 달 별 감정기록 조회 API
    app.get('/app/diarys/month',jwtMiddleware, diary.getMonthDiary);

    // API No. 14 특정 날짜 감정기록 조회 API
    app.get('/app/diarys/:diaryId/date',jwtMiddleware, diary.getDiary);

    // API No. 15 다이어리 등록 API
    app.post('/app/diarys/date',jwtMiddleware, diary.postDiary);

    // API No. 16 다이어리 수정 API
    app.patch('/app/diarys/:diaryId/date',jwtMiddleware, diary.patchDiary);

    // API No. 17 다이어리 이미지 수정 API
    app.patch('/app/diarys/:diaryImgId/image',jwtMiddleware, diary.patchDiaryImg);

};
