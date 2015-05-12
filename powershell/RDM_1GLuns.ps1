$i=0

$deviceName = (Get-VMHost | Get-ScsiLun )

$done=0;

while($i -lt 50)
{
    
    $dt = ($deviceName | where {$_.CapacityMB -match "1419"  })[$i].ConsoleDeviceName
    if($dt)
    {
       Write-Host $dt

#	New-HardDisk -VM VirtualGC_FC -DiskType RawPhysical -DeviceName $dt -Datastore MapStore
#	sleep 2;
	New-HardDisk -VM VirtualGC_FC -DiskType RawPhysical -DeviceName $dt 
	$done++;
	if($done -eq 50)
	{
		break;
	}
    }
    $i++;

}
exit;

$i=0;


$done=0;

while($i -lt 70)
{

$dt = ($deviceName | where {$_.CapacityMB -match "1506"})[$i].ConsoleDeviceName


    if($dt)
    {

     Write-Host $dt

 #    New-HardDisk -VM VirtualGC_FC -DiskType RawPhysical -DeviceName $dt -Datastore MapStore
     New-HardDisk -VM VirtualGC_FC -DiskType RawPhysical -DeviceName $dt 

	$done++;
       if($done -eq 25)
	{
		break;
	}

    }
 $i++;




}


