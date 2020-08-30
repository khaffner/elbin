from sense_hat import SenseHat

sense = SenseHat()

while(True):
    # Enable only compass
    sense.set_imu_config(True,False,False)
    compass = sense.get_compass() # float

    # Enable only gyro
    sense.set_imu_config(False,True,False)
    gyro = sense.get_gyroscope()
    # pitch, roll, yaw. 
    # https://projects-static.raspberrypi.org/projects/generic-theory-pitch-roll-yaw/1da6c9e518533fe8c1f70d7445fd6880d7dac12a/en/images/orientation.png

    print("-----------------------------")
    print(compass)
    print("-----------------------------")
    print(gyro)

    time.Sleep(60)