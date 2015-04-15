import time
import sys
sys.path.append("/u/ppradeepkumar/MyPython/Python-2.7.6/")
import pexpect
import re
import json


loadgen_cmd='/var/loadgen_edge.dbg -f '
loadgen_cfg=" /var/cfg/loadgen-{:d}.xml "
loadgen_args=" --test-duration 1500 --read-op --lba-cnt 19531250 --burst-rate 65536 --num-ops 2,100 > "
loadgen_logs=" logx/{:d}.txt 2>&1 &"


class file_op():
    handle=None
    def __init__(self):
        self.handle= open('stats_collect.64k','w')
    def write_data(self,data):
        for d in data:
            self.handle.write("%s\n" % d)

class metrics():
    data=None  
    def conv_bytes_to_kb(self):
        return self.data/1000
    def conv_mb_to_kb(self):
        return self.data*1000
    def conv_gb_to_kb(self):
        return self.data*1000000


class stats_proc(file_op):
    rx1= re.compile('Total (data|bytes) read\s*:\s*(\S+)\s*(\S+)',re.IGNORECASE)
    rx3= re.compile('Avg Read IO Time\s*:\s*(\S+)\s*(\S+)',re.IGNORECASE)
    delay=150
    def read_stat(self,data): 
        for i in data:
            rx2= self.rx1.search(i)
            if rx2:
                m= metrics()
                m.data= float(rx2.group(2))
                if re.search(rx2.group(3),'MB',re.IGNORECASE):
                    return m.conv_mb_to_kb()/self.delay
                if re.search(rx2.group(3),'GB',re.IGNORECASE):
                    return m.conv_gb_to_kb()/self.delay
                if re.search(rx2.group(3),'Bytes',re.IGNORECASE):
                    return m.conv_bytes_to_kb()/self.delay
    def read_latency(self,data):
        for i in data:
            rx4= self.rx3.search(i)
            if rx4:
               return rx4.group(1)+" "+ rx4.group(2) 
 



class va_box_prompt(object):
    COMMAND_PROMPT=None
    CLI_PROMPT=None
    CLI_PROMPT1=None
    def __init__(self):
        self.COMMAND_PROMPT= re.compile('\[admin\@\S+ \S+\]#')
        self.CLI_PROMPT= re.compile('\S+\s*(>|#|\(config\)\s*#)')
        self.CLI_PROMPT1= re.compile('\S+\s*\(config\)\s*#')
        self.password= re.compile('password')

class va_box(va_box_prompt):
    hostname=None
    shell=None
    cli=None
    user='root'
    def get_login(self):
        login(self)
        login(self,access='cli')
    def exec_on_shell(self,cmd):
        return exec_this_shell_cmd(self,cmd)
    def exec_on_cli(self,cmd):
        return exec_this_cli_cmd(self,cmd)

class win_box():
    hostname=None
    shell=None
    user='Administrator'
    COMMAND_PROMPT= re.compile('Administrator\@\S+\s+\S+')
    password= re.compile('Administrator\@\S+\s+password')
    def get_login(self):
        login(self)
    def start_dd(self):
        cmd= 'dd if=\'\\\\.\\PhysicalDrive3\' of=/dev/null bs=64k count=10000 &'
        return exec_this_shell_cmd(self,cmd)



class loadgen_box(va_box):
    instance=1
    def get_login(self):
        super(loadgen_box,self).get_login()
        super(loadgen_box,self).exec_on_shell('cd /var')

    def kill_loadgen(self):
        super(loadgen_box,self).exec_on_shell('pkill loadgen')

    def start_loadgen_cmd(self,count):
        cfg= loadgen_cfg.format(count)
        log= loadgen_logs.format(count)
        self.exec_on_shell(loadgen_cmd+cfg+loadgen_args+log)

stor_stats= 'show stats storage '
stor_stats1= '{:s} start-time \'{:s}\' end-time \'{:s}\' {:s} '

class stats_collect():
    start_time=None
    end_time=None
    def form_time(self):
        self.start_time= self.start_time.replace('-','/')
        self.end_time= self.end_time.replace('-','/')
    def form_stats_cmd(self,appnd):
        return stor_stats + stor_stats1.format(appnd[0],self.start_time,self.end_time,appnd[1])


cmd= 'ssh'
params= ''' -oStrictHostKeyChecking=no
    -oCheckHostIP=no -oForwardX11=no
    -oUserKnownHostsFile=/dev/null
    -oConnectTimeout=10 -oServerAliveInterval=300
    -oForwardAgent=no '''

#systems=[ probe, loadgen, tarpon ]

def login(self,access='shell'):
    hostname= self.hostname
    user= self.user + '\@'
    cmd1 = cmd + params + user + hostname
    child= pexpect.spawn(cmd1)    
    child.logfile = sys.stdout
    index= child.expect([self.password,self.COMMAND_PROMPT,pexpect.EOF])
#   import pdb; pdb.set_trace()
    if index==0:
        child.sendline( '2top90!')
        child.expect(self.COMMAND_PROMPT)
        self.shell= child
    elif index!=1:
        print "Not able to login"
        sys.exit(0)

    if access is 'shell':
        self.shell= child
    elif access is 'cli':
        child.sendline('cli')
        child.expect('>')
        child.sendline('terminal length 0')
        child.expect(self.CLI_PROMPT)
        child.sendline('en')
        child.expect(self.CLI_PROMPT)
        child.sendline('con t')
        child.expect(self.CLI_PROMPT1)
        self.cli= child

