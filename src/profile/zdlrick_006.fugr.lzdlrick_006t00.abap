*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDLRICK_006.....................................*
DATA:  BEGIN OF STATUS_ZDLRICK_006                   .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDLRICK_006                   .
CONTROLS: TCTRL_ZDLRICK_006
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZDLRICK_006                   .
TABLES: ZDLRICK_006                    .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
