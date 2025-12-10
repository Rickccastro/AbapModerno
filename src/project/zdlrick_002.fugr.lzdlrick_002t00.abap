*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDLRICK_002.....................................*
DATA:  BEGIN OF STATUS_ZDLRICK_002                   .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDLRICK_002                   .
CONTROLS: TCTRL_ZDLRICK_002
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZDLRICK_002                   .
TABLES: ZDLRICK_002                    .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
