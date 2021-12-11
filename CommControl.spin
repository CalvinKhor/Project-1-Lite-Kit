{Platform Parallax Project USB Board
Revision 1.0
Author: Calvin Khor Zhen Loong
Date: 17 Nov 2021
Log:
  Date 21 Nov 2021
  17/11/2021: Creating an object file
}


CON

        commRxPin = 20
        commTxPin = 21
        commBaud  = 9600

        commStart   = $7A
        commForward = $01
        commReverse = $02
        commLeft    = $03
        commRight   = $04
        commStopAll = $AA


VAR
  long CogIDNum, CogStack[64]  ' cogID and space for cog
  long _Ms_001

OBJ
  Comm    : "FullDuplexSerial.spin"

PUB Start(mainMSVal, rxValue)

    _Ms_001 := mainMSVal              'Read the value of a pause

    StopCore

    cogIDNum := cognew(comms(rxvalue),@cogStack)
return
PUB comms(rxvalue) | value

  'Declaration & Initialisation
  Comm.Start(commTxPin, commRxPin, 0, commBaud)
  Pause(3000)                                   'wait 3 sec
  'Run & get readings
  repeat
    value := Comm.Rx                    ' store comm.rx to a local variable so that 7A wont be passed back to mylitekit                     '  prints the decimal value of comm.rx , in this case 7A
    if (value == commStart)                   'if 7A is true, initiate commstart
      long[rxValue]:= Comm.Rx                  'assign comm.rx, dereference rxvalue(to get the value not the address)
      case long[rxValue]
        commForward:                  'Read the value '1'  and store to value
          'comm.Str(String(13, "Forward"))
          pause(100)

        commReverse:
                    'Read the value '2'  and store to value
          'comm.Str(String(13, "Reverse"))
          pause(100)

        commLeft:
                 'Read the value '3'  and store to value
          'comm.Str(String(13, "TurnRight"))
          pause(100)

        commRight:
                    'Read the value '4'  and store to value
          'comm.Str(String(13, "TurnLeft"))
          pause(100)

        commStopAll:
                    'Read the value '5'  and store to value
          'comm.Str(String(13, "StopAllMotors"))
          pause(100)
    pause(1000)


PUB StopCore  ' Stop the code in the core/cog and release the core/cog
   if cogIDNum
    COGSTOP(cogIDNum~)
PRI Pause(ms) | t
  t := cnt - 1088
  repeat (ms #> 0)
    waitcnt(t += _MS_001)
  return

DAT
name    byte  "string_data",0