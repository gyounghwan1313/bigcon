

# 데이터 불어오기 및 전처리

## 라이브러리 설치 및 import
# install.packages("lubridate") # 날짜를 다루는 패키지
# install.packages("ggplot2") # 그래프를 그릴 수 있는 패키지
# install.packages("reshape") # 데이터프레임을 조작할 수 있는 패키지
# install.packages("reshape2") # 데이터프레임을 조작할 수 있는 패키지
# install.packages("plyr")  # 데이터프레임을 조작할 수 있는 패키지
# install.packages("dplyr") # 데이터프레임을 조작할 수 있는 패키지
# install.packages("doBy") # 정렬을 다루는 패캐지
# install.packages("gridExtra") #그래프의 분할을 하게 하는 패키지
# install.packages("ggsci") # 그래프 및 색깔 관련 패키지

library(lubridate)
library(ggplot2)
library(reshape)
library(reshape2)
library(doBy)
library(gridExtra)
library(plyr)
library(dplyr)
library(ggsci)

## 데이터 불러오기

#[card] : 내국인 카드 사용 데이터
# 내국인 카드 데이터 용량이 커서 4개로 분할하여 github에서 다운로드
download.file("https://raw.githubusercontent.com/gyounghwan1313/bigcon/master/data/2019_02_03_resident_card.csv",destfile = "./codeData.csv")
card_190203<-read.csv("./codeData.csv",stringsAsFactors = F,sep=',',fileEncoding = "UCS-2LE")

download.file("https://raw.githubusercontent.com/gyounghwan1313/bigcon/master/data/2019_04_05_resident_card.csv",destfile = "./codeData.csv")
card_190405<-read.csv("./codeData.csv",stringsAsFactors = F,sep=',',fileEncoding = "UCS-2LE")

download.file("https://raw.githubusercontent.com/gyounghwan1313/bigcon/master/data/2020_02_03_resident_card.csv",destfile = "./codeData.csv")
card_200203<-read.csv("./codeData.csv",stringsAsFactors = F,sep=',',fileEncoding = "UCS-2LE")

download.file("https://raw.githubusercontent.com/gyounghwan1313/bigcon/master/data/2020_04_05_resident_card.csv",destfile = "./codeData.csv")
card_200405<-read.csv("./codeData.csv",stringsAsFactors = F,sep=',',fileEncoding = "UCS-2LE")

card=rbind(card_190203,card_190405,card_200203,card_200405) #4개를 하나로 합치기

head(card) # 내국인 카드 사용량 데이터셋
tail(card)
str(card)


#[card_for] : 외국인 카드 사용 데이터
download.file("https://raw.githubusercontent.com/gyounghwan1313/bigcon/master/data/card_for.csv",destfile = "./codeData.csv")
card_for<-read.csv("./codeData.csv",stringsAsFactors = F,sep=',',fileEncoding = "cp949")

head(card_for) # 외국인 카드 사용량 데이터셋
tail(card_for)
str(card_for)


#[flow_age] : 유동인구 데이터
download.file("https://raw.githubusercontent.com/gyounghwan1313/bigcon/master/data/4%EA%B0%9C%EC%A7%80%EC%97%AD_FLOW_AGE_201902.CSV",destfile = "./codeData.csv")
flow_age1902<-read.csv("./codeData.csv",stringsAsFactors = F,sep='|',fileEncoding = "UCS-2LE")

download.file("https://raw.githubusercontent.com/gyounghwan1313/bigcon/master/data/4%EA%B0%9C%EC%A7%80%EC%97%AD_FLOW_AGE_201903.CSV",destfile = "./codeData.csv")
flow_age1903<-read.csv("./codeData.csv",stringsAsFactors = F,sep='|',fileEncoding = "UCS-2LE")

download.file("https://raw.githubusercontent.com/gyounghwan1313/bigcon/master/data/4%EA%B0%9C%EC%A7%80%EC%97%AD_FLOW_AGE_201904.CSV",destfile = "./codeData.csv")
flow_age1904<-read.csv("./codeData.csv",stringsAsFactors = F,sep='|',fileEncoding = "UCS-2LE")

download.file("https://raw.githubusercontent.com/gyounghwan1313/bigcon/master/data/4%EA%B0%9C%EC%A7%80%EC%97%AD_FLOW_AGE_201905.CSV",destfile = "./codeData.csv")
flow_age1905<-read.csv("./codeData.csv",stringsAsFactors = F,sep='|',fileEncoding = "UCS-2LE")

download.file("https://raw.githubusercontent.com/gyounghwan1313/bigcon/master/data/4%EA%B0%9C%EC%A7%80%EC%97%AD_FLOW_AGE_202002.CSV",destfile = "./codeData.csv")
flow_age2002<-read.csv("./codeData.csv",stringsAsFactors = F,sep='|',fileEncoding = "UCS-2LE")

