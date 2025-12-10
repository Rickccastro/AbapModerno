*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDLVWRICK_001...................................*
TABLES: ZDLVWRICK_001, *ZDLVWRICK_001. "view work areas
CONTROLS: TCTRL_ZDLVWRICK_001
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZDLVWRICK_001. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZDLVWRICK_001.
* Table for entries selected to show on screen
DATA: BEGIN OF ZDLVWRICK_001_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZDLVWRICK_001.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZDLVWRICK_001_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZDLVWRICK_001_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZDLVWRICK_001.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZDLVWRICK_001_TOTAL.

*.........table declarations:.................................*
TABLES: ZDLRICK_004                    .
