
DON'T initialize variable in field declaration !
=> because it occurs after the super constructor and if super constructor call any abstract/overriden methods then variable is not initialized yet
   in the these !!!