download.file("https://raw.githubusercontent.com/gyounghwan1313/bigcon/master/data/4%EA%B0%9C%EC%A7%80%EC%97%AD_FLOW_AGE_202003.CSV",destfile = "./codeData.csv")
flow_age2003<-read.csv("./codeData.csv",stringsAsFactors = F,sep='|',fileEncoding = "UCS-2LE")

download.file("https://raw.githubusercontent.com/gyounghwan1313/bigcon/master/data/4%EA%B0%9C%EC%A7%80%EC%97%AD_FLOW_AGE_202004.CSV",destfile = "./codeData.csv")
flow_age2004<-read.csv("./codeData.csv",stringsAsFactors = F,sep='|',fileEncoding = "UCS-2LE")

download.file("https://raw.githubusercontent.com/gyounghwan1313/bigcon/master/data/4%EA%B0%9C%EC%A7%80%EC%97%AD_FLOW_AGE_202005.CSV",destfile = "./codeData.csv")
flow_age2005<-read.csv("./codeData.csv",stringsAsFactors = F,sep='|',fileEncoding = "UCS-2LE")

# 하나로 합치기
flow_age<-bind_rows(flow_age1902, flow_age1903, flow_age1904, flow_age1905, flow_age2002, flow_age2003, flow_age2004, flow_age2005)

head(flow_age) # skt유동 데이터 셋
str(flow_age)


## 데이터 전처리
### - 지역코드로 되어 있는 것은 한글로 변환

card["GU"] = ifelse(card$GU_CD==110, "대구 중구",
                    ifelse(card$GU_CD==140,"서울 중구",
                           ifelse(card$GU_CD==260,"대구 수성구","서울 노원구")))

### - 날짜형 컬럼로 변환, 년, 월, week 컬럼 추가

# 내국인 카드 소비 데이터
card['date'] = as.Date(as.character(card[,'STD_DD']), format='%Y%m%d')
card$year = year(card$date) #년도 컬럼 추가
card$month = month(card$date) #월 컬럼 추가
head(card)

# 외국인 카드 소비 데이터
card_for['date']<-as.Date(as.character(card_for[,'STD_DD']), format='%Y%m%d')
head(card_for)

# 유동인구 데이터
flow_age['date']<-as.Date(as.character(flow_age$STD_YMD), format='%Y%m%d')
head(flow_age)

## 유동인구 데이터에 week 컬럼 추가
flow_age<-flow_age %>%
  mutate(year=year(date),weeks=week(date)-4)



# 신한카드 내국인 카드 소비 데이터 분석(유통업, 요식업소, 음료식품)

## 분석 1 : 월별 카드 소비 금액 (보고서 ppt p.18, appendix ppt p.5)

# - 월별 전체 카테고리의 카드 사용 금액 합계
data1=aggregate(USE_AMT~year+month,card,sum)
data1=doBy::orderBy(~year+month,data1)
data1[,"USE_AMT"]=data1[,"USE_AMT"]/100000 #억단위로 단위 변환

# - 월별 유통업의 카드 사용 금액 합계
data2=aggregate(USE_AMT~year+month,card[card$MCT_CAT_CD==40,],sum)
data2=orderBy(~year+month,data2)
data2[,"USE_AMT"]=data2[,"USE_AMT"]/100000 #억단위로 단위 변환

# - 월별 요식업소의 카드 사용 금액 합계
data3=aggregate(USE_AMT~year+month,card[card$MCT_CAT_CD==80,],sum)
data3=orderBy(~year+month,data3)
data3[,"USE_AMT"]=data3[,"USE_AMT"]/100000 #억단위로 단위 변환

# - 월별 음료식품의 카드 사용 금액 합계
data4=aggregate(USE_AMT~year+month,card[card$MCT_CAT_CD==81,],sum)
data4=orderBy(~year+month,data4)
data4[,"USE_AMT"]=data4[,"USE_AMT"]/100000 #억단위로 단위 변환

# - 세개 카테고리의 사용 금액 합계
data5=aggregate(USE_AMT~year+month,card[card$MCT_CAT_CD %in% c(81,80,40),],sum)
data5=orderBy(~year+month,data5)
data5[,"USE_AMT"]=data5[,"USE_AMT"]/100000 #억단위로 단위 변환


### [table_monthly_USE_AMT] : 월별 카드 사용 금액의 합계 (ppt보고서 ###페이지)

table_monthly_USE_AMT = data1
colnames(table_monthly_USE_AMT)[3] = "전체사용금액"
table_monthly_USE_AMT[,"전체사용금액"]=round(table_monthly_USE_AMT[,"전체사용금액"]) 
table_monthly_USE_AMT["유통업"] = round(data2[,"USE_AMT"]) #반올림한 유통업의 카드 사용 금액을 가져옴
table_monthly_USE_AMT["요식업소"] = round(data3[,"USE_AMT"]) #반올림한 요식업소의 카드 사용 금액을 가져옴
table_monthly_USE_AMT["음료식품"] = round(data4[,"USE_AMT"]) #반올림한 음료식품의 카드 사용 금액을 가져옴
table_monthly_USE_AMT["세가지 카테고리"] = round(data5[,"USE_AMT"]) #반올림한 세가지 카테고리의의 카드 사용 금액을 가져옴

