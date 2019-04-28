import subprocess

dask_conf_path = "/utils/dask.conf"
with open(dask_conf_path, "r") as file:
    dask_conf = file.read()

_dask_conf = dask_conf.split("\n")
dask_conf = list()
for i, line in enumerate(_dask_conf):
    line = line.split()
    if 0 < len(line):
        dask_conf.append(line)

cmd = "bash /utils/dask-setup.sh 0"

print(cmd)

process = subprocess.Popen(cmd.split(), stdout=subprocess.PIPE)
output, error = process.communicate()

cmd = "hostname --all-ip-addresses"
process = subprocess.Popen(cmd.split(), stdout=subprocess.PIPE)
output, error = process.communicate()
IPADDR = str(output.decode()).split()[0]

NWORKERS_PER_NODE = None
DASK_SCHED_PORT = None
DASK_SCHED_BOKEH_PORT = None
DASK_WORKER_BOKEH_PORT = None
MASTER_IPADDR = None
WHOAMI = None

for line in dask_conf:
    if line[0] == "NWORKERS_PER_NODE":
        NWORKERS_PER_NODE = line[1]
    if line[0] == "DASK_SCHED_PORT":
        DASK_SCHED_PORT = line[1]
    if line[0] == "DASK_SCHED_BOKEH_PORT":
        DASK_SCHED_BOKEH_PORT = line[1]
    if line[0] == "DASK_WORKER_BOKEH_PORT":
        DASK_WORKER_BOKEH_PORT = line[1]
    if line[1] == "MASTER":
        MASTER_IPADDR = line[0]
    if line[0] == IPADDR:
        WHOAMI = line[1]

cmd = "bash /utils/dask-setup.sh " + str(NWORKERS_PER_NODE)
cmd = cmd + " " + str(DASK_SCHED_PORT)
cmd = cmd + " " + str(DASK_SCHED_BOKEH_PORT)
cmd = cmd + " " + str(DASK_WORKER_BOKEH_PORT)
cmd = cmd + " " + str(MASTER_IPADDR)
cmd = cmd + " " + str(WHOAMI)

print(cmd)

process = subprocess.Popen(cmd.split(), stdout=subprocess.PIPE)
output, error = process.communicate()

cmd = "screen -list"

process = subprocess.Popen(cmd.split(), stdout=subprocess.PIPE)
output, error = process.communicate()
print(output.decode())
