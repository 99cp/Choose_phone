# 핸드폰 골라줘

## 프로젝트 개요

### Q1. 프로젝트 동기
- 한국 시장에서 삼성 갤럭시와 애플 아이폰이 주를 이루는 현실
- 다양한 모델과 가격대 존재
- 경제적 제약이 있는 소비자들의 선택 어려움
- 복잡한 비교 과정을 단순화하고 접근성 높은 서비스 제공 목표

### Q2. 프로젝트 설명
- 다양한 스마트폰 제품 스펙을 수치화하여 비교
- 간단한 설문조사를 통해 사용자 요구사항 파악
- 설문 결과와 가장 근접한 스펙의 제품 추천

### Q3. 주요 로직
1. Python Selenium을 이용한 웹 스크래핑
   - chromeDriver를 이용해 [crawling.py](crawling.py)에서 웹 스크래핑 진행

2. 스크래핑 데이터 자동 정렬 및 DB 저장
   - [crawling.py](crawling.py) 내부에서 정렬 로직을 구현하여 DB에 데이터 저장

3. 사용자 맞춤 설문조사 진행
   - [surveyA.html](serveyA.html), [surveyB.html](surveyB.html)을 통해 사용자 요구사항 수집

4. 설문 결과 기반 제품 추천 알고리즘
   - 설문 결과 제출 시 [sorting.jsp](sorting.jsp)에서 설문 결과값을 기반으로 DB와 통신
   - 설문 결과값에 맞는 제품군 선별하여 total 테이블 생성 및 저장
   - [end.jsp](end.jsp)에서 total 테이블의 데이터를 정렬하여 최종 제품 추천

## 서비스 구조

1. 웹 스크래핑
2. 데이터 정렬 및 DB 저장
3. 메인 페이지
4. 설문 시작
5. 설문 진행
6. 설문 결과 분석
7. 맞춤 제품 추천

## 기술 스택

- Python
- JSP
- HTML & CSS
- Apache Tomcat
- PostgreSQL

## 팀 구성

- 총 2명의 팀원으로 구성

## 담당 역할

- Python Selenium을 활용한 웹 스크래핑 및 데이터 정렬
- JSP, Tomcat을 이용한 웹-DB 통신 구현
- HTML을 통한 웹 데이터 표현
- PostgreSQL 데이터베이스 관리

## 개선점

- 주기적으로 작동하는 웹 스크래핑 자동화 시스템 구현
- 설문 문항의 정밀도 향상
- 서비스 배포 및 실제 운영
- 모듈화 및 패키지화 필요

## 개발 기간

- 2022.08.29 ~ 2022.12.06

## 문서화

- [작품 계획서](작품계획서.pdf)
  - 작품 배경
  - 작품 주제
  - 시장 추세
  - 작품 목표
  - 실용적 근거
  - 기술 분석
  - 구현 환경
  - 추진 일정
  - 참고 문헌
