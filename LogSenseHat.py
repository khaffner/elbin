from sense_hat import SenseHat
import time
import json

sense = SenseHat()

while(True):
    orientation = sense.get_orientation()
    # https://projects-static.raspberrypi.org/projects/generic-theory-pitch-roll-yaw/1da6c9e518533fe8c1f70d7445fd6880d7dac12a/en/images/orientation.png

    orientationString = json.dumps(orientation)

    print(orientationString)

    outF = open("/logs/sensehat.log", "a")
    outF.write(orientationString)
    outF.write("\n")
    outF.close()

    time.sleep(1)