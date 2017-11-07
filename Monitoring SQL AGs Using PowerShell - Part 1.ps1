<#
Author: Jared Karney

Original Date: 2017/10/25

Revisions:

Comments:
This script was written based upon 
https://blogs.msdn.microsoft.com/sqlalwayson/2012/02/13/monitoring-alwayson-health-with-powershell-part-1-basic-cmdlet-overview/
and 
https://blogs.msdn.microsoft.com/sqlalwayson/2012/02/13/monitoring-alwayson-health-with-powershell-part-2-advanced-cmdlet-usage/
This is written to introduce both PowerShell and monitoring of SQL Availability Groups

This Sample Code is provided for the purpose of illustration only and is not intended to be used in a production environment.  
THIS SAMPLE CODE AND ANY RELATED INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.  
We grant You a nonexclusive, royalty-free right to use and modify the 
Sample Code and to reproduce and distribute the object code form of the Sample Code, provided that You agree: (i) to not use Our name, logo, or trademarks to market Your software product in which the Sample Code is embedded; 
(ii) to include a valid copyright notice on Your software product in which the Sample Code is 
embedded; and 
(iii) to indemnify, hold harmless, and defend Us and Our suppliers from and against any claims or lawsuits, including attorneys’ fees, that arise or result from the use or distribution of the Sample Code.
Please note: None of the conditions outlined in the disclaimer above will supercede the terms and conditions contained within the Premier Customer Services Description.
#>

# update help
Update-Help

# install SqlServer module
Install-Module SqlServer -Force -AllowClobber

# import sqlserver module
Import-Module SqlServer

# get to the sqlserver drive path for AvailabilityGroups
cd sqlserver:\sql\localhost\DEFAULT\AvailabilityGroups

# test the health of the AG (Error, Warning, Unknown, PolicyExecutionFailure, Healthy)
dir | Test-SqlAvailabilityGroup

<#
Error - The object is in a critical state, high availability has been compromised. 
Warning - The object is in a warning state, high availability may be at risk.
Unknown - The health of the object cannot be determined. This can occur if you execute these cmdlets on a secondary replica.
PolicyExecutionFailure - An exception was thrown while evaluating a policy against this object. This can indicate an error in the implementation of the policy.
Healthy - The object is in a healthy state.
#>


# get to the replica directory
cd AlwaysOnAG
dir
cd AvailabilityReplicas
dir

# test the health of the replicas
dir | Test-SQLAvailabilityReplica

# get to the replica states directory
cd ..
dir
cd DatabaseReplicaStates
dir

# test the replica states
dir | Test-SqlDatabaseReplicaState

# use the path of the AG and retest the AvailabilityGroup with some details
$result = Test-SqlAvailabilityGroup -Path "SQLSERVER:\sql\localhost\DEFAULT\AvailabilityGroups\AlwaysOnAG"

$result.PolicyEvaluationDetails | ft Result,Name -AutoSize

# same thing done a different way
Test-SqlAvailabilityGroup -Path "SQLSERVER:\sql\localhost\DEFAULT\AvailabilityGroups\AlwaysOnAG" `
    -ShowPolicyDetails | ft Result,Name -AutoSize
    