table_monthly_USE_AMT # 분석1_1 결과 테이블


### [table_monthly_USE_RATE] : 전체 카드 사용량 대비 각 카테고리의 카드 사용 비율을 구함 (단위 % )

table_monthly_USE_RATE = table_monthly_USE_AMT[,c("year","month")]
table_monthly_USE_RATE["유통업"]=round(data2[,"USE_AMT"]/data1[,"USE_AMT"],3)*100
table_monthly_USE_RATE["요식업소"]=round(data3[,"USE_AMT"]/data1[,"USE_AMT"],3)*100
table_monthly_USE_RATE["음료식품"]=round(data4[,"USE_AMT"]/data1[,"USE_AMT"],3)*100
table_monthly_USE_RATE["세가지 카테고리"] = table_monthly_USE_RATE["유통업"]+table_monthly_USE_RATE["요식업소"]+table_monthly_USE_RATE["음료식품"]

table_monthly_USE_RATE # 분석1_2 결과 테이블



### 그래프 : 유통업, 요식업소,음료식품 카테고리의 카드 사용량/ 사용 비율 그래프

#그래프를 그리기 위해 새로운 변수로 저장
table_monthly_USE_AMT_graph = table_monthly_USE_AMT 
table_monthly_USE_RATE_graph = table_monthly_USE_RATE

table_monthly_USE_AMT_graph["date"] = paste0(table_monthly_USE_AMT_graph$year,'-',table_monthly_USE_AMT_graph$month)
table_monthly_USE_RATE_graph["date"] = paste0(table_monthly_USE_RATE_graph$year,'-',table_monthly_USE_RATE_graph$month)

table_monthly_USE_AMT_graph
table_monthly_USE_RATE_graph

#그래프를 그리기 위해 melt를 사용해여 데이터를 조작
table_monthly_USE_AMT_graph=melt(table_monthly_USE_AMT_graph[,c("세가지 카테고리","date")])
table_monthly_USE_RATE_graph=melt(table_monthly_USE_RATE_graph[,c("세가지 카테고리","date")])

#유통업, 요식업소, 음료식품 카테고리의 카드 사용량 그래프
p1=ggplot(data=table_monthly_USE_AMT_graph, mapping=aes(x=date, y=value))+
  geom_bar(stat='identity',fill=c("tomato","tomato","tomato","tomato","steelblue","steelblue","steelblue","steelblue"))+
  coord_cartesian(ylim=c(4000,6000))+
  labs(title="<유통업, 요식업소, 음료식품 카테고리의 카드 사용량>",x="날짜",y="사용금액(단위: 억)")+
  theme(axis.title.x=element_text(face="bold",size=16))+
  theme(axis.title.y=element_text(face="bold",size=13, angle=90, vjust=0.5))+
  theme(axis.text.x = element_text (angle=0,hjust=0.5,vjust=1,colour="black",size = 12))+
  theme(axis.text.y = element_text (angle=0,hjust=1,vjust=.5,colour="black",size = 11))+
  theme(plot.title=element_text(face="bold", hjust=0.5, size=18))

#사욜 비율 그래프를 그리기 위해 변수를 순서를 조정
table_monthly_USE_RATE_graph["co"]=c('a','a','a','a','b','b','b','b')
table_monthly_USE_RATE_graph=table_monthly_USE_RATE_graph[c(1,2,3,4,5,5,6,7,8),]
table_monthly_USE_RATE_graph[5,4]="a"

#유통업, 요식업소, 음료식품 카테고리의 카드 사용비율 그래프
p2=ggplot(table_monthly_USE_RATE_graph,aes(x=date,y=value, group=co,color=co))+
  geom_line(aes(group=co),size=2)+
  coord_cartesian(ylim=c(58,63))+
  labs(title="<유통업, 요식업소, 음료식품 카테고리의 카드 사용비율>",x="날짜",y="사용비율(단위 : %)")+
  theme(axis.title.x=element_text(face="bold",size=16))+
  theme(axis.title.y=element_text(face="bold",size=13, angle=90, vjust=0.5))+
  theme(axis.text.x = element_text (angle=0,hjust=0.5,vjust=1,colour="black",size = 12))+
  theme(axis.text.y = element_text (angle=0,hjust=1,vjust=.5,colour="black",size = 11))+
  theme(plot.title=element_text(face="bold", hjust=0.5, size=18))+
  geom_point(size=2.5,color='black')+
  theme(legend.position = "none")

#그래프 출력
grid.arrange(p1, p2, nrow=2)



## 분석2 :2019년의 평균 카드 소비 금액 대비 2020년 2~4월의 평균과 5월의 카드 소비 금액 / 증감률 비교 (보고서 ppt p.19, appendix ppt p.6)

