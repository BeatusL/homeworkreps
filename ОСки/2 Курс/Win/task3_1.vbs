dim fso, reader, i, j, v, rows, cols, line
Set fso = CreateObject("Scripting.FileSystemObject")
Set reader = fso.OpenTextFile("tsk3S.txt",1,True)

do until reader.AtEndOfStream
	line = reader.readline
	v = split(line, ", ")
	cols = ubound(v)
	rows = rows + 1
loop

redim a(rows - 1, cols)
msgBox rows - 1
msgBox cols
reader.close
Set reader = fso.OpenTextFile("tsk3S.txt",1,True)
do until reader.AtEndOfStream
	line = reader.readline
	v = split(line, ", ")
	for j = lbound(v) to ubound(v)
		a(i,j) = v(j)
	next
	i = i + 1
loop
reader.close

dim fld, objWMIService, objComputer, objUser, objGroup
Set objComputer = GetObject("WinNT://LEGEND")
for i=0 to cols-1
	fld = a(1, i)
	MsgBox fld
	Set objGroup = objComputer.Create("group", fld)
	objGroup.SetInfo
next
for i=0 to cols-1
fld = a(2, i)
	MsgBox fld
	Set objUser = objComputer.Create("user",fld)
	objUser.SetInfo
next


Sub sharesec(Fname, shr, info, account, right, isgroup)
	Dim Services, SecDescClass, SecDesc, Trustee, ACE, Share, InParam, FolderName, AdminServer, ShareName
	FolderName = Fname 
	AdminServer = "\\" & strComputer
	ShareName = shr
	Set Services = GetObject("WINMGMTS:{impersonationLevel=impersonate,(Security)}!" & AdminServer & "\ROOT\CIMV2")
	Set SecDescClass = Services.Get("Win32_SecurityDescriptor")
	Set SecDesc = SecDescClass.SpawnInstance_()
	if isgroup then
		Set Trustee = SetGroupTrustee("ACME", account)
	else
		Set Trustee = SetAccountTrustee("ACME", account)
	end if
	Set ACE = Services.Get("Win32_Ace").SpawnInstance_
	select case right
		case "F"
			ACE.Properties_.Item("AccessMask") = 2032127
		case "M"
			ACE.Properties_.Item("AccessMask") = 1245631
		case "W"
			ACE.Properties_.Item("AccessMask") = 1180095
		case "RO"
			ACE.Properties_.Item("AccessMask") = 1179817
	end select
	
	ACE.Properties_.Item("AceFlags") = 3
	ACE.Properties_.Item("AceType") = 0
	ACE.Properties_.Item("Trustee") = Trustee
	SecDesc.Properties_.Item("DACL") = Array(ACE)
	Set Share = Services.Get("Win32_Share")
	Set InParam = Share.Methods_("Create").InParameters.SpawnInstance_()
	InParam.Properties_.Item("Access") = SecDesc
	InParam.Properties_.Item("Description") = "Public Share"
	InParam.Properties_.Item("Name") = ShareName
	InParam.Properties_.Item("Path") = FolderName
	InParam.Properties_.Item("Type") = 0
	Share.ExecMethod_ "Create", InParam
End Sub

Function SetAccountTrustee(strDomain, strName)
	set objTrustee = getObject("Winmgmts:{impersonationlevel=impersonate}!root/cimv2:Win32_Trustee").Spawninstance_
	set account = getObject("Winmgmts:{impersonationlevel=impersonate}!root/cimv2:Win32_Account.Name='" & strName & "',Domain='" & strDomain &"'")
	set accountSID = getObject("Winmgmts:{impersonationlevel=impersonate}!root/cimv2:Win32_SID.SID='" & account.SID &"'")
	objTrustee.Domain = strDomain
	objTrustee.Name = strName
	objTrustee.Properties_.item("SID") = accountSID.BinaryRepresentation
	set accountSID = nothing
	set account = nothing
	
	set SetAccountTrustee = objTrustee
End Function

Function SetGroupTrustee(strDomain, strName)
	Dim objTrustee
	Dim account
	Dim accountSID
	set objTrustee = getObject("Winmgmts:{impersonationlevel=impersonate}!root/cimv2:Win32_Trustee").Spawninstance_
	set account = getObject("Winmgmts:{impersonationlevel=impersonate}!root/cimv2:Win32_Group.Name='" & strName & "',Domain='" & strDomain &"'")
	set accountSID = getObject("Winmgmts:{impersonationlevel=impersonate}!root/cimv2:Win32_SID.SID='"& account.SID &"'")
	objTrustee.Domain = strDomain
	objTrustee.Name = strName
	objTrustee.Properties_.item("SID") = accountSID.BinaryRepresentation
	set accountSID = nothing
	set account = nothing
	
	set SetGroupTrustee = objTrustee
End Function