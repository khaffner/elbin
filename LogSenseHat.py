from sense_hat import SenseHat
import json

sense = SenseHat()

# https://projects-static.raspberrypi.org/projects/generic-theory-pitch-roll-yaw/1da6c9e518533fe8c1f70d7445fd6880d7dac12a/en/images/orientation.png
orientation = sense.get_orientation()
orientationString = json.dumps(orientation)
print(orientationString)