### [table_USE_AMT_compare] : 2019년의 평균, 20년 2~4월의 평균, 20년 5월의 카드 소비금액 비교 테이블

# - 2019년 카테고리별 카드 소비 금액의 평균
USE_AMT_2019=c(mean(table_monthly_USE_AMT[table_monthly_USE_AMT$year==2019,"전체사용금액"]),
               mean(table_monthly_USE_AMT[table_monthly_USE_AMT$year==2019,"유통업"]),
               mean(table_monthly_USE_AMT[table_monthly_USE_AMT$year==2019,"요식업소"]),
               mean(table_monthly_USE_AMT[table_monthly_USE_AMT$year==2019,"음료식품"]),
               mean(table_monthly_USE_AMT[table_monthly_USE_AMT$year==2019,"세가지 카테고리"]))

# - 2020년 2~4월의 카테고리별 카드 소비 금액의 평균
USE_AMT_2020_2_4=c(mean(table_monthly_USE_AMT[table_monthly_USE_AMT$year==2020 & table_monthly_USE_AMT$month<5,"전체사용금액"]),
                   mean(table_monthly_USE_AMT[table_monthly_USE_AMT$year==2020 & table_monthly_USE_AMT$month<5,"유통업"]),
                   mean(table_monthly_USE_AMT[table_monthly_USE_AMT$year==2020 & table_monthly_USE_AMT$month<5,"요식업소"]),
                   mean(table_monthly_USE_AMT[table_monthly_USE_AMT$year==2020 & table_monthly_USE_AMT$month<5,"음료식품"]),
                   mean(table_monthly_USE_AMT[table_monthly_USE_AMT$year==2020 & table_monthly_USE_AMT$month<5,"세가지 카테고리"]))

# - 2020년 5월의 카테고리별 카드 소비 금액
USE_AMT_2020_5=c(table_monthly_USE_AMT[table_monthly_USE_AMT$year==2020 & table_monthly_USE_AMT$month==5,"전체사용금액"],
                 table_monthly_USE_AMT[table_monthly_USE_AMT$year==2020 & table_monthly_USE_AMT$month==5,"유통업"],
                 table_monthly_USE_AMT[table_monthly_USE_AMT$year==2020 & table_monthly_USE_AMT$month==5,"요식업소"],
                 table_monthly_USE_AMT[table_monthly_USE_AMT$year==2020 & table_monthly_USE_AMT$month==5,"음료식품"],
                 table_monthly_USE_AMT[table_monthly_USE_AMT$year==2020 & table_monthly_USE_AMT$month==5,"세가지 카테고리"])

# - 데이터 프레임 형식으로 변환하고 보기 좋은 형태로 변환
table_USE_AMT_compare=data.frame(rbind(t(data.frame(USE_AMT_2019)),
                                       t(data.frame(USE_AMT_2020_2_4)),
                                       t(data.frame(USE_AMT_2020_5))))
names(table_USE_AMT_compare) = c("전체","유통업","요식업소","음료식품","세가지 카테고리")
table_USE_AMT_compare["구분"]=c("2019의평균","20년 2~4월의 평균","20년 5월")
rownames(table_USE_AMT_compare) = NULL
table_USE_AMT_compare=table_USE_AMT_compare[,c(6,1,2,3,4,5)]

table_USE_AMT_compare # 중간 결과 테이블 

### [table_USE_AMT_compare_chage] 2019년의 평균 카드 소비 금액 대비 2020년 2~4월의 평균과 5월의 카드 소비 금액 증감률 비교 테이블

chage_total=c(round((table_USE_AMT_compare[2,2]-table_USE_AMT_compare[1,2])/table_USE_AMT_compare[1,2]*100,2),
              round((table_USE_AMT_compare[3,2]-table_USE_AMT_compare[1,2])/table_USE_AMT_compare[1,2]*100,2))

chage_logis=c(round((table_USE_AMT_compare[2,3]-table_USE_AMT_compare[1,3])/table_USE_AMT_compare[1,3]*100,2),
              round((table_USE_AMT_compare[3,3]-table_USE_AMT_compare[1,3])/table_USE_AMT_compare[1,3]*100,2))

chage_restaurant=c(round((table_USE_AMT_compare[2,4]-table_USE_AMT_compare[1,4])/table_USE_AMT_compare[1,4]*100,2),
                   round((table_USE_AMT_compare[3,4]-table_USE_AMT_compare[1,4])/table_USE_AMT_compare[1,4]*100,2))

chage_food=c(round((table_USE_AMT_compare[2,5]-table_USE_AMT_compare[1,5])/table_USE_AMT_compare[1,5]*100,2),
             round((table_USE_AMT_compare[3,5]-table_USE_AMT_compare[1,5])/table_USE_AMT_compare[1,5]*100,2))


