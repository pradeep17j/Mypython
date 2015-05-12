get-vm |where {$_.Name -match "s\dn"} | stop-vm
