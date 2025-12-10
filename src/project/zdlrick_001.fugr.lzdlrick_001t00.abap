*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDLRICK_001.....................................*
DATA:  BEGIN OF STATUS_ZDLRICK_001                   .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDLRICK_001                   .
CONTROLS: TCTRL_ZDLRICK_001
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZDLRICK_001                   .
TABLES: ZDLRICK_001                    .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
