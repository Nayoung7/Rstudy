# 내가 작업하는 공간의 파일들 목록보기
list.files()

# csv파일 불러오기 >> 변수에 저장
titanic <- read.csv("titanic_2.csv")
titanic

# 데이터의 앞부분을 확인 : 디폴트는 6개
head(titanic, 8)

# 데이터의 뒷부분을 확인
tail(titanic, 10)

# 데이터 속성별 자료형태 출력
# obs. < observation : 관측치 = 행
# variables : 열
str(titanic)

# 데이터 속성별 통계량 출력
summary(titanic)

# 사분위수를 시각화한 그래프
# boxplot()
boxplot(titanic$Fare)

# 데이터의 개수 세기
table(titanic$Embarked)

# 데이터의 차원 출력
dim(titanic)

# wordcloud2 패키지 설치 및 적용
install.packages("devtools")

library(devtools)

devtools::install_github("lchiffon/wordcloud2")
library(wordcloud2)

# wordclou2를 그리는 방법
# 단어와 해당되는 빈도수를 데이터프레임으로 만들면 끝
word <- c("감성돔", "굴찜", "대방어", "고등어", "해삼")
fre <-c(100, 10, 30, 80, 90)
food <- data.frame(word,fre)
food

wordcloud2(food, size=0.5, fontFamily = "궁서체", color="random-light")

# 패키지 안에 있는 함수의 속성을 알 수 있는 방법
??wordcloud2


list.files()
baseball <- read.csv("baseball.csv")

bb <- data.frame(구단 = baseball$구단, 승 = (baseball$승)^4)
bb

wordcloud2(bb, size=0.5)


list.files()
stu <- read.csv("대학 계열별 학과수 및 학년별 재적학생수.csv")

ee <- data.frame(학과 = stu$소계열, 학과수=stu$학과수)
wordcloud2(ee, size=0.5)

ff <- data.frame(학과=stu$소계열, 재적학생수=stu$재적학생수)
wordcloud2(ff, size=0.5)



#java, rjava 설치
install.packages("remotes")
remotes::install_github("mrchypark/multilinguer")


library(multilinguer)
install_jdk()

#의존성 패키지 설치
install.packages(c("hash", "tau", "Sejong", "RSQLite", "devtools", "bit", "rex", "lazyeval", "htmlwidgets", "crosstalk", "promises", "later", "sessioninfo", "xopen", "bit64", "blob", "DBI", "memoise", "plogr", "covr", "DT", "rcmdcheck", "rversions"), type = "binary")


# KoNLP 설치
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))

# 패키지 로딩하기
library(KoNLP)

v1 <- "어쩜 이렇게 하늘은 더 파란건지. 오늘따라 왜 바람은 또 완벽한지. 그냥 모르는 척, 하나 못들은 척 지워버린 척 딴 얘길 시작할까 아무 말 못하게 입맞출까 눈물이 차올라서 고갤 들어 흐르지 못하게 또 살짝 웃어 내게 왜 이러는지 무슨 말을 하는지 오늘 했던 모든 말 저 하늘 위로 한번도 못했던 말 울면서 할 줄을 나 몰랐던 말 나는요 오빠가 좋은걸 어떡해"

# KoNLP 안에 있는 기능으로 문자열이나 벡터를 단어로 끊어주는것
# extractNoun(벡터) : 명사 추출하는 함수
# useNIADic() : NIADic를 사용하겠다 > 형태소 사전
extractNoun(v1)

useNIADic()



list.files()

# readLines() : 엑셀 또는 메모장의 데이터를 한줄씩 읽어와서 벡터형태로 저장하는 함수
news <- readLines("2021_11_29_기준 인공지능 뉴스제목 500개.csv")
news

# extractNoun(벡터) : 명사 추출하는 함수
news_noun <- extractNoun(news)
head(news_noun)

# 리스트 형태의 데이터를 벡터로 변환하는 함수
news_unlist <- unlist(news_noun)
news_unlist

# 값의 개수를 세는 함수 = 단어별 빈도수를 확인하는 함수
result1 <- table(news_unlist)

# 정렬하기
result2 <- sort(result1,decreasing = TRUE)

#wordcloud2 사용하기
library(wordcloud2)
result3 <- result2[-1]
result3
wordcloud2(result3, size = 0.5)
