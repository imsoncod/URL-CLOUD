-- URL CLOUD Datebase Info

-- 회원정보 테이블
create table userinfo(
    userid varchar2(20) primary key,
    userpw varchar2(500),
    username varchar2(20),
    useremail varchar2(30) unique,
    useremailcheck number(1),
    usercode varchar2(100)
);

-- 카테고리 테이블
create table kategorie(
    kategorienum integer,
    userid varchar2(20),
    kategoriename varchar2(40),
    primary key(userid, kategoriename),
    foreign key(userid) references userinfo(userid) on delete cascade
);

-- URL 테이블
create table URL(
    urlnum integer,
    userid varchar2(20),
    kategorie varchar2(40),
    explanation varchar2(50),
    url varchar2(500),
    rgdate date,
    favorites char(1),
    private char(1),
    primary key(urlnum, userid),
    foreign key(userid, kategorie) references kategorie(userid, kategoriename) on delete cascade
);
