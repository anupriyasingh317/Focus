//FOCJOB1 JOB (ACCT#),'DEL & RUN & FTP SAMPLE16',          
//         MSGCLASS=X,CLASS=A,NOTIFY=&SYSUID,REGION=0M        
//*********************************************************
//*  DELETE EXISTING OUTPUT FILE
//*********************************************************
//STEP1    EXEC PGM=IDCAMS                                  
//SYSPRINT DD   SYSOUT=*                                  
//SYSIN    DD   *                                          
  DELETE 'MYID.USER.SAMPLE16.XCEL1'
  DELETE 'MYID.USER.SAMPLE16.XCEL2'            
/*   
//*********************************************************
//*   RUN FOCUS PROGRAM SAMPLE16
//*********************************************************                                                    
//STEP2    EXEC PGM=SAMPLE16,REGION=4M                           
//STEPLIB  DD   DSN=IBI.FOCLIB.LOAD,DISP=SHR                        
//SYSIN    DD   *
 EX SAMPLE16  OPTION='R'
 FIN
//SYSPRINT DD   SYSOUT=*
//SYSOUT   DD   SYSOUT=*
//CITYWISE DD   DSN=MYID.USER.SAMPLE16.XCEL1,                
//             DISP=(NEW,CATLG,DELETE),                    
//             UNIT=SYSDA,                                 
//             SPACE=(CYL,(5,1)),                          
//             DCB=(RECFM=FB,LRECL=80)                                    
//PRODDATA DD   DSN=MYID.USER.SAMPLE16.XCEL2,                
//             DISP=(NEW,CATLG,DELETE),                    
//             UNIT=SYSDA,                                 
//             SPACE=(CYL,(5,1)),                          
//             DCB=(RECFM=FB,LRECL=80) 
//*********************************************************
//*  SEND THE OUTPUT TO SERVER
//*********************************************************                    
//STEP3    EXEC PGM=FTP,PARM='(EXIT'                       
//SYSIN    DD   *                                          
  open   ftp.myserver.com               
  user   ftpuserid ftppassword             
  binary                       
  cd     /incoming/samples     
  put    'MYID.USER.SAMPLE16.XCEL1' CITYWISE.xls 
  put    'MYID.USER.SAMPLE16.XCEL2' PRODDATA.xls             
  quit                          
/*                                                       
//FTPDATA  DD   SYSOUT=*                                   
//FTPSYST  DD   SYSOUT=*                                   


