# title   : Tableau與R大數據分析實作
# date    : 2019.3.25-26
# author  : Ming-Chang Lee
# email   : alan9956@gmail.com
# RWEPA   : http://rwepa.blogspot.tw/
# Encoding: UTF-8

# 大綱 -----
# 一.Tableau簡介與基礎操作
# 二.實作演練(一):建立第一個Tableau案例分析
# 三.為何使用Tableau + R
# 四.R資料呈現與資料前處理技巧
# 五.實作演練(二):Tableau+R-銷售資料演練
# 六.CRISP-DM標準作業流程
# 七.預測模型應用-集群分析,迴歸模型與廣義線性模型
# 八.實作演練(三):Tableau+R-顧客集群建模演練
# 九.實作演練(四):Tableau+R-製造資料建模演練
# 十.實作演練(五):Tableau+R-生產資料最佳化建模演練

# 三.為何使用Tableau + R -----

# Tableau 下載
# https://www.tableau.com/products/desktop/download

# Analysis \ Aggregate Measures [取消]
# Filter: 群組, 時間, 地理
# 階層式格式架構: 工作簿層級Workbook \ 工作表層級Worksheet \ 物件層級Object

# R下載
# http://www.r-project.org/

# Windows 版本:
# R: http://cran.csie.ntu.edu.tw/bin/windows/base/R-3.5.3-win.exe
# RStudio: https://download1.rstudio.org/RStudio-1.1.463.exe
# 
# Mac 版本:
# R: http://cran.csie.ntu.edu.tw/bin/macosx/
# RStudio: https://www.rstudio.com/products/rstudio/download/#download
# 
# Linux 版本:
# R: http://rwepa.blogspot.com/2013/05/ubuntu-r.html
# RStudio: https://www.rstudio.com/products/rstudio/download/#download

# CWB 1,600萬筆資料
# http://rwepa.ddns.net:3838/sample-apps/cwb_vis_qc/

setwd("C:/rdata") # 設定工作目錄為C:/rdata 須使用反斜線
plot(runif(100), type="l") # 繪圖
demo(graphics)
demo(persp)

# RStudio下載 http://www.rstudio.com/ 

# 整合式開發環境 RStudio
install.packages("leaflet")
library(leaflet)
m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=120.988296, lat=24.800383, popup="工研院光復院區")
m

# R-40類別套件 http://rwepa.blogspot.tw/2013/10/packages-list-32.html 

# 檢視已安裝套件
installed.packages()

# 檢視已載入套件
search()

# 練習安裝 ggplot2套件
install.packages("ggplot2")
library(ggplot2)
set.seed(123456)
dsmall <- diamonds[sample(nrow(diamonds), 500), ]
# 散佈圖+局部加權迴歸線
p <- ggplot(data=dsmall, mapping=aes(carat, price))
p + geom_point() + stat_smooth(method = "loess", span = 0.5)

# R四大資料型態
# 整數   integer
# 數值   numeric
# 字串   character
# 邏輯值 logical (TRUE/FALSE)

# 資料物件
# 向量   vector, 採用c建立向量
# 矩陣   matrix
# 陣列   array
# 資料框 data.frame
# 串列   list

# 輔助說明
help.start()
?lm
help(lm)
help.search("regression")
??regression

# 函數說明
?plot

# 四、R資料呈現與資料前處理技巧 -----
# refer to references

# R十大基礎函數
# read.table	匯入資料
# help	      輔助說明 (?)
# str		      資料結構 (int, num, chr, Factor, logi)
# summary	    資料摘要
# class	      資料物件 (vector, matrix, data.frame, list)
# length	    資料筆數
# apply	      列,行計算
# plot 	      繪圖
# pairs	      散佈圖矩陣 scatter plot matrix
# write.table	匯出資料

# 匯入資料 (CSV檔案)
gfc <- read.table("http://web.ydu.edu.tw/~alan9956/rdata/gfc.csv", head=TRUE, sep=",")
gfc

# plot 繪圖
plot(gfc$amount)
plot(gfc$amount, type="l")
str(gfc)
summary(gfc)

# gfc資料分析與視覺化範例
# http://web.ydu.edu.tw/~alan9956/rdata/gfc_vis.zip