table_USE_AMT_compare_chage=data.frame(c("19년 대비 20년 2~4월의 증감률","19년 대비 20년 5월의 증감률"), chage_total, chage_logis, chage_restaurant, chage_food)
names(table_USE_AMT_compare_chage) = c("구분","전체","유통업","요식업소","음료식품")

table_USE_AMT_compare_chage # 분석2 결과 테이블 (appnedix)


### 그래프 : 2019년의 평균 카드 소비 금액 대비 2020년 2~4월의 평균과 5월의 카드 소비 금액 증감률 그래프

table_USE_AMT_compare_chage_graph=melt(table_USE_AMT_compare_chage)

ggplot(table_USE_AMT_compare_chage_graph, aes(variable, value, fill=구분))+
  geom_bar(stat='identity', position = 'dodge')+
  theme(legend.position = "bottom")+
  ylim(-28,25)+
  labs(x="카테고리",y="증감률(%)")+
  theme(axis.title.x=element_text(face="bold",size=15))+
  theme(axis.title.y=element_text(face="bold",size=15, angle=90, vjust=0.5))+
  theme(axis.text.x = element_text (angle=0,hjust=0.5,vjust=1,colour="black",size = 13.5))+
  theme(axis.text.y = element_text (angle=0,hjust=1,vjust=.5,colour="black",size = 11))



## 분석3 :지역구별 2019년의 평균 카드 소비 금액 대비 2020년 2~4월의 평균과 5월의 카드 소비 금액 비교 (보고서 ppt p.20)

### [data_gu_amt]: 지역구별/월별 전체, 유통업, 요식업소,음료식품 카드 소비량 구하기

# 지역구별 전체 카드 소비량 구하기
gu_amt=aggregate(USE_AMT~year+month+GU,card,sum)
gu_amt=orderBy(~GU+year+month,gu_amt)
gu_amt[,4]=gu_amt[,4]/100000 #억단위로 분석

# 지역구별 유통업 카드 소비량 구하기
gu_logis_amt=aggregate(USE_AMT~year+month+GU,card[card$MCT_CAT_CD==40,],sum)
gu_logis_amt=orderBy(~GU+year+month,gu_logis_amt)
gu_logis_amt[,4]=gu_logis_amt[,4]/100000

# 지역구별 요식업소 카드 소비량 구하기
gu_restaurant_amt=aggregate(USE_AMT~year+month+GU,card[card$MCT_CAT_CD==80,],sum)
gu_restaurant_amt=orderBy(~GU+year+month,gu_restaurant_amt)
gu_restaurant_amt[,4]=gu_restaurant_amt[,4]/100000

# 지역구별 음료식품 카드 소비량 구하기
gu_food_amt=aggregate(USE_AMT~year+month+GU,card[card$MCT_CAT_CD==81,],sum)
gu_food_amt=orderBy(~GU+year+month,gu_food_amt)
gu_food_amt[,4]=gu_food_amt[,4]/100000

# 지역구별 카드 소비량을 하나의 테이블로 만들기
data_gu_1 = aggregate(USE_AMT~year+GU,gu_amt,mean)
data_gu_2 = aggregate(USE_AMT~year+GU,gu_logis_amt,mean)
data_gu_3 = aggregate(USE_AMT~year+GU,gu_restaurant_amt,mean)
data_gu_4 = aggregate(USE_AMT~year+GU,gu_food_amt,mean)

data_gu_amt=cbind(data_gu_1,data_gu_2[,3],data_gu_3[,3],data_gu_4[,3])
names(data_gu_amt)[c(3,4,5,6)] = c("전체 카테고리", "유통업", "요식업소","음료식품")
data_gu_amt["세가지 카테고리"] = (data_gu_amt$유통업 + data_gu_amt$요식업소 + data_gu_amt$음료식품)

data_gu_amt #중간 결과 테이블


### [useamt_year_table]: 2019년 소비 평균, 2020년2~4월 소비 평균, 2020년 5월 소비량을 통해 2019년대비 2020년 카드 사용액 비교

# 2019년 지역별 소비 액수의 평균
useamt_2019=cbind(aggregate(USE_AMT~GU,gu_amt[gu_amt$year==2019,],mean),
                  aggregate(USE_AMT~GU,gu_logis_amt[gu_logis_amt$year==2019,],mean),
                  aggregate(USE_AMT~GU,gu_restaurant_amt[gu_restaurant_amt$year==2019,],mean),
                  aggregate(USE_AMT~GU,gu_food_amt[gu_food_amt$year==2019,],mean))
useamt_2019=useamt_2019[,c(1,2,4,6,8)]
names(useamt_2019)  = c("지역구","전체","유통업","요식업소","음료식품")

