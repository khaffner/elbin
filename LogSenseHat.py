from sense_hat import SenseHat
import time
import json
import datetime

sense = SenseHat()

while(True):
    compass = sense.get_compass() # float
    orientation = sense.get_orientation()
    
    pitch = "{pitch}".format(**orientation) # float
    roll = "{roll}".format(**orientation) # float
    yaw = "{yaw}".format(**orientation) # float
    # https://projects-static.raspberrypi.org/projects/generic-theory-pitch-roll-yaw/1da6c9e518533fe8c1f70d7445fd6880d7dac12a/en/images/orientation.png

    x = {
        "timestamp": datetime.datetime.now().isoformat(),
        "compass": compass,
        "pitch": pitch,
        "roll": roll,
        "yaw": yaw
    }
    jsonString = json.dumps(x)

    outF = open("/logs/sensehat.log", "a")
    outF.write(jsonString)
    outF.write("\n")
    outF.close()

    time.sleep(1)