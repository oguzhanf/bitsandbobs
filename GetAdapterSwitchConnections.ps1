<#
.SYNOPSIS
This script retrieves all VMs on a Windows Hyper-V installation, identifies their network adapters, and creates a table displaying the VM name, adapter name, and the name of the virtual switch the adapter is connected to.
#>

$vms = Get-VM
$results = @()

foreach ($vm in $vms) {
    $networkAdapters = Get-VMNetworkAdapter -VMName $vm.Name
    foreach ($networkAdapter in $networkAdapters) {
        $obj = New-Object -TypeName PSObject
        $obj | Add-Member -MemberType NoteProperty -Name "VM Name" -Value $vm.Name
        $obj | Add-Member -MemberType NoteProperty -Name "Adapter Name" -Value $networkAdapter.Name
        $obj | Add-Member -MemberType NoteProperty -Name "Switch Name" -Value $networkAdapter.SwitchName
        $results += $obj
    }
}

$results | Format-Table
