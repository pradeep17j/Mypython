$i=0

$deviceName = (Get-VMHost | Get-ScsiLun )

$done=0;

while($i -lt 50)
{
    
    $dt = ($deviceName | where {$_.CapacityMB -match "921600"  })[$i].ConsoleDeviceName
    if($dt)
    {
       Write-Host $dt

  #     New-HardDisk -VM VirtualGC1_FC -DiskType RawPhysical -DeviceName $dt -Datastore MapStore
  #     New-HardDisk -VM VirtualGC_FC -DiskType RawPhysical -DeviceName $dt 
       New-HardDisk -VM VirtualDVA1 -DiskType RawPhysical -DeviceName $dt 
	$done++;
       if($done -eq 49)
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

 #    New-HardDisk -VM VirtualGC1_FC -DiskType RawPhysical -DeviceName $dt -Datastore MapStore
     New-HardDisk -VM VirtualGC1_FC -DiskType RawPhysical -DeviceName $dt 

	$done++;
       if($done -eq 25)
	{
		break;
	}

    }
 $i++;




}


