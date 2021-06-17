*
* $Id: tre0a0.s,v 1.1.1.1 1996/02/15 17:47:41 mclareni Exp $
*
* $Log: tre0a0.s,v $
* Revision 1.1.1.1  1996/02/15 17:47:41  mclareni
* Kernlib
*
*
#include "e0a0.inc"
TRE0A0    CSECT
#if defined(CERNLIB_QMIBMXA)
TRE0A0   AMODE ANY
TRE0A0   RMODE ANY
#endif
*
*               CALL TRE0A0(AREA,N)
*                  TRANSLATES N BYTES IN AREA
*
          B     12(15)            BRANCH PAST NAME
          DC    X'07',CL7'TRE0A0 '
*
          STM   14,12,12(13)
          BALR  12,0
          USING *,12
         B     START
TAB       E0A0
START     L     2,0(1)   ADDRESS OF AREA
          L     3,4(1)   ADDRESS OF N
          L     3,0(3)   VALUE OF N
          LA    4,256(0)  SET UP 256
LOOP      SR    3,4       SEE IF MORE THAN 256 LEFT
          BC    13,FINAL
          TR    0(256,2),TAB     TRANSLATE 256 BYTE AT A TIME
          LA    2,256(2)
          B    LOOP
FINAL     AR   3,4
          BC   8,RETURN    IF ZERO LEFT RETURN
          BCTR 3,0
          EX   3,TRA       TRANSLATE THE REST
RETURN    LM    2,12,28(13)       RESTORE REGISTERS
**        MVI   12(13),X'FF'
          BR    14
TRA       TR    0(,2),TAB
*
          END
