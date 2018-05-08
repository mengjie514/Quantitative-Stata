. use "/Users/wang/Downloads/hten-2.dta"

. des

Contains data from /Users/wang/Downloads/hten-2.dta
  obs:        15,627                          
 vars:            11                          22 Mar 2011 15:24
 size:       375,048 (99.9% of memory free)
---------------------------------------------------------------------------------------------------
              storage  display     value
variable name   type   format      label      variable label
---------------------------------------------------------------------------------------------------
hid             long   %12.0g                 household identification number
sex             byte   %8.0g       osex       sex
jbstat          byte   %8.0g       ojbstat    current economic activity
mastat          byte   %8.0g       omastat    marital status
age             byte   %8.0g       oage       age at date of interview
nchild          byte   %8.0g       onchild    number of own children in household
qfedhi          byte   %8.0g       oqfedhi    highest educational qualification
spjb            byte   %23.0g      ospjb      whether spouse/partner employed now
tenure          byte   %8.0g       otenure    housing tenure
educ            float  %9.0g       ed3        Highest Educational Level
class           float  %26.0g      class      Social Class (Goldthorpe scheme)
---------------------------------------------------------------------------------------------------
Sorted by:  

. tab tenure

               housing tenure   |      Freq.     Percent        Cum.
--------------------------------+-----------------------------------
                owned outright  |      4,701       30.33       30.33
        owned with mortgage     |      7,147       46.11       76.44
        local authority rented  |      1,695       10.94       87.37
        housing assoc. rented   |        653        4.21       91.59
        rented from employer    |         99        0.64       92.23
rented private unfurnished      |        697        4.50       96.72
rented private furnished        |        454        2.93       99.65
                other rented    |         54        0.35      100.00
--------------------------------+-----------------------------------
                          Total |     15,500      100.00

. tab tenure, nol

    housing |
   tenure   |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |      4,701       30.33       30.33
          2 |      7,147       46.11       76.44
          3 |      1,695       10.94       87.37
          4 |        653        4.21       91.59
          5 |         99        0.64       92.23
          6 |        697        4.50       96.72
          7 |        454        2.93       99.65
          8 |         54        0.35      100.00
------------+-----------------------------------
      Total |     15,500      100.00

. label list otenure
otenure:
          -9 missing
          -7 telephone int. only    
           1 owned outright 
           2 owned with mortgage    
           3 local authority rented 
           4 housing assoc. rented  
           5 rented from employer   
           6 rented private unfurnished     
           7 rented private furnished       
           8 other rented   

. gen owner = inlist(tenure, 1,2)
. tab owner

      owner |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      3,779       24.18       24.18
          1 |     11,848       75.82      100.00
------------+-----------------------------------
      Total |     15,627      100.00
      
      

. replace owner = . if missing(tenure)
(127 real changes made, 127 to missing)


. tab own2

  RECODE of |
     tenure |
   (housing |
  tenure  ) |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      3,652       23.56       23.56
          1 |     11,848       76.44      100.00
------------+-----------------------------------
      Total |     15,500      100.00
      
. label define own2 0 "rest" 1 "owned outright & owned with mortgage"

. label values own2 own2

. tab own2

 RECODE of tenure (housing tenure  ) |      Freq.     Percent        Cum.
-------------------------------------+-----------------------------------
                                rest |      3,652       23.56       23.56
owned outright & owned with mortgage |     11,848       76.44      100.00
-------------------------------------+-----------------------------------
                               Total |     15,500      100.00




// RECODE MASTAT
. tab mastat

       marital status   |      Freq.     Percent        Cum.
------------------------+-----------------------------------
        child under 16  |         50        0.32        0.32
                married |      8,106       51.89       52.21
living as couple        |      1,838       11.77       63.97
                widowed |      1,152        7.37       71.35
        divorced        |        858        5.49       76.84
        separated       |        278        1.78       78.62
        never married   |      3,340       21.38      100.00
------------------------+-----------------------------------
                  Total |     15,622      100.00
                  
. tab mastat, nol

    marital |
   status   |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |         50        0.32        0.32
          1 |      8,106       51.89       52.21
          2 |      1,838       11.77       63.97
          3 |      1,152        7.37       71.35
          4 |        858        5.49       76.84
          5 |        278        1.78       78.62
          6 |      3,340       21.38      100.00
------------+-----------------------------------
      Total |     15,622      100.00
      
. recode mastat 0=6
(mastat: 50 changes made)

