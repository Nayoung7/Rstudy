# 벡터 : 동일한 자료가 일차원으로 나열된 것
vec1 <- c(10,20,30,40,50)
vec1
vec2 <- c("사과", 100, TRUE)
vec2
vec3 <- c(100.3, 33, TRUE, FALSE)
vec3

# 각 열에 해당하는 벡터 생성하기
v_no <- seq(1,7)
v_no

v_name <- c("Apple", "Peach", "Banana", "Grape", "Kiwi", "Orange", "Mango")
v_name

v_price <- c(500,200,100,300,150,250,450)
v_price

v_stock <- c(5,2,4,7,5,3,8)
v_stock

# 데이터 프레임 만드는 방법 data.frame()
sales <- data.frame(v_no, v_name, v_price, v_stock)
sales

# 자료구조를 출력하는 방법
View(sales)

# DataFrame에서 원하는 데이터만 조회하기
# sales 데이터프레임에서 v_name 값만 뽑아서 보기
sales$v_name
sales[3,2]
sales[3,]
sales[,2]
sales[1:2, 1:2]

# 데이터프레임에서 컬럼의 개수를 알 수 있는 방법
ncol(sales)
sales[1,1:ncol(sales)]
sales[1,3:ncol(sales)]
sales[1,]

# 데이터프레임에서 행의 개수를 알 수 있는 방법
nrow(sales)
sales[3:nrow(sales),1]

# 데이터프레임에서 컬럼의 이름들만 추출하는 방법
names(sales)

# 다양한 함수를 데이터프레임에 적용하기
sum(sales$v_price)
mean(sales$v_price)
round(mean(sales$v_price), digits = 2)
min(sales$v_price)
max(sales$v_price)
range(sales$v_price)


# 1. DataFrame 'Score' 생성
no <- 1:10
name <- c('이은비','김서아','장하윤','유이서','나서윤','이지안','박나은','황유나','김하율','윤시아')
kor <- c(80,76,26,61,44,19,53,81,26,64)
eng <- c(8,76,69,18,82,56,48,14,73,83)
math <- c(65,27,100,76,37,77,73,19,74,60)
math
score <- data.frame(no,name,kor,eng,math)
View(score)

# 2. Kor열 데이터만 출력
score$kor
score[,3]

# 3. eng열 데이터만 출력
score$eng

# 4. 컬럼 개수 출력
ncol(score)

# 5. 행 개수 출력
nrow(score)

# 6. 컬럼명을 출력
names(score)

# 7. kor의 평균점수를 소수 첫째자리까지 출력
round(mean(score$kor),digits = 1)
sum(score$kor)

# 8. eng중 가장 큰 점수 출력
max(score$eng)

# 9. math 중 가장 작은 점수 출력
min(score$math)

# 10. 학생별 평균 점수
for (i in 1:10){
  print(round((sum(score[i,3:5]) / 3),digits = 1))
}







# 내가 작업하는 공간의 파일들 목록보기
list.files()

# 엑셀 데이터파일을 읽을 수 있는 함수들이 모여있는 패키지 다운로드 하기
install.packages("readxl")

# 패키지를 로딩하여 사용하기
library(readxl)

# 함수를 사용하여 파일 불러오기
Score <- read_excel("score.xlsx")
View(Score)







# csv파일을 읽어와서 데이터프레임 형태로 저장
titanic <- read.csv('titanic.csv')
titanic

# 문자열 데이터를 범주형으로 읽어들이는 옵션
titanic_2 <- read.csv("titanic_2.csv", stringsAsFactors = TRUE)

list.files()
heart <- read.csv("heart_failure_clinical_records_dataset.csv", stringsAsFactors = TRUE)