# https://www.waveshare.com/wiki/Current/Power_Monitor_HAT#Resouces

from flask import Flask
import board
from adafruit_ina219 import ADCResolution, BusVoltageRange, INA219

app = Flask(__name__)

# Fix enum later, route must for now be 0x40, 0x41, 0x42 or ox43
@app.route("/<battery>")
def get_voltage(battery):

    i2c_bus = board.I2C()

    ina = INA219(i2c_bus, addr=battery)

    ina.bus_adc_resolution = ADCResolution.ADCRES_12BIT_32S
    ina.shunt_adc_resolution = ADCResolution.ADCRES_12BIT_32S
    ina.bus_voltage_range = BusVoltageRange.RANGE_16V

    shunt_voltage = ina.shunt_voltage

    return shunt_voltage

if __name__ == "__main__":
    app.run()