. recode mastat 1/2=1 3/6=2, gen(newmastat)
(7516 differences between mastat and newmastat)

. label define newmastat 1 "married & living as couple" 2 "single"

. label values newmastat newmastat

. tab newmastat

 RECODE of mastat (marital |
                 status  ) |      Freq.     Percent        Cum.
---------------------------+-----------------------------------
married & living as couple |      9,944       63.65       63.65
                    single |      5,678       36.35      100.00
---------------------------+-----------------------------------
                     Total |     15,622      100.00


// LOGISTIC WITH SINGLE VARIBALE 
. des
Contains data from /Users/wang/Downloads/hten-4.dta
  obs:        15,627                          
 vars:            13                          22 Mar 2011 15:24
 size:       453,183 (99.9% of memory free)
--------------------------------------------------------------------------------------------------------
              storage  display     value
variable name   type   format      label      variable label
--------------------------------------------------------------------------------------------------------
hid             long   %12.0g                 household identification number
sex             byte   %8.0g       osex       sex
jbstat          byte   %8.0g       ojbstat    current economic activity
mastat          byte   %8.0g       omastat    marital status
age             byte   %8.0g       oage       age at date of interview
nchild          byte   %8.0g       onchild    number of own children in household
qfedhi          byte   %8.0g       oqfedhi    highest educational qualification
spjb            byte   %23.0g      ospjb      whether spouse/partner employed now
tenure          byte   %8.0g       otenure    housing tenure
educ            float  %9.0g       ed3        Highest Educational Level
class           float  %26.0g      class      Social Class (Goldthorpe scheme)
owner           float  %9.0g                  
own2            byte   %36.0g      own2       RECODE of tenure (housing tenure )
--------------------------------------------------------------------------------------------------------
Sorted by:  
     Note:  dataset has changed since last saved

. stepwise, pr(.01): logistic own2 sex jbstat mastat age nchild qfedhi spjb educ class
                      begin with full model
p < 0.0100            for all terms in model

Logistic regression                               Number of obs   =      10891
                                                  LR chi2(9)      =    1298.18
                                                  Prob > chi2     =     0.0000
Log likelihood = -5249.5106                       Pseudo R2       =     0.1100

------------------------------------------------------------------------------
        own2 | Odds Ratio   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         sex |   .8477247   .0436104    -3.21   0.001     .7664178    .9376572
      jbstat |    .893303   .0112874    -8.93   0.000     .8714517    .9157021
      mastat |   .7267797   .0164553   -14.10   0.000     .6952331    .7597578
         age |   1.008972   .0016746     5.38   0.000     1.005695     1.01226
      nchild |   .8347827   .0256499    -5.88   0.000     .7859936    .8866003
      qfedhi |   .8602635   .0132587    -9.77   0.000     .8346655    .8866465
        spjb |    1.29579   .0716389     4.69   0.000      1.16272     1.44409
        educ |   1.202879   .0642435     3.46   0.001      1.08333     1.33562
       class |    .822211   .0141739   -11.36   0.000     .7948948     .850466
------------------------------------------------------------------------------

. logit own2 age

Iteration 0:   log likelihood = -8462.2668  
Iteration 1:   log likelihood = -8396.1105  
Iteration 2:   log likelihood = -8395.8593  
Iteration 3:   log likelihood = -8395.8593  

Logistic regression                               Number of obs   =      15499
                                                  LR chi2(1)      =     132.81
                                                  Prob > chi2     =     0.0000
Log likelihood = -8395.8593                       Pseudo R2       =     0.0078

------------------------------------------------------------------------------
        own2 |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         age |   .0119102   .0010456    11.39   0.000     .0098608    .0139596
       _cons |   .6421907   .0495884    12.95   0.000     .5449992    .7393822
------------------------------------------------------------------------------

. logit own2 c.age##c.age

Iteration 0:   log likelihood = -8462.2668  
Iteration 1:   log likelihood = -8268.4968  
Iteration 2:   log likelihood = -8265.6118  
Iteration 3:   log likelihood = -8265.6116  

Logistic regression                               Number of obs   =      15499
                                                  LR chi2(2)      =     393.31
                                                  Prob > chi2     =     0.0000
Log likelihood = -8265.6116                       Pseudo R2       =     0.0232

