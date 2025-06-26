EXTEND_BOTTOM BOTSMITH 4
  IF ~PartyHasItem("g3cluck0")~ THEN GOTO PartyHasAtLeastOneItem
END

APPEND BOTSMITH
  IF ~~ THEN BEGIN PartyHasAtLeastOneItem SAY @1038
   IF ~PartyHasItem("miscau")
       PartyHasItem("miscb4")~ THEN GOTO PartyHasAllParts
   IF ~OR(2)
       !PartyHasItem("miscau")
       !PartyHasItem("miscb4")~ THEN GOTO PartyDoesNotHaveAllParts
  END

  IF ~~ THEN BEGIN PartyDoesNotHaveAllParts SAY @1039
   IF ~~ THEN GOTO MovingRightAlong
  END

  IF ~~ THEN BEGIN PartyHasAllParts SAY @1040
   IF ~PartyGoldLT(5000)~ THEN REPLY #66633 GOTO 10
   IF ~PartyGoldGT(4999)~ THEN DO ~SetGlobal("g3cupgrade","GLOBAL",1)
                                   TakePartyGold(5000)
                                   TakePartyItemNum("g3cluck0",1)
                                   DestroyItem("g3cluck0") 
                                   TakePartyItemNum("miscau",1)  
                                   DestroyItem("miscau")  
                                   TakePartyItemNum("miscb4",1) 
                                   DestroyItem("miscb4")  
                                   DestroyGold(5000)~ REPLY #66706 GOTO 11
   IF ~~ THEN REPLY #66650 GOTO MovingRightAlong
  END

  IF ~~ THEN BEGIN MovingRightAlong SAY @1041
   COPY_TRANS BOTSMITH 4
  END

  IF WEIGHT #-1 ~Global("g3cupgrade","GLOBAL",1)~ THEN BEGIN ItemForged SAY #70888
    IF ~~ THEN DO ~SetGlobal("g3cupgrade","GLOBAL",0)~ EXIT
  END

END 

APPEND WSMITH01

  IF WEIGHT #-1 ~GlobalGT("g3cupgrade","MYAREA",0)~ THEN BEGIN cd_cromwell_upgrade_done SAY #59797
    IF ~~ THEN DO ~SetGlobal("g3cupgrade","MYAREA",0)~ EXIT
  END

  IF ~~ THEN BEGIN PartyHasAtLeastOneItem SAY @1073
    IF ~~ THEN GOTO PartyDoesNotHaveAllParts
    IF ~NumItemsPartyGT("misc43",1)~ THEN GOTO PartyHasAllParts
  END

  IF ~~ THEN BEGIN PartyDoesNotHaveAllParts SAY @1074
    IF ~~ THEN GOTO MovingRightAlong
  END

  IF ~~ THEN BEGIN PartyHasAllParts SAY @1075
    IF ~~ THEN REPLY @1077 GOTO HowMuch
    IF ~~ THEN REPLY @1078 GOTO MovingRightAlong
  END

  IF ~~ THEN BEGIN HowMuch SAY @1076
    IF ~PartyGoldGT(4999)~ THEN DO ~SetGlobal("g3cupgrade","MYAREA",1)
                                    TakePartyGold(5000)
                                    DestroyGold(5000)
                                    TakePartyItem("g3ceverg")
                                    DestroyItem("g3ceverg")
                                    TakePartyItemNum("misc43",2)
                                    DestroyItem("misc43")~ REPLY @1080 GOTO 56
    IF ~~ THEN REPLY @1078 GOTO MovingRightAlong
    IF ~~ THEN REPLY @1079 GOTO 12
  END

  IF ~~ THEN BEGIN MovingRightAlong SAY @1081
    COPY_TRANS WSMITH01 13
  END

END

EXTEND_BOTTOM WSMITH01 13

  IF ~PartyHasItem("g3ceverg")~ THEN GOTO PartyHasAtLeastOneItem

END


BEGIN g3cmerch

  IF ~NumTimesTalkedTo(0)~ THEN BEGIN InitialMeeting SAY @1049
   IF ~~ THEN REPLY @1050 GOTO Farewell
   IF ~Global("geniesgone","GLOBAL",0)~ THEN REPLY @1051 GOTO CantSeeStore
   IF ~!Global("geniesgone","GLOBAL",0)~ THEN REPLY @1051 GOTO OpenStore
  END  

  IF ~~ THEN BEGIN Farewell SAY @1052
    IF ~~ THEN EXIT
  END  

  IF ~~ THEN BEGIN CantSeeStore SAY @1053
    IF ~~ THEN EXIT
  END  

  IF ~~ THEN BEGIN OpenStore SAY @1054
    IF ~~ THEN DO ~StartStore("g3cmerch",LastTalkedToBy())~ EXIT
  END  

  IF ~!Dead("cefald01")~ THEN BEGIN GenericMeeting SAY @1055
   IF ~~ THEN REPLY @1050 GOTO Farewell
   IF ~Global("geniesgone","GLOBAL",0)~ THEN REPLY @1051 GOTO CantSeeStore
   IF ~!Global("geniesgone","GLOBAL",0)~ THEN REPLY @1051 GOTO OpenStore
  END  

  IF ~Dead("cefald01")~ THEN BEGIN HeroMeeting SAY @1056
   IF ~~ THEN REPLY @1057 GOTO Farewell
   IF ~Global("geniesgone","GLOBAL",0)~ THEN REPLY @1051 GOTO CantSeeStore
   IF ~!Global("geniesgone","GLOBAL",0)~ THEN REPLY @1051 GOTO OpenStore
  END  