# 2020년 2월~4월 지역별 소비 액수의 평균
useamt_20200204=cbind(
  aggregate(USE_AMT~GU,gu_amt[gu_amt$year==2020 &gu_amt$month<5,],mean),
  aggregate(USE_AMT~GU,gu_logis_amt[gu_logis_amt$year==2020 &gu_logis_amt$month<5,],mean),
  aggregate(USE_AMT~GU,gu_restaurant_amt[gu_restaurant_amt$year==2020 &gu_restaurant_amt$month<5,],mean),
  aggregate(USE_AMT~GU,gu_food_amt[gu_food_amt$year==2020 &gu_food_amt$month<5,],mean))
useamt_20200204=useamt_20200204[,c(1,2,4,6,8)]
names(useamt_20200204)  = c("지역구","전체","유통업","요식업소","음료식품")

# 2020년 5월 지역별 소비 액수
useamt_202005=cbind(
  aggregate(USE_AMT~GU,gu_amt[gu_amt$year==2020 &gu_amt$month==5,],mean),
  aggregate(USE_AMT~GU,gu_logis_amt[gu_logis_amt$year==2020 &gu_logis_amt$month==5,],mean),
  aggregate(USE_AMT~GU,gu_restaurant_amt[gu_restaurant_amt$year==2020 &gu_restaurant_amt$month==5,],mean),
  aggregate(USE_AMT~GU,gu_food_amt[gu_food_amt$year==2020 &gu_food_amt$month==5,],mean))
useamt_202005=useamt_202005[,c(1,2,4,6,8)]
names(useamt_202005)  = c("지역구","전체","유통업","요식업소","음료식품")

# 위 3개의 테이블 합치기
useamt_year_table=rbind(useamt_2019,useamt_20200204,useamt_202005)
useamt_year_table["구분"]=c(rep("2019합계의 평균",4),rep("2020년2~4월 평균",4),rep("2020년 5월",4))

useamt_year_table # 중간 결과 테이블(appendix)


### 2019년 대비 2020년2~4월 소비 증감률, 2019년 대비 2020년 5월 소비증감률 비교

#지역구별 2019년 평균 대비 2020년2~4월,2020년 5월의 카드 사용 금액 증감률
table_D_susung=useamt_year_table[useamt_year_table['지역구']=='대구 수성구',]
table_D_jung=useamt_year_table[useamt_year_table['지역구']=='대구 중구',]
table_S_nowon=useamt_year_table[useamt_year_table['지역구']=='서울 노원구',]
table_S_jung=useamt_year_table[useamt_year_table['지역구']=='서울 중구',]


rate_cal = function(table){
  t1=c(round((table[2,2]-table[1,2])/table[1,2],2),
       round((table[3,2]-table[1,2])/table[1,2],2))
  t2=c(round((table[2,3]-table[1,3])/table[1,3],2),
       round((table[3,3]-table[1,3])/table[1,3],2))
  t3=c(round((table[2,4]-table[1,4])/table[1,4],2),
       round((table[3,4]-table[1,4])/table[1,4],2))
  t4=c(round((table[2,5]-table[1,5])/table[1,5],2),
       round((table[3,5]-table[1,5])/table[1,5],2))
  df=data.frame(t1,t2,t3,t4)
  df=cbind(c("2019대비 2020년 2~4월","2019대비 2020년 5월"),df)
  names(df) =c(paste0("구분-",table[1,1]),"전체","유통업","요식업소","음료식품")
  print(df)
}


# 대구 지역 2019년 평균 대비 2020년2~4월,2020년 5월의 카드 사용 금액 증감률
#### 대구 수성구

rate_cal(table_D_susung)

#### 대구 중구

rate_cal(table_D_jung)


# 서울 지역 2019년 평균 대비 2020년2~4월,2020년 5월의 카드 사용 금액 증감률
#### 서울 노원구

rate_cal(table_S_nowon)

#### 서울 중구

rate_cal(table_S_jung)


# 신한카드 내국인 카드 소비 데이터 분석(여행관련 산업)

## 분석 4: 여행관련 산업(숙박, 레저용품, 레저업소, 문화취미) 카테고리의 코로나 전후 소비의 변화 분석 (보고서 ppt p.8,10)

card$ym = paste(card$year,card$month,sep='-') #내국인 카드 데이터에 '2019-02'형식으로 칼럼 추가

data_travel=aggregate(USE_AMT~ym+MCT_CAT_CD,card[card$MCT_CAT_CD %in% c(10, 20, 21, 22),],sum) #여행 관련 산업만 추출

data_travel[,2] = ifelse(data_travel[,2]==10, "숙박",
                         ifelse(data_travel[,2]==20,"레저용품",
                                ifelse(data_travel[,2]==21,"레저업소","문화취미")))

data_travel[,3]=data_travel[,3]/100000 #억단위로 변경
colnames(data_travel)[2] = "카테고리"
data_travel #분석 4 결과 테이블