------------------------------------------------------------------------------
        own2 |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         age |   .0902015   .0049133    18.36   0.000     .0805715    .0998315
             |
 c.age#c.age |  -.0008169   .0000498   -16.42   0.000    -.0009145   -.0007194
             |
       _cons |  -.9270015   .1072065    -8.65   0.000    -1.137122   -.7168807
------------------------------------------------------------------------------

. predict phat 
(option pr assumed; Pr(own2))
(1 missing values generated)

. graph twoway connected phat age


// CHILD 
. logit own2 nchild 

Iteration 0:   log likelihood = -8461.4606  
Iteration 1:   log likelihood = -8461.2454  
Iteration 2:   log likelihood = -8461.2454  

Logistic regression                               Number of obs   =      15496
                                                  LR chi2(1)      =       0.43
                                                  Prob > chi2     =     0.5118
Log likelihood = -8461.2454                       Pseudo R2       =     0.0000

------------------------------------------------------------------------------
        own2 |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
      nchild |  -.0134995   .0205352    -0.66   0.511    -.0537477    .0267487
       _cons |   1.183356   .0216062    54.77   0.000     1.141008    1.225703
------------------------------------------------------------------------------

. logit own2 c.age##c.age nchild

Iteration 0:   log likelihood = -8461.1918  
Iteration 1:   log likelihood = -8263.1463  
Iteration 2:   log likelihood = -8260.2191  
Iteration 3:   log likelihood = -8260.2189  

Logistic regression                               Number of obs   =      15495
                                                  LR chi2(3)      =     401.95
                                                  Prob > chi2     =     0.0000
Log likelihood = -8260.2189                       Pseudo R2       =     0.0238

------------------------------------------------------------------------------
        own2 |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         age |   .0942142   .0051064    18.45   0.000     .0842059    .1042226
             |
 c.age#c.age |   -.000865   .0000524   -16.52   0.000    -.0009676   -.0007623
             |
      nchild |  -.0669331   .0221012    -3.03   0.002    -.1102506   -.0236156
       _cons |  -.9585015   .1079612    -8.88   0.000    -1.170101   -.7469015
------------------------------------------------------------------------------

 logit own2 nchild jbstat mastat qfedhi

Iteration 0:   log likelihood = -7752.4855  
Iteration 1:   log likelihood = -7036.0378  
Iteration 2:   log likelihood = -7010.4385  
Iteration 3:   log likelihood = -7010.3845  
Iteration 4:   log likelihood = -7010.3845  

Logistic regression                               Number of obs   =      14224
                                                  LR chi2(4)      =    1484.20
                                                  Prob > chi2     =     0.0000
Log likelihood = -7010.3845                       Pseudo R2       =     0.0957

------------------------------------------------------------------------------
        own2 |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
      nchild |  -.2546836   .0235586   -10.81   0.000    -.3008576   -.2085097
      jbstat |  -.1177394   .0101842   -11.56   0.000    -.1377001   -.0977788
      mastat |   -.268892    .010477   -25.66   0.000    -.2894266   -.2483575
      qfedhi |  -.1313412   .0063399   -20.72   0.000    -.1437672   -.1189152
       _cons |   3.386438   .0699558    48.41   0.000     3.249327    3.523548
-----------------------------------------------------------------------



// Mastat 
tab mastat 

       marital status   |      Freq.     Percent        Cum.
------------------------+-----------------------------------
        child under 16  |         50        0.32        0.32
                married |      8,106       51.89       52.21
living as couple        |      1,838       11.77       63.97
                widowed |      1,152        7.37       71.35
        divorced        |        858        5.49       76.84
        separated       |        278        1.78       78.62
        never married   |      3,340       21.38      100.00
------------------------+-----------------------------------
                  Total |     15,622      100.00

. tab mastat, nol 

    marital |
   status   |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |         50        0.32        0.32
          1 |      8,106       51.89       52.21
          2 |      1,838       11.77       63.97
          3 |      1,152        7.37       71.35
          4 |        858        5.49       76.84
          5 |        278        1.78       78.62
          6 |      3,340       21.38      100.00
------------+-----------------------------------
      Total |     15,622      100.00

. recode mastat 0=6
(mastat: 50 changes made)

recode mastat 1/2=1 3/6=0, gen (nmastat)
(7516 differences between mastat and nmastat)

. tab nmastat, nol

  RECODE of |
     mastat |
   (marital |
  status  ) |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      5,678       36.35       36.35
          1 |      9,944       63.65      100.00
------------+-----------------------------------
      Total |     15,622      100.00
      
