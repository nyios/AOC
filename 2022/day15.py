def doStuff(filename):
    f = open(filename, "r");
    sensors = []
    beacons = []
    for line in f:
        line = line.removeprefix('Sensor at x=')
        [sensor, beacon] = line.split(':')
        beacon = beacon.removeprefix(' closest beacon is at x=')
        sensors.append((int(sensor.split(',')[0]),
            int(sensor.split(',')[1].removeprefix(' y='))))
        beacons.append((int(beacon.split(',')[0]),
            int(beacon.split(',')[1].removeprefix(' y='))))
    min_x = min(min(list(map(lambda x : x[0], sensors))), 
            min(list(map(lambda x : x[0], beacons))))
    return min_x

if __name__ == "__main__":
    print(doStuff('input.txt'))        
