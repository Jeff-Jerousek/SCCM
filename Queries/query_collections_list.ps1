#from: https://www.andersrodland.com/ultimate-sccm-querie-collection-list/

#COMPUTERS THAT HAVE 30 DAYS OLD HARDWARE INFORMATION.
@"
select SMS_R_SYSTEM.ResourceID, SMS_R_SYSTEM.ResourceType, SMS_R_SYSTEM.Name, SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup, SMS_R_SYSTEM.Client from SMS_R_System
inner join SMS_G_System_COMPUTER_SYSTEM on SMS_G_System_COMPUTER_SYSTEM.ResourceID = SMS_R_System.ResourceId
where SMS_G_System_COMPUTER_SYSTEM.Name  not in (select SMS_R_System.Name
from SMS_R_System inner join SMS_G_System_WORKSTATION_STATUS on SMS_G_System_WORKSTATION_STATUS.ResourceID = SMS_R_System.ResourceId
where SMS_G_System_WORKSTATION_STATUS.LastHardwareScan &gt;=  DateAdd(dd,-30,GetDate()))
"@


#COLLECTION OF CLIENTS NOT APPROVED.
@"
select SMS_R_SYSTEM.ResourceID, SMS_R_SYSTEM.ResourceType, SMS_R_SYSTEM.Name, SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup, SMS_R_SYSTEM.Client from SMS_R_System
inner join SMS_CM_RES_COLL_SMS00001 on SMS_CM_RES_COLL_SMS00001.ResourceId = SMS_R_System.ResourceId
where SMS_CM_RES_COLL_SMS00001.IsApproved= '2'
"@

#COLLECTION OF CLIENTS REQUIRING A REBOOT.
@"
select SMS_R_SYSTEM.ResourceID, SMS_R_SYSTEM.ResourceType, SMS_R_SYSTEM.Name, SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup, SMS_R_SYSTEM.Client from sms_r_system AS sms_r_system
inner join SMS_UpdateComplianceStatus as c on c.machineid=sms_r_system.resourceid
where c.LastEnforcementMessageID = 9
"@

# COLLECTION OF CONFIGMGR CLIENTS WAITING FOR ANOTHER INSTALLATION TO FINISH.
@"
select SMS_R_SYSTEM.ResourceID, SMS_R_SYSTEM.ResourceType, SMS_R_SYSTEM.Name, SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup, SMS_R_SYSTEM.Client from sms_r_system AS sms_r_system
inner join SMS_UpdateComplianceStatus as c on c.machineid=sms_r_system.resourceid where c.LastEnforcementMessageID = 3
"@

#ALL SCCM CLIENT COMPUTERS WITH LESS THAN 1GB FREE DISK SPACE ON C:

@"
select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,
SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,
SMS_R_SYSTEM.Client from SMS_R_System inner join SMS_G_System_LOGICAL_DISK on SMS_G_System_LOGICAL_DISK.ResourceID = SMS_R_System.ResourceId
where SMS_G_System_LOGICAL_DISK.DeviceID = “C:” and SMS_G_System_LOGICAL_DISK.FreeSpace &amp;lt;= 1000
"@


#ALL  COMPUTER OBJECTS WITH CLIENT INSTALLED IN THE SPECIFIC SITE “PS1”

@"
select SMS_R_SYSTEM.ResourceID, SMS_R_SYSTEM.ResourceType, SMS_R_SYSTEM.Name, SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup, SMS_R_SYSTEM.Client from SMS_R_System
where SMS_R_System.ADSiteName = 'PS1' AND client=1
"@


#ALL SCCM 2007 R3 CLIENTS
@"
select SMS_R_SYSTEM.ResourceID, SMS_R_SYSTEM.ResourceType, SMS_R_SYSTEM.Name, SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup, SMS_R_SYSTEM.Client from SMS_R_System
where SMS_R_System.ClientVersion like “4.00.6487.2187″ or SMS_R_System.ClientVersion  like “4.00.6487.2157″
"@


#COLLECTION WITH ALL COMPUTERS WITHOUT A CONFIGMGR CLIENT.
@"
select SMS_R_SYSTEM.ResourceID, SMS_R_SYSTEM.ResourceType, SMS_R_SYSTEM.Name, SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup, SMS_R_SYSTEM.Client
from SMS_R_System where SMS_R_System.Client is null
"@

#COLLECTION BASED ON OU.
@"
select * from  SMS_R_System where LOWER(SMS_R_System.SystemOUName) = "domain.local/OU/OU"
"@


#COLLECTION BASED ON DOMAIN MEMBERSHIP.
@"
select * from  SMS_R_System where SMS_R_System.ResourceDomainORWorkgroup = "domain"
"@


