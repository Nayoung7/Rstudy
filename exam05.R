id <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20)
grade <- c(1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5)
mid <- c(20,23,26,11,22,29,34,37,15,14,26,15,24,24,33,19,11,27,34,21)
fin <- c(33,39,21,11,16,12,30,29,26,25,27,25,11,10,33,25,18,33,21,34)

install.packages("dplyr")
library(dplyr)

score <- data.frame(id, grade, mid, fin)

# 데이터를 그룹별로 묶어주기
# 각 반별로 묶어주는 방법 group_by('컬럼')
# A tibble : 20개의 행 X 4개의 열
# Groups: grade[5] >> grade를 기준으로 5개의 그룹이 나온다
# 단순히 group_by()만 사용하지 않고 summarise() 함수와 같이 사용된다.
# summarise() : 요약통계량을 볼 수 있는 함수
# group_by() 함수를 쓰고 나서는 일반 연산함수 쓸수 없고 summarise 함수를 통해서 연산을 해야한다.
score %>% group_by(grade)
score %>% group_by(grade) %>% summarise(m_mid = mean(mid))

score %>% group_by(grade) %>% summarise(m_mid = max(mid))


# dataframe 합치기
mid <- data.frame(id=c(101,102,103,104,105),mid=c(60,70,80,90,85))
fin <- data.frame(id=c(103,104,105,106,107), fin=c(70,83,65,50,75))

# innerJoin 내부 공통으로 가지고 있는 행만 결합
inner_join(mid, fin, by="id")

# full_join 두개의 데이터 프레임을 합함
full_join(mid, fin, by="id")

# left_join 왼쪽을 기준으로 병합
left_join(mid, fin, by="id")

# right_join 오른쪽을 기준으로 병합
right_join(mid, fin, by="id")

# 행 기준으로 데이터 합치기 : bind_rows(), 컬럼 이름과 갯수가 같아야함
mid2 <- data.frame(id=c(106,107), mid=c(85,77))
mid
mid2

bind_rows(mid,mid2)

# 실습 항공데이터 분석하기
install.packages("hflights")
library(hflights)
dim(hflights)
View(hflights)

# 비행기 번호판별 가장 오래걸린 출발시간을 출력하시오
hflights %>% group_by(TailNum) %>% summarise(max(DepTime, na.rm=T))

# 결항건수가 가장 많았던 날 알아내기
# 1. 결항사유별 건수를 출력하세요
hflights %>%group_by(CancellationCode) %>% summarise(n=n())

# 결항사유가 날씨('B') 이거나 기류('C')상황인 데이터만 출력하시오
# 그 다음 월별 건수 출력
hflights %>%  filter(CancellationCode == "B" | CancellationCode =="C") %>% group_by(Month) %>% summarise(n=n()) %>% arrange(desc(n))

# 월 > 일 순으로 그룹화해서 출력하기
# 2월 1,3,4일 : 
hflights %>%  filter(CancellationCode == "B" | CancellationCode =="C") %>% group_by(Month, DayofMonth) %>% summarise(n=n()) %>% arrange(desc(n))    

list.files()
library(readxl)

score <- read_excel("score.xlsx")
score

# na(결측치)를 파악하는 함수 : is.na(df)
is.na(score)
# True와 False의 개수를 출력하시오
table(is.na(score))
# 속성(컬럼)별 na의 개수 출력
summary(score)

# filter를 활용하여 mid안에 결측치가 없는 행만 출력
score %>% filter(!is.na(mid)) # true -> false, false -> true로 바꿔줘야함

# filter를 활용하여 전체 결측치가 있는 행을 제거
score %>% filter(!is.na(mid) & !is.na(fin) & !is.na(assign) & !is.na(att))

score %>% na.omit()

median(score$mid, na.rm = T)

# 문제 mid안에 결측치가 있다면 중앙값으로 대체해주세요.
score$mid <- ifelse(is.na(score$mid),median(score$mid, na.rm = T),score$mid)
score$mid

boxplot(score$mid)

# 문제 mid안에 값이 100점 초과라면 중앙값으로 대체해주세요
score$mid <- ifelse(score$mid > 100, 25, score$mid)
score$mid
