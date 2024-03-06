%let pgm=utl-using-null-empty-files-to-populate-arrays-scan-strings-or-execute-sql;

Using null empty files to populate arrays scan strings or execute sql

github
https://tinyurl.com/58e7n8ft
https://github.com/rogerjdeangelis/utl-using-null-empty-files-to-populate-arrays-scan-strings-or-execute-sql

Empty datasets and files have many uses in programming

   TWO SOLUTIONS

          1. sort the letters in a string in alphabetic order
          2. sql and datastep with empty sas dataset


SEE BART'S SAS-L POST FOR THE ORIGINAL WORK

https://listserv.uga.edu/scripts/wa-UGA.exe?A2=SAS-L;485edc4b.2403A&S=

https://tinyurl.com/ytrbds43
https://github.com/sascommunities/technical-support-code/blob/main/usage/programming/datastep_infile_trick.sas

Related repos
https://github.com/rogerjdeangelis/utl-processing-empty-files-along-with-files-containing-text
https://github.com/rogerjdeangelis/utl-the-four-types-of-empty-sas-tables




IN R, PYTHON AND SAS YOU CAN CREATE AND EMPTY DATAFRAME, FILES AND TABLES
==========================================================================

 1. R      empty<-data.frame(); which you can populate later

 2. Python empty = pd.DataFrame()

 3. SAS EMPTY (NULL TEXT FILE)

       Here we create a file with just one byte
       containing the EOF byte('1A'x).
       Actually the file has two EOFs?
       If you read the file using recfm=v the
       the datastep will exit immediately
       and no processing is possible, however
       if you use infile lrecl=32756 and recfm=f
       the first EOF is ignored?


       data _null_;
        file "c:/temp/null.txt" lrecl=1 recfm=f;
        put '1A'x;  /*EOF*/
       run;quit;

       Also intereting is assigning the input buffer to
       a long string and parsing it (not my work)

       input @;
       _infile_=string;  /* very lon string? */
       input (l1-l32756.) ($1.);



 4a SAS   EMPTY SAS DATASET(ACADEMIC EXERCISE NOT USEFUL>)

       For a SAS dataset to work in sql or datastep,
       we must have at least one variable.
       Having 1 deleted observation may be usefull?

       data template;
        retain template .;
        output;
       run;quit;

       data template  ;
         modify template
                template ;
         by template;
         remove;
       run;quit;

 4b    USEFUL

       * does not work in sql or datastep;
       data class;
         set sashelp.class(obs=0 drop=_all_);
       run;quit;

/****************************************************************************************************************************************/
/*                                                        |                                |                                            */
/*                       INPUT                            |      PROCESS                   |            OUTPUT                          */
/*                                                        |                                |                                            */
/*                                                        |                                |                                            */
/*  1. SORT THE LETTERS IN A STRING IN ALPHABETIC ORDER   |  data _null_;                  | STRING=abcdeeefghhijklmnoooopqrrsttuuvwxyz */
/*  ===================================================   |                                |                                            */
/*                                                        |   length string $ &l.;         |                                            */
/*  %let str=the quick brown fox jumps over the lazy dog; |      string=symget('str');     |                                            */
/*  %let len = %length(&str.);                            |                                |                                            */
/*                                                        |      infile "c:/temp/null.txt" |                                            */
/*  PUT THIS IN YOUR AUTOEXEC                             |        lrecl=32756 recfm=f;    |                                            */
/*                                                        |      * using recfm=f supresses |                                            */
/*  data _null_;                                          |        the first '1A'x EOF;    |                                            */
/*   file "c:/temp/null.txt" lrecl=1 recfm=f;             |                                |                                            */
/*   put '1A'x;                                           |      input @;                  |                                            */
/*  run;quit;                                             |      _infile_=string;          |                                            */
/*                                                        |      input (l1-l&l.) ($1.);    |                                            */
/*                                                        |                                |                                            */
/*                                                        |      call sortc(of L:);        |                                            */
/*                                                        |                                |                                            */
/*                                                        |      string = cats(of L:);     |                                            */
/*                                                        |      put string=;              |                                            */
/*                                                        |      stop;                     |                                            */
/*                                                        |    run;quit;                   |                                            */
/*                                                        |                                |                                            */
/*--------------------------------------------------------|--------------------------------|--------------------------------------------*/
/*                                                        |                                |                                            */
/*                                                        |                                |                                            */
/*  2. SQL AND DATASTEP WITH EMPTY SAS DATASET            |   Academic exercise (useless)  | TEMPLATE NAME    SEX AGE HEIGHTWEIGHT      */
/*  ==========================================            |   use table(obs=0) instad      |                                            */
/*                                                        |                                |     .    Alfred   M   14  69.0  112.5      */
/*  PUT THIS IN YOUR AUTOEXEC                             |   Update an empty dataset      |     .    Alice    F   13  56.5   84.0      */
/*                                                        |                                |     .    Barbara  F   13  65.3   98.0      */
/*   data template;                                       |   data template;               |     .    Carol    F   14  62.8  102.5      */
/*    retain template .;                                  |    set template sashelp.class ;|     .    Henry    M   14  63.5  102.5      */
/*    output;                                             |   run;quit;                    |     .    James    M   12  57.3   83.0      */
/*   run;quit;                                            |                                |                                            */
/*                                                        |    proc sql;                   |                                            */
/*   data template  ;                                     |     create table template as   |  NAME       AGE                            */
/*     modify template                                    |     select                     |                                            */
/*            template ;                                  |         "not added" as name    |  Alfred      14                            */
/*     by template;                                       |        ,99999999  as age       |  Alice       13                            */
/*     remove;                                            |     from                       |  Barbara     13                            */
/*   run;quit;                                            |        template                |  Carol       14                            */
/*                                                        |     union                      |  Henry       14                            */
/*                                                        |        all                     |                                            */
/*                                                        |     select                     |                                            */
/*                                                        |        name                    |                                            */
/*                                                        |       ,age                     |                                            */
/*                                                        |     from                       |                                            */
/*                                                        |        sashelp.class;          |                                            */
/*                                                        |    ;quit;                      |                                            */
/*                                                        |                                |                                            */
/*                                                        |                                |                                            */
/*                                                        |       NAME       AGE           |                                            */
/*                                                        |                                |                                            */
/*                                                        |       Alfred      14           |                                            */
/*                                                        |       Alice       13           |                                            */
/*                                                        |       Barbara     13           |                                            */
/*                                                        |       Carol       14           |                                            */
/*                                                        |       Henry       14           |                                            */
/*                                                        |                                |                                            */
/****************************************************************************************************************************************/

