# ggplot2 패키지 설치
install.packages("ggplot2")

# 패키지 로딩
# ggplot2 패키지는 시각화를 손쉽게 해주는 전용 패키지
library(ggplot2)
library(dplyr)

# ggplot2에 있는 연습용 데이터 : mpg(1999~2008년 사이 미국에서 출시된 자동차 234종의 연비관련 정보)
View(mpg)
str(mpg)
summary(mpg)

# tibble 형태의 데이터를 dataframe 구조로 변경하는 방법
mpg <- data.frame(mpg)

# ggplot 3단계 구조
# 1. 축설정 2. 그래프 설정 3. 추가설정
# x축은 배기량(displ), y축은 고속도로 연비(hwy)로 설정하고 데이터를 각 위치에 산점도로 표현
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(size=2, color = "#4169E1") + xlim(3,6) + ylim(10,30) + labs(x = "배기량", y = "연비") + theme(axis.title.x = element_text(size = 20), axis.title.y = element_text(size = 20))

# 구동방식(drv) 종류별로 배기량에 따른 고속도로 연비를 시각화 (구동방식 종류별로 점 색깔을 다르게 주는 것)
# color안의 기준점이 범주형인 경우 : 각각 다른 색상으로 표현이 된다
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) + geom_point()

# color안의 기준점이 수치형인 경우 : 같은 색상이지만 진한 정도가 다름
ggplot(mpg, aes(x = displ, y = hwy, color = cyl)) + geom_point()

# 추세선 그리기
ggplot(mpg, aes(x = displ, y = hwy, color = cyl)) + geom_point() + geom_smooth()

# 막대그래프 그리기
# 제조회사별 평균연비 출력
manu_hwy <- mpg %>% group_by(manufacturer) %>% summarise(mean_hwy = mean(hwy))
manu_hwy
ggplot(manu_hwy, aes(x = manufacturer, y = mean_hwy)) + geom_col() 
ggplot(manu_hwy, aes(x = reorder(manufacturer, -mean_hwy), y = mean_hwy)) + geom_col() 

# 제조회사별 구동방식별 평균 고속도로 연비
mdh <- mpg %>% group_by(manufacturer, drv) %>% summarise(mean_hwy = mean(hwy))
mdh

ggplot(mdh,aes(x =  manufacturer, y = mean_hwy)) + geom_col(aes(fill=drv), position = "dodge")

ggplot(mdh,aes(x =  manufacturer, y = mean_hwy, fill = drv)) + geom_col()

# 구동방식(drv)별 빈도수 그래프
# 빈도그래프를 그릴 때 y축이 빈도수로 결정되기 때문에 y축을 지정하지 않는다
ggplot(mpg, aes(x = drv)) + geom_bar()

# 제조회사별 차종별 빈도그래프
ggplot(mpg, aes(x = manufacturer)) + geom_bar(aes(fill=class))


list.files()

titanic <- read.csv("titanic_2.csv", stringsAsFactors = T)
dim(titanic)
str(titanic)
summary(titanic)
names(titanic)

# 특정 컬럼을 범주형 데이터로 변환 : factor(titanic$Survived)
titanic$Survived <- factor(titanic$Survived)

# 나머지 범주형 데이터 변환하기
titanic$Pclass <- factor(titanic$Pclass)
titanic$Sex <- factor(titanic$Sex)
titanic$Embarked <- factor(titanic$Embarked)

# 변환하지 마세요
titanic$SibSp <- factor(titanic$SibSp)
titanic$Parch <- factor(titanic$Parch)
titanic$Ticket <- factor(titanic$Ticket)
titanic$Cabin <- factor(titanic$Cabin)

table(is.na(titanic$Cabin))
titanic$Name <- ifelse(titanic$Name=="",NA, titanic$Name)
table(is.na(titanic$Name))
titanic$Cabin <- ifelse(titanic$Cabin=="",NA,titanic$Cabin)
table(is.na(titanic$Age))

# 나이에 결측치가 있다면 평균값 넣어주기
titanic$Age <- ifelse(is.na(titanic$Age), mean(titanic$Age, na.rm=T), titanic$Age)

# 금액에 0원이 있다면 평균 금액 넣어주기
table(is.na(titanic$Fare))
titanic$Fare <- ifelse(is.na(titanic$Fare==0), mean(titanic$Fare), titanic$Fare)

# Embarked가 없는 행 걸러주기
titanic <- titanic %>% filter(Embarked != "")

table(titanic$Embarked)
table(titanic$Cabin)

titanic$Cabin <- as.character(titanic$Cabin)
titanic$Cabin <- ifelse(titanic$Cabin == "","Z",titanic$Cabin)
titanic$Cabin <- substr(titanic$Cabin,1,1)

titanic <- titanic %>%  mutate(FamilySize= SibSp + Parch + 1)

titanic <- titanic %>% mutate(FamilyLevel = ifelse(FamilySize == 1, "Single", ifelse(FamilySize <= 4, "Small", "Large")))

titanic <- titanic %>% filter(Cabin != "Z")
ggplot(data = titanic, aes(x = Cabin)) + geom_bar(aes(fill=Survived), position="dodge")
