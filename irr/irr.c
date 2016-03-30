//
//  irr.c
//  irr
//
//  Created by abreu on 2016/3/29.
//  Copyright © 2016年 abreu. All rights reserved.
//

#include "irr.h"
#include <math.h>

#define LOW_RATE -2.0
#define HIGH_RATE 2.0
#define MAX_ITERATION 1000
#define PRECISION_REQ 0.00000001
double computeIRR(double *cf[],int *numOfFlows )
{
    int i = 0,j = 0;
//    double m = 0.0;
    double old = 0.00;
    double new = 0.00;
    double oldguessRate = LOW_RATE;
    double newguessRate = LOW_RATE;
    double guessRate = LOW_RATE;
    double lowGuessRate = LOW_RATE;
    double highGuessRate = HIGH_RATE;
    double npv = 0.0;
    double denom = 0.0;

   

    printf("SIZE %d \n",*numOfFlows);
    for (i=0;i<*numOfFlows;i++){

        printf("TEST Data %f \n", *(cf[0]+i));
    }
    
    for(i=0; i<MAX_ITERATION; i++)
    {
        npv = 0.00;
        for(j=0; j<*numOfFlows; j++)
        {
            denom = pow( (1 + guessRate),j);
           

            npv = npv + (*(cf[0]+j)/denom);
        }
        /* Stop checking once the required precision is achieved */
        if((npv > 0) && (npv < PRECISION_REQ))
            break;
        if(old == 0)
            old = npv;
        else
            old = new;
        new = npv;
        if(i > 0)
        {
            if(old < new)
            {
                if(old < 0 && new < 0)
                    highGuessRate = newguessRate;
                else
                    lowGuessRate = newguessRate;
            }
            else
            {
                if(old > 0 && new > 0)
                    lowGuessRate = newguessRate;
                else
                    highGuessRate = newguessRate;
            }
        }
        oldguessRate = guessRate;
        guessRate = (lowGuessRate + highGuessRate) / 2;
        newguessRate = guessRate;
    }
    return guessRate;
}
