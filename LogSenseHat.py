from sense_hat import SenseHat
import time
import json
import datetime

sense = SenseHat()

while(True):
    # Enable only compass
    sense.set_imu_config(True,False,False)
    compass = sense.get_compass() # float

    # Enable only gyro
    sense.set_imu_config(False,True,False)
    gyro = sense.get_gyroscope()
    pitch = "{pitch}".format(**gyro) # float
    roll = "{roll}".format(**gyro) # float
    yaw = "{yaw}".format(**gyro) # float
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

    time.sleep(60)