/*   _            _      __ _ _
/ | | |_ _____  _| |_   / _(_) | ___
| | | __/ _ \ \/ / __| | |_| | |/ _ \
| | | ||  __/>  <| |_  |  _| | |  __/
|_|  \__\___/_/\_\\__| |_| |_|_|\___|
 _                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

%utlfkil(c:/temp/null.txt);

%let str=the quick brown fox jumps over the lazy dog;
%let len = %length(&str.);

data _null_;
 file "c:/temp/null.txt" lrecl=1 recfm=f;
 put '1A'x;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  %let str=the quick brown fox jumps over the lazy dog;                                                                 */
/*  %let len = %length(&str.);                                                                                            */
/*                                                                                                                        */
/*  data _null_;                                                                                                          */
/*   file "c:/temp/null.txt" lrecl=1 recfm=f;                                                                             */
/*   put '1A'x;                                                                                                           */
/*  run;quit;                                                                                                             */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

 data _null_;

   length string $ &l.;
   string=symget('str');

   infile "c:/temp/null.txt" lrecl=&l recfm=f;
    input @;

     _infile_=string;
   input (l1-l&l.) ($1.);

   call sortc(of L:);

   string = cats(of L:);
   put string=;
   stop;
 run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  STRING=abcdeeefghhijklmnoooopqrrsttuuvwxyz                                                                            */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___                    _        _     _
|___ \   ___  __ _ ___  | |_ __ _| |__ | | ___
  __) | / __|/ _` / __| | __/ _` | `_ \| |/ _ \
 / __/  \__ \ (_| \__ \ | || (_| | |_) | |  __/
|_____| |___/\__,_|___/  \__\__,_|_.__/|_|\___|
 _                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/
*/

data template;
 retain template .;
 output;
run;quit;

data template  ;
  modify template
         template ;
  by template;
  remove;
run;quit;

/*___                             _       _            _
|___ \ __ _   ___  __ _ ___    __| | __ _| |_ __ _ ___| |_ ___ _ __
  __) / _` | / __|/ _` / __|  / _` |/ _` | __/ _` / __| __/ _ \ `_ \
 / __/ (_| | \__ \ (_| \__ \ | (_| | (_| | || (_| \__ \ ||  __/ |_) |
|_____\__,_| |___/\__,_|___/  \__,_|\__,_|\__\__,_|___/\__\___| .__/
                                                              |_|
*/

data template;
 set template sashelp.class ;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  NOTE: There were 0 observations read from the data set WORK.TEMPLATE.                                                 */
/*  NOTE: There were 19 observations read from the data set SASHELP.CLASS.                                                */
/*  NOTE: The data set WORK.TEMPLATE has 19 observations and 6 variables.                                                 */
/*                                                                                                                        */
/*  WORK.TE total obs=19                                                                                                  */
/*                                                                                                                        */
/*  Obs    TEMPLATE    NAME       SEX    AGE    HEIGHT    WEIGHT                                                          */
/*                                                                                                                        */
/*    1        .       Alfred      M      14     69.0      112.5                                                          */
/*    2        .       Alice       F      13     56.5       84.0                                                          */
/*    3        .       Barbara     F      13     65.3       98.0                                                          */
/*    4        .       Carol       F      14     62.8      102.5                                                          */
/*    5        .       Henry       M      14     63.5      102.5                                                          */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___  _                                 _
|___ \| |__    ___  __ _ ___   ___  __ _| |
  __) | `_ \  / __|/ _` / __| / __|/ _` | |
 / __/| |_) | \__ \ (_| \__ \ \__ \ (_| | |
|_____|_.__/  |___/\__,_|___/ |___/\__, |_|
                                      |_|
*/


proc datasets lib=work nolist nodetails mt=cat;
  delete template;
run;quit;


data template;
 retain template .;
 output;
run;quit;

data template  ;
  modify template
         template ;
  by template;
  remove;
run;quit;

proc sql;
 create table template as
 select
     "not in updated template" as name
    ,99999999                  as age
 from
    template
 union
    all
 select
    name
   ,age
 from
    sashelp.class;
;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* TEMPLATE total obs=19                                                                                                  */
/*                                                                                                                        */
/* Obs    NAME       AGE                                                                                                  */
/*                                                                                                                        */
/*   1    Alfred      14                                                                                                  */
/*   2    Alice       13                                                                                                  */
/*   3    Barbara     13                                                                                                  */
/*   4    Carol       14                                                                                                  */
/*   5    Henry       14                                                                                                  */
/*   6    James       12                                                                                                  */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