def get_output_only(output):
    out= output.split('\n')
    #Except the first and last line, consider all other lines as ouput
    # Take out first line
    out.pop(0)
    #take out last line
    out.pop()
    out1= map(str.strip,out)
    return out1

def exec_this_cli_cmd(self,cmd,get_input=False):
    if get_input:
        cmd=raw_input("Enter the command to execute:")
    self.cli.sendline(cmd)
    self.cli.expect(self.CLI_PROMPT1,timeout=160)
    output= self.cli.before
    output1= get_output_only(output)
    return output1

def exec_this_shell_cmd(self,cmd,get_input=False):
    if get_input:
        cmd=raw_input("Enter the command to execute:")
    self.shell.sendline(cmd)
    self.shell.expect(self.COMMAND_PROMPT,timeout=160)
    output= self.shell.before
    output1= get_output_only(output)
    return output1


#import pdb; pdb.set_trace()

#Probe edge
probe= va_box()
probe.hostname='oak-sh610'
probe.get_login()

# Edge on which loadgen runs
loadgen= loadgen_box()
loadgen.hostname='oak-sh584'
loadgen.get_login()

# Tarpon core
tarpon= va_box()
tarpon.hostname='oak-sh809'
tarpon.get_login()

#import pdb; pdb.set_trace()
# Windows
win= win_box()
win.hostname='oak-cs226'
win.get_login()

f= file_op()
s= stats_proc()


def show_systems():
    for i in handles.keys():
        print i

def start_loadgen():
    count=0
    end= 10 * loadgen.instance;
    print " Starting {:d} loadgen instances ..".format(end)
    f.write_data([" Starting {:d} loadgen instances ..".format(end)])
    for i in range(1,end):
        loadgen.start_loadgen_cmd(i)
#       time.sleep(1)
    loadgen.instance+=1

def connected_edges():
    tmp= tarpon.exec_on_cli("show edge")
    rx= re.compile('connection duration\s*:\s*(\S+)',re.IGNORECASE)
    count=0
#   import pdb; pdb.set_trace()
    for i in tmp:
        rx2= rx.search(i)
        if rx2:
            print rx2.group(1)
            if rx2.group(1) != '0s':
                count+=1
    print '... {:d} connected edges ...'.format(count)


        
def clear_restart_edge():
    probe.exec_on_cli("service storage restart clean")

def restart_core():
    tarpon.exec_on_cli("service restart ")

def get_stats():
    date_cmd= 'date +\'%F %T\''
    core1= stats_collect()
    edge1= stats_collect()

    core_start_time= tarpon.exec_on_shell(date_cmd)
    core1.start_time= core_start_time[0]

    edge_start_time= probe.exec_on_shell(date_cmd)
    edge1.start_time= edge_start_time[0]

    time.sleep(s.delay)

    core_end_time= tarpon.exec_on_shell(date_cmd)
    core1.end_time= core_end_time[0]

    edge_end_time= probe.exec_on_shell(date_cmd)
    edge1.end_time= edge_end_time[0]

    core1.form_time()
    edge1.form_time()

    tup=()
    tup=('filer-bytes','filer all')
    tarpon_stats= tarpon.exec_on_cli(core1.form_stats_cmd(tup))
    ret= str(s.read_stat(tarpon_stats))+' KB' 
    f.write_data([ret])

#   import pdb; pdb.set_trace()
    tup=()
    tup=('filer-latency','filer all')
    tarpon_stats= tarpon.exec_on_cli(core1.form_stats_cmd(tup))
    ret= s.read_latency(tarpon_stats)
    f.write_data([ret])

    tup=()
    tup=('lun-bytes','lun all')
    probe_stats= probe.exec_on_cli(edge1.form_stats_cmd(tup))
    ret= str(s.read_stat(probe_stats))+' KB' 
    f.write_data([ret])

    tup=()
    tup=('lun-latency','lun all')
    probe_stats= probe.exec_on_cli(edge1.form_stats_cmd(tup))
    ret= s.read_latency(probe_stats)
    f.write_data([ret])
#   import pdb; pdb.set_trace()
    sep= "-"*20
    f.write_data([sep])

iter=15
while iter>0:
    clear_restart_edge()
    restart_core()
    time.sleep(100)
    win.start_dd()
    start_loadgen()
    time.sleep(3)
    get_stats()
    iter-=1





while 1:
    print "\n\nselect options below\n"
    print "\t\t10. Start 10 Loadgen instances\n"
    print "\t\t20. Exit\n"
    print "\t\t30. Collect stats\n"
    print "\t\t31. Clean restart probe edge\n"
    print "\t\t32. restart core\n"
    print "\t\t33. kill loadgens\n"
    print "\t\t34. show connected edges\n"
    print "\t\t35. win start dd\n"
#   import pdb; pdb.set_trace()
    in1=raw_input("Enter here:")
    print in1

    if in1 == '':
        continue

    options = {
            '10':start_loadgen,
            '20':sys.exit,
            '30':get_stats,
            '31':clear_restart_edge,
            '32':restart_core,
            '33':loadgen.kill_loadgen,
            '34':connected_edges,
            '35':win.start_dd,
            }

    options[in1]()
