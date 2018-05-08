. keep if !missing(picture, senility)
(0 observations deleted)

. logit senility picture

Iteration 0:   log likelihood = -13.862944  
Iteration 1:   log likelihood = -8.0259967  
Iteration 2:   log likelihood =  -8.024565  
Iteration 3:   log likelihood = -8.0245642  

Logistic regression                               Number of obs   =         20
                                                  LR chi2(1)      =      11.68
                                                  Prob > chi2     =     0.0006
Log likelihood = -8.0245642                       Pseudo R2       =     0.4212

------------------------------------------------------------------------------
    senility |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
     picture |  -.7721148   .3578407    -2.16   0.031     -1.47347   -.0707599
       _cons |   5.426567   2.627976     2.06   0.039     .2758298     10.5773
------------------------------------------------------------------------------

. bysort senility: su picture

---------------------------------------------------------------------------------------------------
-> senility = no

    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
     picture |        10         9.2    2.529822          6         14

---------------------------------------------------------------------------------------------------
-> senility = yes

    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
     picture |        10         4.8     2.65832          1          9
     

. di _b[_cons] + 0* _b[picture]
5.4265673

. di exp( _b[_cons] + 0* _b[picture]) / (1+ _b[_cons] + exp( _b[_cons] + 0* _b[picture]))
.97251184

. di _b[_cons] + 20* _b[picture]
-10.015728

. di exp( _b[_cons] + 20* _b[picture]) / (1+ _b[_cons] + exp( _b[_cons] + 20* _b[picture]))
6.954e-06

. twoway function exp( _b[_cons] + x* _b[picture]) / (1+ _b[_cons] + exp( _b[_cons] + x* _b[picture
> ])), range(-0 50)

. graph twoway mspline senility picture, bands(30)



