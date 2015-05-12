#Get-HardDisk -VM VirtualGC_FC | where {$_.Filename -match "000eb64390a"} | Remove-HardDisk -Confirm -DeletePermanently
Get-HardDisk -VM VirtualGC_FC | where {$_.Filename -notmatch "FC_1.vmdk"} | Remove-HardDisk -Confirm -DeletePermanently

