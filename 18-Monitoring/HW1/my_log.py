import subprocess
import json
import struct
from datetime import datetime

def getData(command): 
    try:
        result = subprocess.check_output(command, shell = True, executable = "/bin/bash", stderr = subprocess.STDOUT)
    
    except subprocess.CalledProcessError as cpe:
        result = cpe.output

    finally:
        return result

def getLoadAVG():
    command = "cat /proc/loadavg"
    result = getData(command)
    
    x = result.split()
    data = {
        "loadavg1" : x[0].decode("utf-8"),
        "loadavg5" : x[1].decode("utf-8"),
        "loadavg5" : x[2].decode("utf-8"),
        "processes" : x[3].decode("utf-8"),
        "last PID" : x[4].decode("utf-8")
    }
    json_data = json.dumps(data)
    return data

def getMeminfo():
    command = "cat /proc/meminfo"
    result = getData(command)
    data = {}
    for line in result.splitlines():
        x = line.decode("utf-8").split(":")
        data[x[0]] = x[1].lstrip()
    return data
    
def saveLogToFile(log):
    
    day = datetime.now().strftime('%d') 
    month = datetime.now().strftime('%m')
    year = datetime.now().strftime('%y')
    
    line = json.dumps(log)
    file = f'/var/log/{year}-{month}-{day}-awesome-monitoring.log'
    with open(f'{file}', 'a', encoding='utf-8') as f:
        f.write(f'{line}\n')
    
loadavg_data = getLoadAVG()
meminfo_data = getMeminfo()
timestamp = int(round(datetime.now().timestamp()))

log = {
    "timestamp" : timestamp,
    "loadavg" : loadavg_data,
    "meminfo" : meminfo_data
}

saveLogToFile(log)