//MYJOB    JOB (ACCT#),'CHAINED FOCUS & COBOL',
//         MSGCLASS=X,CLASS=A,NOTIFY=&SYSUID
//*
//*
//* STEP1: DELETE existing SAMPLE16 output
//*
//STEP1   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  DELETE 'MYID.OUTPUT.SAMPLE17' 
/*
//*------------------------------------------------------------
//* STEP2: RUN FOCEXEC SAMPLE17 → consume both inputs, produce SAMPLE17
//*------------------------------------------------------------
//STEP2   EXEC PGM=FOCUS,REGION=4M
//STEPLIB DD DSN=IBI.FOCLIB.LOAD,DISP=SHR
//SYSIN    DD *
   EX SAMPLE17  &CITY='MUMBAI'
   EX SAMPLE15
   FIN
//SALES    DD DSN=MYID.INPUT.SALES,DISP=SHR 
//EMPLOYEE DD DSN=MYID.INPUT.EMPLOYEE,DISP=SHR 
//SYSPRINT DD SYSOUT=*
//INFO     DD DSN=MYID.OUTPUT.SAMPLE17,
//             DISP=(NEW,CATLG,DELETE),
//             UNIT=SYSDA,SPACE=(CYL,(5,1)),
//             DCB=(RECFM=FB,LRECL=80)
//
//*------------------------------------------------------------
//* STEP3: EMAIL SAMPLE17 output via JES DEST=(SMTP,...)
//*------------------------------------------------------------
//STEP3   EXEC PGM=IEBGENER
//SYSUT1   DD DSN=MYID.OUTPUT.SAMPLE17,DISP=SHR
//SYSUT2   DD SYSOUT=(B,SMTP)
//SYSPRINT DD SYSOUT=*



