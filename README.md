BAI 1: KHOI TAO WORKFLOW CHAY UNIT TEST TU DONG CHO JAVA SPRING BOOT VOI GRADLE

1. MUC TIEU VA BOI CANH
Trong quy trinh phat trien phan mem hien dai (DevOps / CI-CD), viec tu dong hoa kiem thu (Automated Testing) giup phat hien som cac loi logic truoc khi ma nguon duoc hop nhat vao nhanh chinh. Bai tap nay thiet lap mot GitHub Actions Workflow tu dong kich hoat moi khi co su kien push len nhanh main, khoi tao moi truong Java 17 Temurin va thuc thi JUnit Tests thong qua Gradle Wrapper.

2. CAU TRUC DU AN JAVA SPRING BOOT GRADLE
Du an duoc to chuc theo cau truc tieu chuan cua Spring Boot va Gradle:
- build.gradle: Khai bao cac plugin org.springframework.boot (version 3.2.5), io.spring.dependency-management, Java sourceCompatibility 17, cac dependency spring-boot-starter-web va spring-boot-starter-test.
- settings.gradle: Dinh danh ten du an rootProject.name = 'spring-boot-gradle-app'.
- gradle/wrapper/: Chua file cau hinh gradle-wrapper.properties dinh nghia phien ban Gradle 8.7 phu hop.
- gradlew va gradlew.bat: Script thuc thi Gradle Wrapper da nen tang tren Linux/macOS va Windows.
- src/main/java/com/example/demo/Application.java: Lop khoi chay ung dung Spring Boot kem REST endpoint mau.
- src/test/java/com/example/demo/ApplicationTests.java: Lop kiem thu JUnit 5 xac thuc tinh san sang cua ung dung.
- .github/workflows/ci.yml: Tep cau hinh workflow GitHub Actions.

3. CAU HINH GITHUB ACTIONS WORKFLOW (.github/workflows/ci.yml)
Noi dung chi tiet cua tep cau hinh .github/workflows/ci.yml:

```yaml
name: Java Spring Boot CI (Gradle)

on:
  push:
    branches: [ "main" ]

jobs:
  test:
    name: Run Unit Tests
    runs-on: ubuntu-latest

    steps:
      - name: Checkout mã nguồn
        uses: actions/checkout@v5

      - name: Thiết lập môi trường Java JDK 17
        uses: actions/setup-java@v5
        with:
          java-version: '17'
          distribution: 'temurin'

      - name: Cấp quyền cho Gradle Wrapper
        run: chmod +x gradlew

      - name: Thực thi JUnit Test với Gradle
        run: ./gradlew test
```

4. PHAN TICH CHI TIET CAC BUOC TRONG WORKFLOW
- Trigger on.push.branches: [ "main" ]: Kich hoat luong CI tu dong ngay khi co commit moi duoc day len nhanh main.
- Job test: Chay tren moi truong may ao Ubuntu moi nhat (ubuntu-latest).
- Step Checkout ma nguon: Su dung action actions/checkout@v5 de lay toan bo ma nguon cua repository ve workspace cua runner.
- Step Thiet lap moi truong Java JDK 17: Su dung action actions/setup-java@v5 de cai dat JDK 17 tu nha phan phoi Eclipse Temurin, dam bao tinh tuong thich cao nhat voi Spring Boot 3.x.
- Step Cap quyen cho Gradle Wrapper: Thuc thi lenh chmod +x gradlew de cap quyen thuc thi (executable permission) cho tep script wrapper tren he dieu hanh Linux.
- Step Thuc thi JUnit Test: Thuc thi lenh ./gradlew test de bien dich ma nguon test va chay toan bo bo kiem thu JUnit 5. Ket qua kiem thu duoc tong hop va tra ve ma thoat (exit code 0 neu tat ca test deu vuot qua).

5. HUONG DAN KIEM TRA VA XAC NHAN KET QUA
- Day ma nguon len GitHub repository rikkei-devops-tmd/ss12-bt1.
- Truy cap tab Actions tren giao dien GitHub repository.
- Quan sat workflow Java Spring Boot CI (Gradle) duoc kich hoat tu dong boi commit push.
- Mo chi tiet Job Run Unit Tests va kiem tra log cua buoc Thuc thi JUnit Test voi Gradle.
- Xac nhan trang thai cua Job hien thi tich xanh (Success), bao hieu toan bo quy trinh CI chay thanh cong hoan toan.

