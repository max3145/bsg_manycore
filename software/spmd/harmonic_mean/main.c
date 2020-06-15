#include <math.h>
#include "bsg_manycore.h"
#include "bsg_set_tile_x_y.h"
#define N 64
#define hex(X) (*(int*)&X)

float data[N] = {
  -520311.639057,193402.541401,-444466.109306,-450536.934496,-483439.986456,57275.833164,71400.860806,156397.232912,
  -290393.200597,-382194.445563,-440018.010405,-275141.251437,333094.128646,111039.359944,324671.001660,783622.466412,
  -797433.106648,-760101.899083,928896.967881,-915209.368226,945082.582149,-842735.097809,602403.309617,-368902.441491,
  -65198.780830,456734.721256,-28396.338852,-822468.646486,-284222.613730,98899.384537,357039.031906,-349949.474461,
  701781.324206,14491.625802,-131697.957210,-180874.710490,286845.183894,409902.783678,-396885.752667,251487.988870,
  -714107.433852,-46819.508590,-870862.910716,-254420.806843,-358559.590567,-247299.320674,507794.593141,849813.703410,
  -360592.619301,-531355.901949,-809414.516617,882709.410800,-880199.257730,102289.501445,306904.505904,-8820.951668,
  -514107.747947,-84449.422286,-566099.626574,611795.104613,-963552.921548,-64375.775053,-298761.961770,820777.943281
};


int main()
{

  float bottom = 0.0f;

  for (int i = 0; i < N; i++)
  {
    bottom += (1.0f/data[i]);
  }

  float mean = 64.0f / bottom;
  bsg_printf("mean = %x\n", hex(mean));

  if (hex(mean) == 0xc909a3f9)
    bsg_finish();
  else
    bsg_fail();

  bsg_wait_while(1);
  
}