. tab nmastat

 RECODE of mastat (marital |
                 status  ) |      Freq.     Percent        Cum.
---------------------------+-----------------------------------
                 otherwise |      5,678       36.35       36.35
married & living as couple |      9,944       63.65      100.00
---------------------------+-----------------------------------
                     Total |     15,622      100.00



. logit own2 nmastat

Iteration 0:   log likelihood = -8460.2839  
Iteration 1:   log likelihood = -8146.4054  
Iteration 2:   log likelihood = -8140.9333  
Iteration 3:   log likelihood = -8140.9325  

Logistic regression                               Number of obs   =      15496
                                                  LR chi2(1)      =     638.70
                                                  Prob > chi2     =     0.0000
Log likelihood = -8140.9325                       Pseudo R2       =     0.0377

------------------------------------------------------------------------------
        own2 |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
     nmastat |   .9759509   .0387291    25.20   0.000     .9000432    1.051859
       _cons |   .6102845   .0280026    21.79   0.000     .5554005    .6651686
------------------------------------------------------------------------------

. dis exp(_b[nmastat])
2.6536895



. logit own2 mastat

Iteration 0:   log likelihood = -8460.2839  
Iteration 1:   log likelihood = -8128.2445  
Iteration 2:   log likelihood = -8121.1943  
Iteration 3:   log likelihood = -8121.1935  
Iteration 4:   log likelihood = -8121.1935  

Logistic regression                               Number of obs   =      15496
                                                  LR chi2(1)      =     678.18
                                                  Prob > chi2     =     0.0000
Log likelihood = -8121.1935                       Pseudo R2       =     0.0401

------------------------------------------------------------------------------
        own2 |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
      mastat |  -.2349567    .008994   -26.12   0.000    -.2525846   -.2173288
       _cons |   1.839041   .0335908    54.75   0.000     1.773205    1.904878
------------------------------------------------------------------------------




// CLASS


. tab class

  Social Class (Goldthorpe |
                   scheme) |      Freq.     Percent        Cum.
---------------------------+-----------------------------------
   Managerial/Professional |      3,982       33.45       33.45
        Routine non manual |      2,975       24.99       58.44
    Self-employed/employer |        886        7.44       65.88
Skilled/supervisory manual |      1,589       13.35       79.23
    Semi-/unskilled manual |      2,473       20.77      100.00
---------------------------+-----------------------------------
                     Total |     11,905      100.00

. tab class, nol

     Social |
      Class |
(Goldthorpe |
    scheme) |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |      3,982       33.45       33.45
          2 |      2,975       24.99       58.44
          3 |        886        7.44       65.88
          4 |      1,589       13.35       79.23
          5 |      2,473       20.77      100.00
------------+-----------------------------------
      Total |     11,905      100.00

.  recode class 1/3=1 4/5=0, gen(nclass)
(7923 differences between class and nclass)

. label define nclass 1 "managerial & routine non manual & self-employed" 0 "otherwise"

. label values nclass nclass


. tab nclass

          RECODE of class (Social Class |
                   (Goldthorpe scheme)) |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
                              otherwise |      4,062       34.12       34.12
managerial & routine non manual & self- |      7,843       65.88      100.00
----------------------------------------+-----------------------------------
                                  Total |     11,905      100.00

. tab nclass 

  RECODE of |
      class |
    (Social |
      Class |
(Goldthorpe |
   scheme)) |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      4,062       34.12       34.12
          1 |      7,843       65.88      100.00
------------+-----------------------------------
      Total |     11,905      100.00

. logit own2 nclass 

Iteration 0:   log likelihood =  -6395.314  
Iteration 1:   log likelihood = -6199.6215  
Iteration 2:   log likelihood =  -6196.458  
Iteration 3:   log likelihood = -6196.4576  

Logistic regression                               Number of obs   =      11825
                                                  LR chi2(1)      =     397.71
                                                  Prob > chi2     =     0.0000
Log likelihood = -6196.4576                       Pseudo R2       =     0.0311

------------------------------------------------------------------------------
        own2 |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
      nclass |   .8926865   .0446557    19.99   0.000     .8051629    .9802101
       _cons |   .6602238   .0332247    19.87   0.000     .5951045    .7253431
------------------------------------------------------------------------------

. predict phat 
(option pr assumed; Pr(own2))
(3722 missing values generated)

. graph twoway connected phat nclass

