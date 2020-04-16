Google Cloud Tutorial for Data Scientist

---
title: "Ch01_getstarted"
date: 2020-04-16T11:40:30+09:00
tags:
  - "구글 클라우드"
  - "Google Cloud"
  - "빅쿼리"
  - "BigQuery"
categories:
  - "구글 클라우드"
  - "Google Cloud"
  - "빅쿼리"
  - "BigQuery"
menu: 
  settings:
    name: Ch01_getstarted
---

## I. 자료 정리를 하며.. 

데이터 분석가에게 또는 싸이언티스트들에게 `SQL`문법은 매우 중요하다. 지금도 어딘가에는 데이터는 쌓이고 있고, 문제는 쌓여 있는 데이터를 활용해서 어떤 비즈니스 문제를 해결할지가 가장 큰 이슈이기 때문이다. 

그동안 `SQL`은 `MySQL`과 `RDB` 문법, `MongoDB`와 `NoSQL`과 같은 문법으로 나누어서 볼 수 있다. 강사가 과거 프로젝트에서 사용했던 `SQL`은 `MySQL`, `MSSQL`, `MongoDB`가 있었는데, 각각의 문법이 다르다는 측면이 있어서 조금 애를 많이 먹었다. 특히 `MongoDB`문법은 `JSON` 형태로 되어 있기 때문에, 별도의 문법이라 보는게 더 낫다. 큰 데이터가 아니라 1-2GB 용량의 작은 데이터는 `R` 또는 `파이썬`에서 불러와 직접 처리한 후 다시 `Insert`하는 형태로 진행하였었다. 

경험적으로, 책을 보면서 익히는 것 보다는 부딪히며 배우는게 훨씬 기억이 많이 남았다. 그리고, 대부분은 신규로 나온 `Tool`일수록 해당 `Docs`가 굉장히 중요하다. 기초 문법이란건 그런 것 같다! 

## II. BigQuery의 등장

`BigQuery`를 처음 접한 건 2018년 쯤이었다. 그 때에는 전반적으로 `R&Python`을 활용한 머신러닝이 강세였는데, 그 때 마침, 빅쿼리를 접한 후, 적지 않은 충격을 받았다. 

가장 큰 이유는 (1) `RDB`에서는 불러오기도 힘들었던 `TB`급의 데이터를 쉽게 처리할 수 있는 사용환경에 놀랐고, (2) 간단한 설정으로 `Google Analytics`, `Google Drive Spreadsheet`와 연동이 되는 것을 보고 놀랐다. (3) `SQL`문법을 지원하기 때문에 빅쿼리를 익히면 자연스럽게 기존에 사용하는 `SQL`문법을 버리지 않아도 되는 장점이 있었다. 마지막으로 `SQL`에서 머신러닝을 사용할 수 있는 환경이 있었다. 이러한 4가지 이유로, 데이터 시각화 및 통계분석 이전에 수행되는 데이터 전처리의 마지막 종착지는 `BigQuery`로 귀결될 것으로 생각하였다. 

## III. 빅쿼리 교육자료

필자가 참고했던 자료는 크게 3가지다. 
- [BigQuery Docs](https://cloud.google.com/bigquery/docs/tutorials)
- `Coursera`, 여기에서 다양한 강의를 수강하며 익히고, 수료증을 받았다.
![](/img/gcp/bigquery/01_bigquery.png)
- [변성윤님 자료](https://github.com/zzsza/bigquery-tutorial)
- [원서](https://www.amazon.com/Google-BigQuery-Definitive-Warehousing-Analytics-ebook/dp/B07ZHQ3MGN/ref=pd_sim_351_1/141-4097222-3737936?_encoding=UTF8&pd_rd_i=B07ZHQ3MGN&pd_rd_r=6aebb05f-aee0-4109-b307-6ddcb0861108&pd_rd_w=369PQ&pd_rd_wg=Zh9xu&pf_rd_p=9fec2710-b93d-4b3e-b3ca-e55dc1c5909a&pf_rd_r=SZ76R8NWYEY0C836HBJ0&psc=1&refRID=SZ76R8NWYEY0C836HBJ0)

![](/img/gcp/bigquery/books.png)

순서대로 보면 좋다. 변성윤님은 뵌적은 없지만, 자료 정리가 제법 꼼꼼하게 되어 있으니 참고하기를 바란다. 또한 원서 교재는 2019년, 10월에 출판이 되었기 때문에, 참고하면 좋을 것 같다. 

## IV. Intro

- 본 블로그를 통해서 조금이라도 도움이 되었다면 [github](https://github.com/chloevan/gcp_tutorial) 에서 `Star`를 눌러주시기를 바란다. 
- 모든 IT가 그러하듯이, 작성 시기와 실제 독자가 보는 시기에 성능 및 기능 심지어 클라우드 `Console UI`가 바뀌기 때문에 배우는데 어려움이 있을 수 있다. 자료 수정을 위해서라도 꼭 피드백으로 댓글을 남겨주기를 바란다. 


## V. Contents

Contents는 계속 업데이트 될 예정이다. 이론적인 내용들은 오래전 책이기는 하나, [Google BigQuery: The Definitive Guide: Data Warehousing, Analytics, and Machine Learning at Scale](https://www.amazon.com/Google-BigQuery-Definitive-Warehousing-Analytics-ebook/dp/B07ZHQ3MGN/ref=sr_1_2?dchild=1&keywords=BigQuery&qid=1587019254&sr=8-2)에서 참고하자. 

## VI. Get Started
일단 시작해보자. https://console.cloud.google.com/bigquery 

![](/img/gcp/bigquery/02_Figure.png)

위 화면에서 아래 소스코드를 입력한다. 

```sql
SELECT EXTRACT(YEAR FROM starttime) AS year,
    EXTRACT(MONTH FROM starttime) AS month,
    COUNT(starttime) AS number_one_way
FROM
    `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
    start_station_name != end_station_name
GROUP BY year, month
ORDER BY year ASC, month ASC 
```

위 데이터를 통해서 얻은 결과값이 현재 중요한 것은 아니다. 우리가 봐야 하는 것은, `Query complete (1.6 sec elapsed, 2.5 GB processed)` 에서 `2.5GB` 쿼리를 수행하는데 `1.6`초가 소요되었다는 점이 중요하다. 

즉, 빅데이터라 불리워도 기본적으로 연산속도가 매우 빠르기 때문에, 어느정도 비용만 지불 할 수 있으면, SQL로 처리하는데 큰 문제는 되지 않는다는 점이다. 

## VII. 원론적인 이야기

`SQL`을 기본적으로 매일 공부하고, 그리고 적용하자. 이제 본격적으로 다양하게 적용해보자. 