# 五.實作演練(二):Tableau+R-銷售資料演練 -----

# Tableau + R

# 安裝並載入Rserve套件
install.packages("Rserve")
library(Rserve)
Rserve()

# Tableau與R連結設定
# 開啟 Tableau \ refer to materials

# 早餐食品銷售資料
# http://web.ydu.edu.tw/~alan9956/rdata/breakfasts.zip

# Connect \ Microsoft Excel \ breakfasts.xlsx \ 將左側 dhTransactionData 工作表拖曳至右側 Worksheet \ 按 Automatically Update

# 理解各變數資料型態, 測試右上角Filters \ Add功能

# Q1:SPEND最大的STORE_NUM為何?
# 切換至Sheet 1
# 將 STORE_NUM 拖曳至 Rows
# 將 SPEND 拖曳至 Columns
# 按 排序 \ STORE_NUM: 2277 為SPEND最高者

# Q2:依據WEEK_END_DATE, 繪製SPEND線圖
# 新增 Sheet 2
# 將 WEEK_END_DATE 拖曳至 Columns
# 將 SPEND 拖曳至 Rows
# 將 YEAR 修改為 DAY
# 依據SPEND, 加入Trend Line

# 六、CRISP-DM標準作業流程 -----
# https://en.wikipedia.org/wiki/Cross_Industry_Standard_Process_for_Data_Mining

# 非監督式學習 vs.監督式學習

# a. 監督式學習
# Decision trees, Random Forests
# 決策樹, 隨機森林法

# Linear / Nonlinear model (Shrinkage: Ridge Regression, Lasso)
# 線性模型 / 非線性模型 收敛: 瘠迴歸
# LASSO, Least Absolute Shrinkage and Selection Operator, 最小絕對值收斂和選擇運算元, 套索演算法

# Neural Networks 類神經網路

# Support Vector Machines 支持向量機

# Kernel Smoothing Methods 核平滑法

# b. 非監督式學習

# Clustering 集群法

# Association Rules 關聯規則

# Principal Components Analysis 主成分分析

# SOM (Self-Organizing Maps) 自我組織映射, (Self-Organizing Feature Maps) 自組織特徵映射

# 七.預測模型應用-集群分析,迴歸模型與廣義線性模型 -----

# 集群分析 – iris資料集 -----

# kmeans 演算法
library(animation)
kmeans.ani()

# iris資料集 - kmeans示範
library(ggplot2)
iris

# 繪製Petal.Length vs. Petal.Width 散佈圖
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()

# 集群分析 kmeans
iris.cluster <- kmeans(iris[-5],3)
iris.cluster
iris.cluster$cluster
names(iris.cluster)

# 練習 iris.RData 匯入至Tableau -----

# 儲存為RData
save(iris, file="iris.RData")

# 左下角 Measures 視窗 --> 右鍵 --> [Create Calculated Fields]

# SCRIPT_INT('set.seed(168);result <- kmeans( data.frame(.arg1,.arg2,.arg3,.arg4), 3);result$cluster;', SUM([Sepal.Length]),SUM([Sepal.Width]),SUM([Petal.Length]),SUM([Petal.Width]))
# Calculation1 --> 右鍵 --> Conver to Discrete

# 迴歸模型 – women 資料集 -----

# Simple linear regression
?lm
# my.lm <- lm(formula, data="xxx")
# formula: y ~ x1 + x2 + ... +xn
# end

# women: Average Heights and Weights for American Women
# y: weight
# x: height
fit.lm <- lm(weight ~ height, data=women)
summary(fit.lm)
# weight = -87.52+3.45*height

# verify residuals
names(fit.lm)
women$weight   # actual
fitted(fit.lm) # predicted
residuals(fit.lm) # residual=actual-predicted
women$weight - fitted(fit.lm)

# plot data
plot(women$height,women$weight, xlab="Height (in inches)", ylab="Weight (in pounds)", main="Average Heights and Weights for American Women")
abline(fit.lm, col="red")
# end

# 多項式迴歸 Polynomial regression
fit.poly.lm <- lm(weight ~ height + I(height^2), data=women)
summary(fit.poly.lm)
# weight = 261.88 - 7.35*height + 0.083*height^2

