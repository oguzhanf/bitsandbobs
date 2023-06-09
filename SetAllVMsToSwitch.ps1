<#
.SYNOPSIS
This script sets the network adapter of all VMs on a Windows Hyper-V installation to a specified virtual switch.

.PARAMETER SwitchName
The name of the virtual switch to which all VM network adapters will be connected.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true, HelpMessage="You must provide the name of the virtual switch.")]
    [string]$SwitchName
)

$vms = Get-VM

foreach ($vm in $vms) {
    $networkAdapters = Get-VMNetworkAdapter -VMName $vm.Name
    foreach ($networkAdapter in $networkAdapters) {
        Connect-VMNetworkAdapter -VMName $vm.Name -Name $networkAdapter.Name -SwitchName $SwitchName
    }
}