#COLLECTION FOR ALL WORKSTATIONS.
@"
select SMS_R_SYSTEM.ResourceID, SMS_R_SYSTEM.ResourceType, SMS_R_SYSTEM.Name, SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup, SMS_R_SYSTEM.Client
from SMS_R_System where SMS_R_System.OperatingSystemNameandVersion like "%workstation%"
"@

#COLLECTION OF ALL WINDOWS 10 CLIENTS.

@"
select SMS_R_SYSTEM.ResourceID, SMS_R_SYSTEM.ResourceType, SMS_R_SYSTEM.Name, SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup, SMS_R_SYSTEM.Client from SMS_R_System
where SMS_R_System.OperatingSystemNameandVersion like "%workstation 10.0%"
"@

#COLLECTION OF ALL WINDOWS 8.1 CLIENTS.

@"
select SMS_R_SYSTEM.ResourceID, SMS_R_SYSTEM.ResourceType, SMS_R_SYSTEM.Name, SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup, SMS_R_SYSTEM.Client from SMS_R_System
where SMS_R_System.OperatingSystemNameandVersion like "%workstation 6.3%"
"@

#COLLECTION OF ALL WINDOWS 8 CLIENTS.
@"
select SMS_R_SYSTEM.ResourceID, SMS_R_SYSTEM.ResourceType, SMS_R_SYSTEM.Name, SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup, SMS_R_SYSTEM.Client from SMS_R_System
where SMS_R_System.OperatingSystemNameandVersion like "%workstation 6.2%"
"@


#COLLECTION OF ALL WINDOWS 7 CLIENTS.
@"
select SMS_R_SYSTEM.ResourceID, SMS_R_SYSTEM.ResourceType, SMS_R_SYSTEM.Name, SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup, SMS_R_SYSTEM.Client from SMS_R_System
where SMS_R_System.OperatingSystemNameandVersion like "%workstation 6.1%"
"@

#COLLECTION OF ALL WINDOWS VISTA CLIENTS.
@"
select SMS_R_SYSTEM.ResourceID, SMS_R_SYSTEM.ResourceType, SMS_R_SYSTEM.Name, SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup, SMS_R_SYSTEM.Client from SMS_R_System
where SMS_R_System.OperatingSystemNameandVersion like "%workstation 6.0%"
"@


#COLLECTION OF ALL WINDOWS XP CLIENTS.
@"
select SMS_R_SYSTEM.ResourceID, SMS_R_SYSTEM.ResourceType, SMS_R_SYSTEM.Name, SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup, SMS_R_SYSTEM.Client from SMS_R_System
where SMS_R_System.OperatingSystemNameandVersion like "%workstation 5.1%"
"@

#COLLECTIONS BASED ON COMPUTER MANUFACTURER MODEL.
@"
select distinct SMS_G_System_COMPUTER_SYSTEM.Manufacturer, SMS_G_System_COMPUTER_SYSTEM.Model
from SMS_R_System inner join SMS_G_System_COMPUTER_SYSTEM on SMS_G_System_COMPUTER_SYSTEM.ResourceID = SMS_R_System.ResourceId
where SMS_G_System_COMPUTER_SYSTEM.Model = "Dell"
"@

#COLLECTION OF COMPUTERS ENDING WITH ODD NUMBERS
@"
select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,
SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup,
SMS_R_SYSTEM.Client from SMS_R_System
where SMS_R_System.Name like "%1"
or SMS_R_System.Name like "%3"
or SMS_R_System.Name like "%5"
or SMS_R_System.Name like "%7"
or SMS_R_System.Name like "%9"
"@

#COLLECTION OF COMPUTERS ENDING WITH EVEN NUMBERS

@"
select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,
SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup,
SMS_R_SYSTEM.Client from SMS_R_System
where SMS_R_System.Name like "%0"
or SMS_R_System.Name like "%2"
or SMS_R_System.Name like "%4"
or SMS_R_System.Name like "%6"
or SMS_R_System.Name like "%8"
"@

#COLLECTION OF COMPUTERS WITH FAILING HARD DRIVE
@"
select SMS_R_SYSTEM.ResourceID, SMS_R_SYSTEM.ResourceType,
SMS_R_SYSTEM.Name, SMS_R_SYSTEM.SMSUniqueIdentifier,
SMS_R_SYSTEM.ResourceDomainORWorkgroup, SMS_R_SYSTEM.Client
from SMS_R_System
inner join SMS_G_System_DISK on SMS_G_System_DISK.ResourceId = SMS_R_System.ResourceId
where SMS_G_System_DISK.Status = "Pred Fail" order by SMS_R_System.Name DESC
"@

