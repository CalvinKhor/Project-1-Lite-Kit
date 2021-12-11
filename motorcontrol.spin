{
  Project: EE-7 Practical 1
  Platform: Parallel Project USB Board
  Revision: 1.1
  Author: Calvin Khor
  Date: 3 Nov 2021
  Log:
        Date: Desc
        25/10/2021: Motor Implementation
        22/11/2021: Remove motor logic
        1/12/2021: Remove pauses for final testings
  }



CON



      'pin declaration
      motor1 = 10
      motor2 = 11
      motor3 = 12
      motor4 = 13

      motor1Zero = 1520
      motor2Zero = 1520
      motor3Zero = 1520
      motor4Zero = 1520



VAR ' Global variable
long _ms_001



OBJ  ' Objects
  Motors  : "Servo8Fast_vZ2.spin"
  'Term    : "FullDuplexSerial.spin"

PUB Start(msval, rxvalue, mainToF1Add, mainToF2Add, mainUltra1Add, mainUltra2Add) | ultraval1, tofval1,tofval2, ultraval2'Core 0
 'Term.Start(31, 30 ,0, 115200)
  _ms_001 := msval
     Motors.Init
   Motors.AddSlowPin(motor1)
   Motors.AddSlowPin(motor2)
   Motors.AddSlowPin(motor3)
   Motors.AddSlowPin(motor4)
   Motors.Start
   StopAllMotors


  repeat
      tofval1 := long[maintof1add]                            ' assigning deref value to a local var
      tofval2 := long[maintof2add]
      ultraval1 := long[mainultra1add]
      ultraval2 := long[mainultra2add]

     case long [rxvalue]

        $01:
          '

          if(ultraval1 <300 or tofval1 > 200 )          'Condition to check if sensors values = true , stops all motors
                   stopallmotors
          forward(100)

        $02:

            reverse(100)
              if(ultraval2 <300 or tofval2 >200)
                    stopallmotors
                                                              'reverse


        $03:                                        'turn right
            TurnLeft(100)
            if(ultraval1 < 200 or tofval1 >200)           ' Condition to check if sensors values = true , stops all motors
                     stopallmotors

        $04:
           TurnRight(100)                            'turn left
           if(ultraval1 < 200 or tofval1 >200)             ' Condition to check if sensors values = true , stops all motors
              stopallmotors
        $AA:
           StopAllMotors                     'stop all motors



return


PUB StopAllMotors
        Motors.Set(motor1,1400)                'set motor to turn clockwise/anticlockwise
        Motors.Set(motor2,1300)
        Motors.Set(motor3,1600)
        Motors.Set(motor4,1600)

        pause(500)

PUB Forward(i)
        Motors.Set(motor1,motor1Zero-250)
        Motors.Set(motor2,motor2Zero-350)
        Motors.Set(motor3,motor3Zero+300)
        Motors.Set(motor4,motor4Zero+300)
        pause(500)
PUB TurnRight(i)
        Motors.Set(motor1,motor1Zero-300)
        Motors.Set(motor3,motor3Zero-100)
        Motors.Set(motor2,motor2Zero-100)
        Motors.Set(motor4,motor4Zero+250)
        pause(500)
PUB TurnLeft(i)

        Motors.Set(motor1,motor1Zero+i)
        Motors.Set(motor3,motor3Zero+200)
        Motors.Set(motor2,motor2Zero-400)
        Motors.Set(motor4,motor4Zero-200)
        pause(500)

PUB Reverse(i)

        Motors.Set(motor1,motor1Zero+50)
        Motors.Set(motor2,motor2Zero)
        Motors.Set(motor3,motor3Zero-100)
        Motors.Set(motor4,motor4Zero-100)
        pause(500)

PRI Pause(ms) | t
t := cnt - 1088
  repeat (ms #> 0)
    waitcnt(t += _MS_001)
  return