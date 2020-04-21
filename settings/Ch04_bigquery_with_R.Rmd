---
title: "Ch04_bigquery_with_R"
date: 2020-04-21T11:40:30+09:00
output: 
  html_document: 
    keep_md: true
    toc: true
tags:
  - "구글 클라우드"
  - "Google Cloud"
  - "빅쿼리"
  - "BigQuery"
  - "빅쿼리 R"
  - "BigQuery with R"
categories:
  - "구글 클라우드"
  - "Google Cloud"
  - "빅쿼리"
  - "BigQuery"
  - "R"
menu: 
  gcp:
    name: Ch04_bigquery_with_R
---

## 1. 구글 클라우드 설정

본격적인 빅쿼리 실습에 앞서서, R과 연동하는 예제를 준비하였다. 빅쿼리 시작에 앞서서 선행적으로 클라우드 사용을 해야 한다. 

1. 만약 GCP 프로젝트가 없다면, 계정을 연동한다. Go to [Cloud Resource Manager](https://console.cloud.google.com/cloud-resource-manager)
2. 그리고, 비용결제를 위한 카드를 등록한다. [Enable billing](https://support.google.com/cloud/answer/6293499#enable-billing) 
3. 마지막으로 BigQuery API를 사용해야 하기 때문에 빅쿼리 API 사용허가를 내준다.[Enable BigQuery](https://console.cloud.google.com/flows/enableapi?apiid=bigquery)

위 API를 이용하지 않으면 `Python` 또는 `R`과 연동해서 사용할 수는 없다. 자주 쓰는것이 아니라면 비용은 거의 발생하지 않으니 염려하지 않아도 된다. 비용관리에 대한 자세한 내용은 [BigQuery 권장사항: 비용 관리](https://cloud.google.com/bigquery/docs/best-practices-costs?hl=ko)에서 확인하기를 바란다.  

## 2. 사용자 계정 인증
구글 코랩을 사용해서 인증 절차를 밟도록 한다. 아래 소스코드는 변경시키지 않는다. 아래 절차대로 진행하면 된다. `Gmail` 인증 절차와 비슷하다. 

## 3. Bigrquery R 패키지 로드
패키지 설치가 되어 있지 않다면 아래 소스코드를 통해 패키지를 불러온다.  
```r
# install.packages("bigrquery")
library(bigrquery)
```

## 4. 사용자 계정 인증
구글 코랩을 사용해서 인증 절차를 밟도록 한다. 아래 소스코드는 변경시키지 않는다. 아래 절차대로 진행하면 된다. `Gmail` 인증 절차와 비슷하다. 이 때, `Enter authorization code:` 입력하는 부분에서 인증키를 복사한 후 붙여넣기 하면 된다. 

```r
# Provide authentication
bq_auth(use_oob = TRUE)
```


## 5. 데이터 연동
사용자 계정 인증이 완료 되었다면, 이제 데이터를 불러오자. 이 때 중요한 것은 `project_id`를 입력해줘야 하는 것이다. 

### (1) Low-Level API
직접 빅쿼리 프로젝트 ID를 이용해 연동해본다. 

```r
billing <- "bigquerytutorial-274406"
sql <- "SELECT COUNT(*) as total_rows FROM `bigquery-public-data.samples.gsod`"

tb <- bq_project_query(billing, sql)
## Complete
## Billed: 0 B
bq_table_download(tb)
# A tibble: 1 x 1                                                         
#  total_rows
#       <int>
# 1  114420316
```


### (2) DBI를 활용한 연동

이번에는 R의 데이터베이스 인터페이스인 `DBI`를 활용해서 데이터를 불러온다. 

```r
library(DBI)
con <- dbConnect(
  bigrquery::bigquery(), 
  project = "bigquery-public-data", 
  dataset = "samples", 
  billing = billing
)

con
# <BigQueryConnection>
#  Dataset: bigquery-public-data.samples
#  Billing: bigquerytutorial-274406


dbGetQuery(con, sql, n = 10)

# Complete
# Billed: 0 B
# Downloading 1 rows in 1 pages.
## A tibble: 1 x 1                                                         
#  total_rows
#       <int>
#1  114420316
```

### (3) dplyr를 활용한 빅쿼리 연동

```r
library(dplyr)
dbListTables(con)
# [1] "github_nested"   "github_timeline" "gsod"            "natality"       
# [5] "shakespeare"     "trigrams"        "wikipedia"  

gsod <- tbl(con, "gsod")
gsod %>% 
  summarise(total_rows = n())

# Running job 'bigquerytutorial-274406.job_fe5MbF0IChh7fRBBhPKYHZSHN3qz.U...
# Complete
# Billed: 0 B
# Downloading 1 rows in 1 pages.
## Source:   lazy query [?? x 1]                                           
## Database: BigQueryConnection
#  total_rows
#       <int>
# 1  114420316
```

똑같은 결과값을 내기 위해서 서로 다른 패키지를 활용해서 출력하는 것을 확인하였다. 지금까지, R과 빅쿼리 연동에 대해서 짧게 배우는 시간을 가졌다. 

자세한 건 공식문서를 확인하기를 바란다. 

## 6. 파이썬과 빅쿼리 연동
파이썬과 빅쿼리 연동하는 예제는 [Ch03_bigquery_with_python](https://chloevan.github.io/gcp/bigquery/01_settings/ch03_bigquery_with_python/)에서 확인하기를 바란다. 

## 7. Reference
Schendzielorz, Tim  M. “Google Big Query with R.” R, 20 Mar. 2020, www.r-bloggers.com/google-big-query-with-r/.

RStudio. “Databases Using R.” Databases Using R, db.rstudio.com/databases/big-query/.




