*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDLRICK_003.....................................*
DATA:  BEGIN OF STATUS_ZDLRICK_003                   .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDLRICK_003                   .
CONTROLS: TCTRL_ZDLRICK_003
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZDLRICK_003                   .
TABLES: ZDLRICK_003                    .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
