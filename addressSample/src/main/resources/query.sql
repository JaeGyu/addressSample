ALTER TABLE address CONVERT TO CHARSET utf8;

SELECT *
FROM address;

INSERT INTO address (NAME,address,tel)
VALUES('홍길동','서울시 구로동 44-55','010-9992-3344');
INSERT INTO address (NAME,address,tel)
VALUES('김길동','수원시 화서동 182-33','010-7992-3324');
INSERT INTO address (NAME,address,tel)
VALUES('최길동','안양시 만안동 2323-23','010-4495-3232');


DELETE FROM address;