# plot data with polynomial regression
plot(women$height,women$weight, main="Polynomial regression", xlab="Height (in inches)", ylab="Weight (in lbs)")
lines(women$height, fitted(fit.poly.lm), col="blue")
# end

# 三階多項式迴歸 cubic polynomial regression
fit.cubic.lm <- lm(weight ~ height + I(height^2) +I(height^3), data=women)
summary(fit.cubic.lm)

# plot data with cubic polynomial regression
plot(women$height,women$weight, main="Cubic polynomial regression", xlab="Height (in inches)", ylab="Weight (in lbs)")
lines(women$height, fitted(fit.cubic.lm), col="blue")
# end

# 邏輯斯迴歸 - Affairs資料集 -----

# Example- Logistic regression
# install.packages("AER")
# library(AER)
# ?Affairs
data(Affairs, package="AER")
summary(Affairs)
table(Affairs$affairs)

# add new column
Affairs$ynaffair[Affairs$affairs > 0] <- 1
Affairs$ynaffair[Affairs$affairs == 0] <- 0
Affairs$ynaffair <- factor(Affairs$ynaffair,
                           levels=c(0,1),
                           labels=c("No","Yes"))
table(Affairs$ynaffair)

# logistic regression- consider all variables
fit.full <- glm(ynaffair ~ gender + age + yearsmarried
                + children + religiousness + education
                + occupation +rating,
                data=Affairs,
                family=binomial())

summary(fit.full)

# logistic regression- droped 4 variables
fit.reduced <- glm(ynaffair ~ age + yearsmarried
                   + religiousness
                   + rating,
                   data=Affairs, family=binomial())

summary(fit.reduced)

# sensitivity analysis for rating
testdata <- data.frame(rating=c(1, 2, 3, 4, 5), age=mean(Affairs$age),
                       yearsmarried=mean(Affairs$yearsmarried),
                       religiousness=mean(Affairs$religiousness))
testdata
testdata$prob <- predict(fit.reduced, newdata=testdata, type="response")
testdata

# 八、實作演練(三):Tableau+R-顧客集群建模演練 ----
# 早餐食品銷售資料

# SCRIPT_INT('set.seed(168);result <- kmeans( data.frame(.arg1,.arg2,.arg3,.arg4), 3);result$cluster;', SUM([UNITS]),SUM([VISITS]),SUM([HHS]),SUM([PRICE]))

# 九.實作演練(四):Tableau+R-製造資料建模演練

# Wafer 資料集
# http://web.ydu.edu.tw/~alan9956/rdata/wafer-actual.xlsx

# 十.實作演練(五):Tableau+R-生產資料最佳化建模演練 -----

# 1. 醫藥產品
# 方法1 直接下載
# http://web.ydu.edu.tw/~alan9956/rdata/ChemicalManufacturingProcess.csv

# 方法2 R建立
install.packages("AppliedPredictiveModeling")
data(ChemicalManufacturingProcess, package="AppliedPredictiveModeling")

str(ChemicalManufacturingProcess) # 176*58
names(ChemicalManufacturingProcess)
head(ChemicalManufacturingProcess)
summary(ChemicalManufacturingProcess)

# 變數轉換
ChemicalManufacturingProcess$Status[ChemicalManufacturingProcess$Yield > 41] <- "High"
ChemicalManufacturingProcess$Status[ChemicalManufacturingProcess$Yield < 39] <- "Low"
ChemicalManufacturingProcess$Status[is.na(ChemicalManufacturingProcess$Status)] <- "Middle"
table(ChemicalManufacturingProcess$Status)
write.table(ChemicalManufacturingProcess, file="ChemicalManufacturingProcess.csv", sep=",", row.names = FALSE)

# 參考資料
# (1).R基礎篇
# http://rwepa.blogspot.tw/2013/01/r-201174.html

# (2).R軟體教學影片介紹
# http://www.r-software.org/movielist 

# (3).R軟體論壇
# http://www.r-software.org/jiao-yu-xun-lian

# (4).Tibame
# https://www.tibame.com/ --> 線上增能 --> 數據分析系列 --> 程式語言 --> R語言系列
# end