ggplot(data=data_travel, aes(x=ym, y=USE_AMT, group=카테고리)) +
  geom_line(aes(linetype=카테고리, color=카테고리),size=1)+
  geom_point(aes(color=카테고리),size=2)+
  theme(legend.position="top")+
  coord_cartesian(ylim=c(30,350))+
  labs(x="날짜",y="소비 금액(단위 : 억원)")+
  theme(axis.title.x=element_text(face="bold",size=16))+
  theme(axis.title.y=element_text(face="bold",size=13, angle=90, vjust=0.5))+
  theme(axis.text.x = element_text (angle=0,hjust=0.5,vjust=1,colour="black",size = 12))+
  theme(axis.text.y = element_text (angle=0,hjust=1,vjust=.5,colour="black",size = 11))+
  theme(plot.title=element_text(face="bold", hjust=0.5, size=18))



# 신한카드 외국인 카드 소비 데이터 분석(내국인과 비교)

## 분석 5: 내국인 대비 외국인의 소비 액수의 변화 추이를 분석 (appendix ppt p.7)
### [all_1920_USE_AMT] : 나라별 내국인 대비 외국인 카드 소비 액수의 비율

# 1. 내국인(resident)의 월별 카드 사용 총액
subym<-function(x){
  return(substr(x,1,7))
} 

res_1920_USE_AMT<-card %>%
  mutate(ym=apply(card['date'], 1, subym)) %>%
  group_by(ym) %>%
  dplyr::summarise(sum_use_amt=sum(USE_AMT)) %>%
  data.frame()

# 2. 외국인(foreigner)의 국가별/월별 카드 사용 총액
for_1920_USE_AMT<-card_for %>% 
  mutate(ym=apply(card_for['date'],1,subym)) %>%
  ddply(.(ym, COUNTRY_NM), summarise, sum_use_amt=sum(USE_AMT)) %>%
  dcast(ym~COUNTRY_NM, sum)

# 3. 내국인과 외국인 테이블 merge, 전체 합계로 나눠 '내국인 대비 외국인 카드 사용금액 계산'
all_1920_USE_AMT<-merge(res_1920_USE_AMT, for_1920_USE_AMT, by='ym') #내국인과 외국인 데이터 join

for (i in 1:8) {
  all_1920_USE_AMT[i,3:length(all_1920_USE_AMT)]<-
    all_1920_USE_AMT[i,3:length(all_1920_USE_AMT)]*100/res_1920_USE_AMT[i,'sum_use_amt'] #비율
}

all_1920_USE_AMT[7:8,'대만']<-0 #대만은 NA이기 떄문에 0으로 변환
all_1920_USE_AMT # 내국인의 소비 대비 각 국가의 소비 비율(foreigner/resident), 분석 5 결과 데이블


### 그래프 : 미국, 일본, 중국, 대만, 영국, 유럽, 홍콩, 아시아, 태국 - 상위 9개만 사용해서 그래프 그리기

main_country<-all_1920_USE_AMT[,c('ym','대만','미국','아시아','영국','유럽','일본','중국','홍콩',"태국")]
main_country_melt<-melt(main_country)

colnames(main_country_melt)<-c('ym','country','relative_ratio')
main_country_melt$country<-as.vector(main_country_melt$country)
main_country_melt$ym<-c(1:8)

ggplot(main_country_melt, aes(x=ym, y=relative_ratio, color=country))+
  theme_bw() +
  geom_point() +
  geom_line() + 
  scale_x_continuous(labels = main_country[,'ym'], breaks = c(1:8)) +
  labs(x='날짜','상대비율(Foreigner/Resident)', 
       title='내국인 대비 외국인의 카드 사용 비율')+
  theme(plot.title=element_text(face="bold", hjust=0.5, size=18))+
  theme(axis.title.x=element_text(face="bold",size=16))+
  theme(axis.title.y=element_text(face="bold",size=13, angle=90, vjust=0.5))+
  theme(axis.text.x = element_text (angle=0,hjust=0.5,vjust=1,colour="black",size = 10))+
  theme(axis.text.y = element_text (angle=0,hjust=1,vjust=.5,colour="black",size = 11))


## 분석 6: 카테고리별 내국인 대비 외국인의 카드 소비 비율의 변화 추이를 분석 (appendix ppt p.8)

### [for_cat_USE_AMT] : 카테고리별 내국인 대비 외국인의 카드 소비 비율

#1 . Resident : 년월, 업종별 소비 액수 합계
res_cat_USE_AMT<-card %>% 
  mutate(ym=apply(card['date'],1,subym)) %>%
  ddply(.(ym, MCT_CAT_CD), summarise, sum_use_amt=sum(USE_AMT)) %>%
  dcast(ym~MCT_CAT_CD, sum)

# 2. Foreigner : 년월, 업종별 소비 액수 합계
for_cat_USE_AMT<-card_for %>% 
  mutate(ym=apply(card_for['date'],1,subym)) %>%
  ddply(.(ym, MCT_CAT_CD), summarise, sum_use_amt=sum(USE_AMT)) %>%
  dcast(ym~MCT_CAT_CD, sum)

