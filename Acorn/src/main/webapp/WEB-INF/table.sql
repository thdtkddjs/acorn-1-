-- 사용자(회원) 정보를 저장할 테이블
CREATE TABLE users(
    id VARCHAR2(100) PRIMARY KEY,
    pwd VARCHAR2(100) NOT NULL,
    email VARCHAR2(100),
    profile VARCHAR2(100), --프로필 이미지 경로를 저장할 칼럼
    regdate DATE,
    ban VARCHAR2(25),
    loggedIn VARCHAR2(3) DEFAULT 'no'
);

-- 가게 리스트 테이블
CREATE TABLE board_shop( 
    num NUMBER PRIMARY KEY, -- 가게 고유 번호
    title VARCHAR2(100), -- 가게이름
    content CLOB, -- 소개 내용
    imagePath VARCHAR2(100), -- 섬네일 또는 가게 대표이미지
    categorie VARCHAR2(100), -- 음식 분류
    reviewCount NUMBER, -- 리뷰/댓글 개수
    startTime VARCHAR2(30),
    endTime VARCHAR2(30),
    telNum VARCHAR2(20), -- 가게 전화번호
    addr VARCHAR2(200) --  주소(불필요시 추후 삭제)
);

-- 게시들의 번호를 얻어낼 시퀀스
CREATE SEQUENCE board_shop_seq;

-- 댓글을 지정할 테이블
CREATE TABLE board_shop_review( -- 테이블명 추후 변경 예정
    num NUMBER PRIMARY KEY, -- 리뷰의 글 번호
    writer VARCHAR2(100), -- 리뷰의 작성자 아이디
    title VARCHAR2(100),
    content VARCHAR2(500), -- 리뷰 내용
    ref_group NUMBER, 
    review_group NUMBER,
    deleted CHAR(3) DEFAULT 'no', --  리뷰 삭제여부
    grade number, -- 평점
    imagePath VARCHAR2(200), -- 섬네일
    regdate DATE
);
-- 댓글의 글번호를 얻어낼 시퀀스
CREATE SEQUENCE board_shop_review_seq;

-- menu 정보(image 포함)
CREATE TABLE board_shop_menu(
num number not null,-- 어떤 상점의 메뉴인지를 표시
menuNum number primary key, -- 고유번호
name varchar2(50) not null,-- 상품 이름
price varchar2(50), -- 메뉴 가격
content varchar2(100), -- 한눈에 들어오는 수준으로 짧은 글로 사용
imagePath varchar2(200)-- 이미지 경로(카메라로 찍은 파일을 바로 올리면 이름이 아주 길 수도 있으니 200정도로 넓게 잡음)
)

-- orderNum을 얻어낼 시퀀스
CREATE SEQUENCE board_shop_menu_seq;

-- shop의 나머지 이미지 db
CREATE TABLE board_shop_view(
num number not null, -- 상점과 join하는 역할
viewNum number primary key, -- 고유 번호
name varchar2(50) not null, -- alt에 들어갈 사진이름&설명(따로 content까진 필요 없으므로 둘을 겸함)
imagePath varchar(200)-- 이미지 경로(카메라로 찍은 파일을 바로 올리면 이름이 아주 길 수도 있으니 200정도로 넓게 잡음)
)

-- orderNum을 얻어낼 시퀀스
CREATE SEQUENCE board_shop_view_seq;
