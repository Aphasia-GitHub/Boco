CREATE OR REPLACE FUNCTION F_CONVERTBL2XY(IN_CENTER_LONGITUDE IN NUMBER,
                                          IN_LONGITUDE        IN NUMBER,
                                          IN_LATITUDE         IN NUMBER)
--将经纬度(B,L)转成平面投影坐标(X,Y)--高斯-克吕格投影正解公式
  --convert by wangyuanwei 20150813
 RETURN VARCHAR2 IS
  CONST_CENTER_LONGITUDE NUMBER(38, 16) := IN_CENTER_LONGITUDE; --中央经度

  CONST_PI NUMBER(38, 36) := TRUNC(ACOS(-1), 36);

  CONST_SEMIMAJOR_AXIS NUMBER := 6378245; --椭球体长半轴
  CONST_SEMIMINOR_AXIS NUMBER(38, 16) := 6356863.0188; --椭球体短半轴

  CONST_CENTER_LONGITUDE_RADIAN NUMBER(38, 16) := CONST_CENTER_LONGITUDE *
                                                  CONST_PI / 180; --中央经度 弧度
  CONST_FE                      NUMBER := 500000 + TRUNC((TRUNC(CONST_CENTER_LONGITUDE + 0.5) - 72) / 6 + 13) *
                                          1000000; --中央经度所在的六度带ID

  VAR_E1 NUMBER(38, 16); --第一偏心率
  VAR_E2 NUMBER(38, 16); --第二偏心率
  VAR_E4 NUMBER(38, 16);
  VAR_E6 NUMBER(38, 16);

  VAR_M1 NUMBER(38, 16); -- (1-e*e/4-3*e*e*e*e/64-5*e*e*e*e*e*e/256)
  VAR_M2 NUMBER(38, 16); -- (3*e*e/8+3*e*e*e*e/32+45*e*e*e*e*e*e/1024)
  VAR_M3 NUMBER(38, 16); -- (15*e*e*e*e/256+45*e*e*e*e*e*e/1024)
  VAR_M4 NUMBER(38, 16); --35*e*e*e*e*e*e/3072

  VAR_LONGITUDE_RADIAN NUMBER(38, 16) := IN_LONGITUDE * CONST_PI / 180; --弧度
  VAR_LATITUDE_RADIAN  NUMBER(38, 16) := IN_LATITUDE * CONST_PI / 180; --弧度

  VAR_T  NUMBER(38, 16);
  VAR_C  NUMBER(38, 16);
  VAR_A  NUMBER(38, 16);
  VAR_RM NUMBER(38, 16);
  VAR_RN NUMBER(38, 16);

  VAR_OUT_X NUMBER(38, 16);
  VAR_OUT_Y NUMBER(38, 16);
BEGIN

  VAR_E1 := SQRT(1 -
                 POWER((CONST_SEMIMINOR_AXIS / CONST_SEMIMAJOR_AXIS), 2));
  VAR_E2 := SQRT(POWER((CONST_SEMIMAJOR_AXIS / CONST_SEMIMINOR_AXIS), 2) - 1);
  VAR_E4 := POWER(VAR_E1, 4);
  VAR_E6 := POWER(VAR_E1, 6);

  VAR_M1 := (1 - POWER(VAR_E1, 2) / 4 - 3 * VAR_E4 / 64 - 5 * VAR_E6 / 256);
  VAR_M2 := (3 * POWER(VAR_E1, 2) / 8 + 3 * VAR_E4 / 32 +
            45 * VAR_E6 / 1024);
  VAR_M3 := (15 * VAR_E4 / 256 + 45 * VAR_E6 / 1024);
  VAR_M4 := (35 * VAR_E6 / 3072);

  VAR_T := TAN(VAR_LATITUDE_RADIAN) * TAN(VAR_LATITUDE_RADIAN);
  VAR_C := VAR_E2 * VAR_E2 * COS(VAR_LATITUDE_RADIAN) *
           COS(VAR_LATITUDE_RADIAN);
  VAR_A := (VAR_LONGITUDE_RADIAN - CONST_CENTER_LONGITUDE_RADIAN) *
           COS(VAR_LATITUDE_RADIAN);

  VAR_RM := CONST_SEMIMAJOR_AXIS * (VAR_M1 * VAR_LATITUDE_RADIAN -
            VAR_M2 * SIN(2 * VAR_LATITUDE_RADIAN) +
            VAR_M3 * SIN(4 * VAR_LATITUDE_RADIAN) -
            VAR_M4 * SIN(6 * VAR_LATITUDE_RADIAN));
  VAR_RN := CONST_SEMIMAJOR_AXIS /
            SQRT(1 - VAR_E1 * VAR_E1 * SIN(VAR_LATITUDE_RADIAN) *
                 SIN(VAR_LATITUDE_RADIAN));

  VAR_OUT_X := 1.0 * (VAR_RM + VAR_RN * TAN(VAR_LATITUDE_RADIAN) *
               (VAR_A * VAR_A / 2 +
               (5 - VAR_T + 9 * VAR_C + 4 * VAR_C * VAR_C) *
               POWER(VAR_A, 4) / 24) +
               (61 - 58 * VAR_T + VAR_T * VAR_T + 270 * VAR_C -
               330 * VAR_T * VAR_C) * POWER(VAR_A, 6) / 720);
  VAR_OUT_Y := CONST_FE +
               1.0 * VAR_RN *
               (VAR_A + (1 - VAR_T + VAR_C) * POWER(VAR_A, 3) / 6 +
               (5 - 18 * VAR_T + VAR_T * VAR_T + 14 * VAR_C -
               58 * VAR_T * VAR_C) * POWER(VAR_A, 5) / 120);

  --RETURN TO_CHAR(VAR_OUT_X) || ',' || TO_CHAR(VAR_OUT_Y);
  RETURN TO_CHAR(VAR_OUT_X);
END F_CONVERTBL2XY;
