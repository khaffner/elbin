# https://www.waveshare.com/wiki/Current/Power_Monitor_HAT#Resouces

from flask import Flask
import board
from adafruit_ina219 import ADCResolution, BusVoltageRange, INA219

app = Flask(__name__)

@app.route("/<battery>")
def get_voltage(battery):

    # Convert 1 to 0x40, 2 to 0x41, etc
    addr = "0x" + str(39+int(battery)) 
    print("Reading voltage on address {}".format(addr))

    i2c_bus = board.I2C()

    ina = INA219(i2c_bus, addr=addr)

    ina.bus_adc_resolution = ADCResolution.ADCRES_12BIT_32S
    ina.shunt_adc_resolution = ADCResolution.ADCRES_12BIT_32S
    ina.bus_voltage_range = BusVoltageRange.RANGE_16V

    voltage = ina.bus_voltage

    return voltage

if __name__ == "__main__":
    app.run(host='0.0.0.0')
