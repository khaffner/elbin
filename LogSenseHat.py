from sense_hat import SenseHat
import time

sense = SenseHat()

while(True):
    orientation = sense.get_orientation()
    # https://projects-static.raspberrypi.org/projects/generic-theory-pitch-roll-yaw/1da6c9e518533fe8c1f70d7445fd6880d7dac12a/en/images/orientation.png

    outF = open("/logs/sensehat.log", "a")
    outF.write(orientation)
    outF.write("\n")
    outF.close()

    time.sleep(1)