{  Project: EE-7 Lite Kit
  Platform: Parallel Project USB Board
  Revision: 1.3
  Author: Calvin Khor
  Date: 26 Nov 2021
  Log:
        Date: Desc
        15/11/2021: Motor & Sensor obj call
        22/11/2021: Comm obj implementation
        24/11/2021: Motor obj implementation
        26/11/2021: Sensor obj implementation
        }


CON
        _clkmode = xtal1 + pll16x                                               'Standard clock mode * crystal frequency = 80 MHz
        _xinfreq = 5_000_000
        _ConClkFreq = ((_clkmode - xtal1) >> 6) * _xinfreq
        _Ms_001 = _ConClkFreq / 1_000

        ' Comm check signals.
        commStart =   $7A
        commForward = $01
        commReverse = $02
        commLeft =    $03
        commRight =   $04
        commStopAll = $AA


VAR           long mainToF1Add, mainToF2Add, mainUltra1Add, mainUltra2Add
              long RxValue

OBJ
  'Term    : "FullDuplexSerial.spin"
  Motors  : "motorcontrol.spin"                            '4
  Sensors : "SensorControl.spin"
  Comms    : "CommControl.spin"


PUB Main
    ' Declaration & Initilisation
    'Term.Start(31, 30 ,0, 115200)
    'Pause(2000)
    Sensors.Start(_Ms_001, @mainToF1Add, @mainToF2Add, @mainUltra1Add, @mainUltra2Add)
    Comms.Start(_Ms_001, @rxvalue)
    Motors.Start(_Ms_001, @rxvalue, @mainToF1Add, @mainToF2Add, @mainUltra1Add, @mainUltra2Add)

   ' repeat



PRI Pause(ms) | t

  t := cnt - 1088   ' sync with system counter
  repeat (ms #> 0)  ' delay must be >0
    waitcnt(t += _Ms_001)
  return

DAT
name    byte  "string_data",0