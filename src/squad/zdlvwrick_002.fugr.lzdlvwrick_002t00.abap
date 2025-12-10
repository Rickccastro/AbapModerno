*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDLVWRICK_002...................................*
TABLES: ZDLVWRICK_002, *ZDLVWRICK_002. "view work areas
CONTROLS: TCTRL_ZDLVWRICK_002
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZDLVWRICK_002. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZDLVWRICK_002.
* Table for entries selected to show on screen
DATA: BEGIN OF ZDLVWRICK_002_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZDLVWRICK_002.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZDLVWRICK_002_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZDLVWRICK_002_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZDLVWRICK_002.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZDLVWRICK_002_TOTAL.

*.........table declarations:.................................*
TABLES: ZDLRICK_005                    .