(comparing with)
drop phat 
logit own2 class 
predict phat 
graph twoway connected phat class 




// QFEDHI 
. tab qfedhi 

            highest educational |
               qualification    |      Freq.     Percent        Cum.
--------------------------------+-----------------------------------
                higher degree   |        425        2.97        2.97
                first degree    |      1,597       11.15       14.12
                teaching qf     |        340        2.37       16.49
                other higher qf |      3,434       23.98       40.47
                nursing qf      |        161        1.12       41.59
                gce a levels    |      1,811       12.64       54.24
        gce o levels or equiv   |      2,518       17.58       71.82
commercial qf, no o levels      |        331        2.31       74.13
cse grade 2-5,scot grade 4-5    |        421        2.94       77.07
                apprenticeship  |        257        1.79       78.86
                other qf        |        102        0.71       79.58
                        no qf   |      2,787       19.46       99.04
        still at school no qf   |        138        0.96      100.00
--------------------------------+-----------------------------------
                          Total |     14,322      100.00

. tab qfedhi, nol 

    highest |
educational |
qualificati |
      on    |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |        425        2.97        2.97
          2 |      1,597       11.15       14.12
          3 |        340        2.37       16.49
          4 |      3,434       23.98       40.47
          5 |        161        1.12       41.59
          6 |      1,811       12.64       54.24
          7 |      2,518       17.58       71.82
          8 |        331        2.31       74.13
          9 |        421        2.94       77.07
         10 |        257        1.79       78.86
         11 |        102        0.71       79.58
         12 |      2,787       19.46       99.04
         13 |        138        0.96      100.00
------------+-----------------------------------
      Total |     14,322      100.00

. recode qfedhi 1/6=1 7/13=0, gen(nqfedhi)
(13897 differences between qfedhi and nqfedhi)

. label define nqfedhi 1 "higher educational qualification" 0 "otherwise"

. label values nqfedhi nqfedhi

. tab nqfedhi

       RECODE of qfedhi (highest |
   educational qualification   ) |      Freq.     Percent        Cum.
---------------------------------+-----------------------------------
                       otherwise |      6,554       45.76       45.76
higher educational qualification |      7,768       54.24      100.00
---------------------------------+-----------------------------------
                           Total |     14,322      100.00

. tab nqfedhi

  RECODE of |
     qfedhi |
   (highest |
educational |
qualificati |
     on   ) |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      6,554       45.76       45.76
          1 |      7,768       54.24      100.00
------------+-----------------------------------
      Total |     14,322      100.00

. logit own2 nqfedhi

Iteration 0:   log likelihood = -7759.0832  
Iteration 1:   log likelihood = -7581.5141  
Iteration 2:   log likelihood = -7579.7816  
Iteration 3:   log likelihood = -7579.7815  

Logistic regression                               Number of obs   =      14231
                                                  LR chi2(1)      =     358.60
                                                  Prob > chi2     =     0.0000
Log likelihood = -7579.7815                       Pseudo R2       =     0.0231

------------------------------------------------------------------------------
        own2 |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
     nqfedhi |   .7552637   .0403102    18.74   0.000     .6762571    .8342703
       _cons |   .8081028    .026839    30.11   0.000     .7554993    .8607062
------------------------------------------------------------------------------


. logit own2 nclass nqfedhi nmastat c.age##c.age

Iteration 0:   log likelihood = -5899.3944  
Iteration 1:   log likelihood = -5410.5733  
Iteration 2:   log likelihood = -5394.9472  
Iteration 3:   log likelihood = -5394.9296  
Iteration 4:   log likelihood = -5394.9296  

Logistic regression                               Number of obs   =      10894
                                                  LR chi2(5)      =    1008.93
                                                  Prob > chi2     =     0.0000
Log likelihood = -5394.9296                       Pseudo R2       =     0.0855

------------------------------------------------------------------------------
        own2 |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
      nclass |   .6561952   .0499964    13.12   0.000     .5582041    .7541864
     nqfedhi |   .6360862   .0523193    12.16   0.000     .5335423    .7386301
     nmastat |   .7851561   .0529116    14.84   0.000     .6814513     .888861
         age |   .0468735   .0069804     6.72   0.000     .0331923    .0605548
             |
 c.age#c.age |  -.0003305   .0000701    -4.72   0.000    -.0004679   -.0001931
             |
       _cons |  -1.352842   .1482633    -9.12   0.000    -1.643433   -1.062251
------------------------------------------------------------------------------