# 3. 내국인 대비 외국인의 카드 소비 비율 구하기
for(i in 1:8){
  for(j in 2:24){
    for_cat_USE_AMT[i,j]<-for_cat_USE_AMT[i,j]*100/res_cat_USE_AMT[i,j]
  }
}
for_cat_USE_AMT #분석 6 결과 테이블


### 그래프 : 소비 비율이 큰 상위 10개 카테고리를 기반으로 시간에 따른 비율의 변화 추이

#값이 큰 10개로 그래프 그리기
for_cat_USE_AMT<-for_cat_USE_AMT[,c('ym','10','20','22','40','42','44','62','71','80','81')]

code_number = c(10,	20,	21,	22,	30,	31,	32,	33,	34,	35,	40,	42,	43,	44,	50,	52,	60,	62,	70,	71,	80,	81,	92)
code_name = c('숙박',	'레저용품',	'레저업소',	'문화취미',	'가구',	'전기',	'주방용구',	'연료판매',	'광학제품',	'가전',	'유통업',	'의복',	'직물',	'신변잡화',	'서적문구',	'사무통신',	'자동차판매',	'자동차정비',	'의료기관',	'보건위생',	'요식업소',	'음료식품',	'수리서비스')
category_table=data.frame(code_number,code_name)
names(category_table)[2] = "카테고리"

# [for_cat_USE_AMT_melt] 테이블과 카테고리 테이블을 merge하고 그래프 생성
for_cat_USE_AMT_melt<-melt(for_cat_USE_AMT)
colnames(for_cat_USE_AMT_melt)<-c('ym','category','relative_ratio')
for_cat_USE_AMT_melt = merge(for_cat_USE_AMT_melt,category_table, by.x = 'category', by.y='code_number')
for_cat_USE_AMT_melt$code_name<-as.vector(for_cat_USE_AMT_melt$code_name)
for_cat_USE_AMT_melt[is.na(for_cat_USE_AMT_melt$relative_ratio),'relative_ratio']=0
for_cat_USE_AMT_melt$ym<-c(1:8)

ggplot(for_cat_USE_AMT_melt, aes(x=ym, y=relative_ratio, color=카테고리))+
  theme_bw() +
  geom_point() +
  geom_line() + 
  scale_x_continuous(labels = for_cat_USE_AMT[,'ym'], breaks = c(1:8)) +
  labs(x='날짜','상대비율(Foreign/Resident)', 
       title='내국인 대비 외국인의 카테고리별 카드 소비 비율')+
  theme(plot.title=element_text(face="bold", hjust=0.5, size=16))+
  theme(axis.title.x=element_text(face="bold",size=16))+
  theme(axis.title.y=element_text(face="bold",size=13, angle=90, vjust=0.5))+
  theme(axis.text.x = element_text (angle=0,hjust=0.5,vjust=1,colour="black",size = 10))+
  theme(axis.text.y = element_text (angle=0,hjust=1,vjust=.5,colour="black",size = 11))


# skt 유동인구 데이터 분석

## 분석 7: 주별 유동인구 변화 추이 분석 (보고서 ppt p.21)
### [year_total_flow] : 주단위 유동인구의 합계

#날짜별 유동인구 합
flow_age<-flow_age %>%
  mutate(flow_sum=rowSums(flow_age[,-c(1,2,3,4,35,36,37)]))

#주 단위 유동인구 합
year_total_flow<-flow_age %>%
  ddply(.(year, weeks), summarise, sum=sum(flow_sum)) %>%
  dcast(year~weeks, sum)

year_total_flow  # 분석 7 결과 테이블


### __그래프 : 19년과 20년의 주별 유동인구 변화__

year_total_flow_melt<-melt(year_total_flow, id='year')
year_total_flow_melt<-year_total_flow_melt[order(year_total_flow_melt$year),]
colnames(year_total_flow_melt)<-c('year','weeks','flow_sum')
year_total_flow_melt$weeks<-as.vector(as.integer(year_total_flow_melt$weeks))
year_total_flow_melt$year<-as.factor(year_total_flow_melt$year)
year_total_flow_melt<-year_total_flow_melt[-c(1,18,19,36),] #19, 20년 1주차, 18주차 제외 >> 데이터 부족

ggplot(year_total_flow_melt, aes(x=weeks, y=flow_sum, color=year))+
  theme_bw() +
  geom_point() +
  geom_line() + 
  labs(x='weeks',y='유동인구', 
       title='년도별 유동인구 그래프')+
  theme(plot.title=element_text(face="bold", hjust=0.5, size=16))+
  theme(axis.title.x=element_text(face="bold",size=16))+
  theme(axis.title.y=element_text(face="bold",size=13, angle=90, vjust=0.5))+
  theme(axis.text.x = element_text (angle=0,hjust=0.5,vjust=1,colour="black",size = 10))+
  theme(axis.text.y = element_text (angle=0,hjust=1,vjust=.5,colour="black",size = 11))+
  scale_y_continuous(labels = scales::comma)
